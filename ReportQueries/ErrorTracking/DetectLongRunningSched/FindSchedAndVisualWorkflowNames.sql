    SELECT 
        s.ScheduleId
        , s.ScheduleName
        , vwf.VisualWorkflowId
        , vwf.VisualWorkflowName
        , rank() over 
            (partition by vwfrh.VisualWorkflowId order by vwfrh.StartTime DESC) as RunHistory
        , DATEDIFF(second, vwfrh.StartTime, vwfrh.EndTime) AS RunDurationSec
    FROM IVMHistorical.ivm.VisualWorkflowRunHistory vwfrh
        inner join IVMConfig.ivm.VisualWorkflow vwf
        on vwf.VisualWorkflowId = vwfrh.VisualWorkflowId
        inner join IVMHistorical.ivm.ScheduleRunHistory srh
        on srh.ScheduleRunHistoryId = vwfrh.ScheduleRunHistoryId
        inner join IVMConfig.ivm.Schedule s
        on srh.ScheduleId = s.ScheduleId
    WHERE 
        vwfrh.StartTime > '2017/09/01' --@RunHistoryStartOffset 
        --AND [StartTime] < [EndTime]
        --AND ScheduleId = 1000027
