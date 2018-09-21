    SELECT 
        srh.ScheduleId 
        , srh.StartTime
        , srh.EndTime
        , DATEDIFF(second, [StartTime], [EndTime]) AS RunTimeSec
        , srh.HasError
        , rank() over 
            (partition by srh.ScheduleId order by srh.StartTime DESC) as RunHistory
    FROM IVMHistorical.ivm.ScheduleRunHistory srh
    WHERE 
        (srh.[StartTime] > (GETDATE() - 30))
        AND (srh.EndTime > srh.StartTime)
        AND (srh.[HasError] = 0)
        AND (srh.ScheduleId = 1000085)