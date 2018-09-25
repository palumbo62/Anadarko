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
SELECT
    s.ScheduleId
    ,MAX(s.ScheduleName) AS ScheduleName
    ,COUNT(*) AS 'TotalRuns-Anomaly'
    ,MAX(cv2.TotalRuns) AS 'TotalRuns-AllScheds'
    ,AVG(cv1.RunTimeSec) AS 'AvgRunTime-Anomaly'
    ,MAX(cv2.AvgRunTime) AS 'AvgRunTime-AllRuns'
    ,MAX(cv2.RunTimeStdDev) AS '1-StdDev'
    ,@StdDevLabel AS 'StdDev-Factor'
    ,MAX(cv2.AvgRunTime + (cv2.RunTimeStdDev * @StdDevFactor)) AS ErrThreshold
FROM
    cte2 cv2 
    INNER JOIN cte1 cv1
        ON cv2.SchedId = cv1.ScheduleId
    INNER JOIN IVMConfig.ivm.Schedule s
        ON s.ScheduleId = cv2.SchedId
WHERE
    (cv1.RunTimeSec > (cv2.AvgRunTime + (cv2.RunTimeStdDev * @StdDevFactor)))
GROUP BY
    s.ScheduleId
ORDER BY
    s.ScheduleId
