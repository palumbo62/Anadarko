DECLARE @DayOffset AS INT = 30
DECLARE @RunHistoryStartOffset AS DATETIME = (GETDATE() - @DayOffset)
DECLARE @StdDevFactor AS INT = 2
DECLARE @StdDevLabel AS VARCHAR(16)

SET @StdDevLabel = 'StdDevX' + CAST(@StdDevFactor AS char)
SELECT  @DayOffset, @RunHistoryStartOffset, @StdDevFactor, @StdDevLabel;

WITH cte1 AS (
    SELECT 
        srh.ScheduleId 
        ,srh.StartTime
        ,srh.EndTime
        ,DATEDIFF(second, [StartTime], [EndTime]) AS RunTimeSec
        ,srh.HasError
        ,rank() over 
            (partition by srh.ScheduleId order by srh.StartTime DESC) as RunHistory
    FROM IVMHistorical.ivm.ScheduleRunHistory srh
    WHERE 
        (srh.[StartTime] > @RunHistoryStartOffset)
        AND (srh.EndTime > srh.StartTime)
        AND (srh.[HasError] = 0)
)
, cte2 AS (
    SELECT 
        cv.ScheduleId AS SchedId
        ,COUNT (*) AS TotalRuns
        ,MIN(cv.RunTimeSec) AS MinRunTime
        ,MAX(cv.RunTimeSec) AS MaxRunTime
        ,AVG(cv.RunTimeSec) AS AvgRunTime
        ,STDEV(cv.RunTimeSec) AS RunTimeStdDev
    FROM
        cte1 cv
    GROUP BY
        cv.ScheduleId
    HAVING COUNT(*) > 1
) 
, cte3 AS (
    SELECT
        cv2.SchedId AS SchedId
        ,s.ScheduleName
        ,cv2.TotalRuns AS TotalRuns
        ,cv1.StartTime AS StartTime
        ,cv1.EndTime AS EndTime
        ,cv1.RunTimeSec AS RunTime
        ,cv2.MinRunTime AS MinRunTime
        ,cv2.MaxRunTime AS MaxRunTime
        ,cv2.AvgRunTime AS AvgRunTime
        ,cv2.RunTimeStdDev AS StdDev
        ,(cv2.AvgRunTime + (cv2.RunTimeStdDev * @StdDevFactor)) AS MaxStdDev
    FROM
        cte2 cv2 
        INNER JOIN cte1 cv1
            ON cv2.SchedId = cv1.ScheduleId
        INNER JOIN IVMConfig.ivm.Schedule s
            ON s.ScheduleId = cv2.SchedId
    WHERE
        (cv1.RunTimeSec > (cv2.AvgRunTime + (cv2.RunTimeStdDev * @StdDevFactor)))
)
SELECT 
    cv.SchedId AS SchedId
    ,MAX(cv.ScheduleName) AS SchedName
    ,COUNT(*) AS TotalAnomalyRuns
    ,MAX(cv.TotalRuns) AS AllSchedRuns
    ,AVG(cv.RunTime) AS AvgAnomalyRunTime
    ,MAX(cv.AvgRunTime) AS AvgSchedRunTime
    ,MAX(cv.StdDev) AS '1-StdDev'
    ,@StdDevLabel
    ,MAX(cv.MaxStdDev) AS ErrThreshold
FROM 
    cte3 cv
GROUP BY
    cv.SchedId
ORDER BY
    cv.SchedId
