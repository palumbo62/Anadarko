with error_table as 
(
	SELECT ScheduleId, Max(ErrorExists) AS ErrorExists
	FROM (SELECT ScheduleRunHistory.ScheduleId,
		rank() over (partition by ScheduleRunHistory.ScheduleId order by ScheduleRunHistory.StartTime DESC) as rowindex,
			cast(ScheduleRunHistory.HasError as int) as ErrorExists
	FROM IVMHistorical.ivm.ScheduleRunHistory ScheduleRunHistory
	WHERE ScheduleRunHistory.StartTime > GETUTCDATE() - 1) as row_table
	WHERE rowindex < 4
	GROUP BY ScheduleId),
	last_run as 
	(SELECT Schedule_History.ScheduleId,  Max(Schedule_History.StartTime) as last_run_date
	FROM IVMHistorical.ivm.ScheduleRunHistory Schedule_History
	WHERE Schedule_History.EndTime > Schedule_History.StartTime and Schedule_History.StartTime > GETUTCDATE()-5
	GROUP BY Schedule_History.ScheduleId)

	SELECT 
			CASE WHEN error_table.ErrorExists = 1 THEN Schedule_1.ScheduleName + CAST(' failed in the past day.' AS nvarchar(50))
					ELSE Schedule_1.ScheduleName + CAST(' has not ran since ' AS nvarchar(50)) + CAST(Schedule.LastRunDate AS nvarchar(50)) + CAST('.' AS nvarchar(50))
					END AS email_message,
			CASE WHEN error_table.ErrorExists = 1 THEN '_' + Schedule_1.ScheduleName + CAST('_ failed in the past day.' AS nvarchar(50))
					ELSE '_' + Schedule_1.ScheduleName + CAST('_ has not ran since ' AS nvarchar(50)) + CAST(Schedule.LastRunDate AS nvarchar(50)) + CAST('.' AS nvarchar(50))
					END AS slack_message
	FROM (IVMLocalMachine.ivm.Schedule Schedule
			INNER JOIN IVMConfig.ivm.Schedule Schedule_1
				ON (Schedule.ScheduleId = Schedule_1.ScheduleId))
			INNER JOIN IVMConfig.ivm.ScheduleTrigger ScheduleTrigger
			ON (ScheduleTrigger.ScheduleId = Schedule_1.ScheduleId)
			INNER JOIN error_table ON error_table.ScheduleId = Schedule.ScheduleId
			INNER JOIN last_run ON Schedule.ScheduleId = last_run.ScheduleId
	WHERE Schedule.IsActive = 1 AND ScheduleTrigger.IsActive = 1 
			and ((error_table.ErrorExists = 1 and last_run.last_run_date < GETUTCDATE()-0.05) 
			OR last_run.last_run_date < GETUTCDATE()-1)