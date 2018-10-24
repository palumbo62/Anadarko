SELECT DISTINCT 
Schedule.ScheduleName,


       VisualWorkflow.VisualWorkflowName
FROM (IVMConfig.ivm.ScheduleAction ScheduleAction
      INNER JOIN IVMConfig.ivm.Schedule Schedule
         ON (ScheduleAction.ScheduleId = Schedule.ScheduleId))
     INNER JOIN IVMConfig.ivm.VisualWorkflow VisualWorkflow
        ON (ScheduleAction.ItemId = VisualWorkflow.VisualWorkflowId)
WHERE (ScheduleAction.ScheduleActionType = 0) and Schedule.IsActive = 1
