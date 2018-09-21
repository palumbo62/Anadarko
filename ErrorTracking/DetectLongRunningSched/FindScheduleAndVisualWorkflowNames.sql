SELECT 
    s.ScheduleId
    ,s.ScheduleName
    ,vwf.VisualWorkflowId
    ,vwf.VisualWorkflowName
FROM 
    IVMConfig.ivm.Schedule s
    INNER JOIN IVMHistorical.ivm.ScheduleRunHistory srh
        ON s.ScheduleId = srh.ScheduleId
    INNER JOIN IVMHistorical.ivm.VisualWorkflowRunHistory vwrh
        ON srh.ScheduleRunHistoryId = vwrh.ScheduleRunHistoryId
    INNER JOIN IVMConfig.ivm.VisualWorkflow vwf
        ON vwrh.VisualWorkflowId = vwf.VisualWorkflowId
;

SELECT 
    s.ScheduleId
    ,s.ScheduleName
FROM 
    IVMConfig.ivm.Schedule s
