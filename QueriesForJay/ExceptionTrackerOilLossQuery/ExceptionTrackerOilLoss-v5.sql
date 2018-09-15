/*
*********************************************************************************
* Source Name:  
*   ExceptionTrackerOilLoss.sql
*  
* Purpose:      
*   SQL Query used to retrieve and format numerous exception tracker properties
*   as they relate to Oil Loss (current values) by field.
*
* Data Source:
*   Production Surveillance
*        
* Author:
*   Robert Palumbo
*        
* Creation Date: 
*   09/11/2018
*        
*  Property of Anadarko Petroleum Corporation (APC)
* 
**********************************************************************************
*/

-- Perform the query to retrieve the requisite data
WITH cteValue1 AS ( 
    SELECT 
--        cv.ObjectInstanceName, 
        cv.ObjectTypePropertyName, 
--        cv.ObjectInstanceId,
        (select 'Day1' d) DayOfWeek,
        CASE IsString 
            WHEN 0 THEN COALESCE(cv.CurrentValue, '0') 
            ELSE COALESCE(cv.CurrentValue, '') 
        END AS CurrentValue
    FROM IVMPetexDP.ext.vw_CurrentValues cv
    WHERE 
        (cv.ObjectTypeId = 1000001) AND
        (cv.DataSourceName IN ('Production Surveillance') AND
            cv.ObjectTypePropertyName IN (
                'Exception Tracker - Gas Sales Pressure - Oil Differed - Day 1',
                'Exception Tracker - Gas Sales Pressure - Oil Differed - Day 2',
                'Exception Tracker - Gas Sales Pressure - Oil Differed - Day 3',
                'Exception Tracker - Gas Sales Pressure - Oil Differed - Day 4',
                'Exception Tracker - Gas Sales Pressure - Oil Differed - Day 5',
                'Exception Tracker - Gas Sales Pressure - Oil Differed - Day 6',
                'Exception Tracker - Gas Sales Pressure - Oil Differed - Day 7'
            ))
)
, cteValue2 AS ( 
    SELECT 
--        cv.ObjectInstanceName, 
        cv.ObjectTypePropertyName, 
--        cv.ObjectInstanceId,
        (select 'Day2') DayOfWeek,
        CASE IsString 
            WHEN 0 THEN COALESCE(cv.CurrentValue, '0') 
            ELSE COALESCE(cv.CurrentValue, '') 
        END AS CurrentValue
    FROM IVMPetexDP.ext.vw_CurrentValues cv
    WHERE 
        (cv.ObjectTypeId = 1000001) AND
        (cv.DataSourceName IN ('Production Surveillance') AND
            cv.ObjectTypePropertyName IN (
                'Exception Tracker - Line Pressure - Oil Differed - Day 1',
                'Exception Tracker - Line Pressure - Oil Differed - Day 2',
                'Exception Tracker - Line Pressure - Oil Differed - Day 3',
                'Exception Tracker - Line Pressure - Oil Differed - Day 4',
                'Exception Tracker - Line Pressure - Oil Differed - Day 5',
                'Exception Tracker - Line Pressure - Oil Differed - Day 6',
                'Exception Tracker - Line Pressure - Oil Differed - Day 7'
            ))
)
, cteValue3 AS ( 
    SELECT 
--        cv.ObjectInstanceName, 
        cv.ObjectTypePropertyName, 
--        cv.ObjectInstanceId,
        (select 'Day3') DayOfWeek,
        CASE IsString 
            WHEN 0 THEN COALESCE(cv.CurrentValue, '0') 
            ELSE COALESCE(cv.CurrentValue, '') 
        END AS CurrentValue
    FROM IVMPetexDP.ext.vw_CurrentValues cv
    WHERE 
        (cv.ObjectTypeId = 1000001) AND
        (cv.DataSourceName IN ('Production Surveillance') AND
            cv.ObjectTypePropertyName IN (
                'Exception Tracker - Fast Trips - Oil Differed - Day 1',
                'Exception Tracker - Fast Trips - Oil Differed - Day 2',
                'Exception Tracker - Fast Trips - Oil Differed - Day 3',
                'Exception Tracker - Fast Trips - Oil Differed - Day 4',
                'Exception Tracker - Fast Trips - Oil Differed - Day 5',
                'Exception Tracker - Fast Trips - Oil Differed - Day 6',
                'Exception Tracker - Fast Trips - Oil Differed - Day 7'
            ))
)
, cteFinal As (
    select 
        ObjectTypePropertyName, 
        DayOfWeek, 
        MAX(cv1.CurrentValue) as CurrentValue
    from 
        cteValue1 as cv1
    Group by 
        DayOfWeek, ObjectTypePropertyName
    union
    select 
        ObjectTypePropertyName, 
        DayOfWeek, 
        MAX(cv2.CurrentValue) as CurrentValue
    from 
        cteValue2 as cv2
    Group by 
        DayOfWeek, ObjectTypePropertyName
    union
    select 
        ObjectTypePropertyName, 
        DayOfWeek, 
        MAX(cv3.CurrentValue) as CurrentValue
    from 
        cteValue3 as cv3
    Group by 
        DayOfWeek, ObjectTypePropertyName
)
--, cteRename AS (
--    SELECT 
--        SQL#.RegEx_Replace(cvR.ObjectTypePropertyName, 
--            'Exception Tracker - No Flow',
--            'No Flow Exceptions', -1, 1, 'IgnoreCase') As PropertyName,
--        SQL#.RegEx_Replace(cvR.ObjectTypePropertyName, 
--            'Exception Tracker - Missed Oil Target',
--            'Missed Oil Target Exceptions',
--              -1, 1, 'IgnoreCase') As PropertyName2

--    FROM cteFinal as cvR
--)

select * from cteFinal


--SELECT 
--    --ObjectTypePropertyName, 
--    Day1, Day2, Day3
--FROM cteFinal AS cv
--    PIVOT (
--        MAX(cv.CurrentValue)
--        FOR DayOfWeek in ( Day1, Day2, Day3 )
--) As Pvt

--select * 
--from cteValue1 as cv
--    PIVOT (
--        MAX(cv.CurrentValue)
--        FOR DayOfWeek in ( Day1 )
--    ) as PVT

--select * 
--from cteValue2 as cv
--    PIVOT (
--        MAX(cv.CurrentValue)
--        FOR DayOfWeek in ( Day2 )
--    ) as PVT;


--,cteFinal AS (
        --SELECT *
        --    cteValue1.CurrentValue as Day1
        --        from cteValue1
        --UNION ALL
        --    SELECT * cteValue2.CurrentValue as Day2
        --        from cteValue2
        --UNION ALL
        --    SELECT * cteValue3.CurrentValue as Day3
        --        from cteValue3 


--select * from cteFinal

--SELECT 
--    cteValue1.CurrentValue as Day1,
--    cteValue2.CurrentValue as Day2,
--    cteValue3.CurrentValue as Day3
--FROM
--    cteValue1
--    inner join cteValue2 
--        on cteValue1.ObjectInstanceId = cteValue2.ObjectInstanceId
--    inner join cteValue3 
--        on cteValue2.ObjectInstanceId = cteValue3.ObjectInstanceId


---- Format and Pivot the internal table data for use by the Line Pressure dashboard
--SELECT 
--    ObjectInstanceName as WellName,
--    CAST([Exception Tracker - Gas Sales Pressure - Oil Differed - Day 1] AS FLOAT) 
--        AS GasSalesPressureDay1,
--    CAST([Exception Tracker - Line Pressure - Oil Differed - Day 1] AS FLOAT) 
--        AS LinePressureDay1,
--    CAST([Exception Tracker - Fast Trips - Oil Differed - Day 1] AS FLOAT) 
--        AS FastTripsDay1,
--    CAST([Exception Tracker - Missed Oil Target - Oil Differed - Day 1] AS FLOAT) 
--        AS MissedOilTargetDay1,
--    CAST([Exception Tracker - Missed Trips - Oil Differed - Day 1] AS FLOAT) 
--        AS MissedTripsDay1,
--    CAST([Exception Tracker - Slow Trips - Oil Differed - Day 1] AS FLOAT) 
--        AS SlowTripsDay1,
--    CAST([Exception Tracker - No Flow - Oil Differed - Day 1] AS FLOAT) 
--        AS NoFlowDay2
--FROM
--    (SELECT * FROM cteValue) AS cv
--    --    PIVOT (
--    --        MAX(cv.CurrentValue)
--    --        FOR cv.ObjectTypePropertyName IN 
--    --        (
--    --            [Exception Tracker - Gas Sales Pressure - Oil Differed - Day 1],
--    --            [Exception Tracker - Line Pressure - Oil Differed - Day 1],
--    --            [Exception Tracker - Fast Trips - Oil Differed - Day 1],
--    --            [Exception Tracker - Missed Oil Target - Oil Differed - Day 1],
--    --            [Exception Tracker - Missed Trips - Oil Differed - Day 1],
--    --            [Exception Tracker - Slow Trips - Oil Differed - Day 1],
--    --            [Exception Tracker - No Flow - Oil Differed - Day 2]
--    --        )
--    --    ) AS pvt
--ORDER BY ObjectInstanceName

    --(SELECT * FROM cteValue) AS cv
    --    PIVOT (
    --        MAX(cv.CurrentValue)
    --        FOR cv.ObjectTypePropertyName IN 
    --        (
    --            [Exception Tracker - Gas Sales Pressure - Oil Differed - Day 1],
    --            [Exception Tracker - Gas Sales Pressure - Oil Differed - Day 2],
    --            [Exception Tracker - Gas Sales Pressure - Oil Differed - Day 3],
    --            [Exception Tracker - Gas Sales Pressure - Oil Differed - Day 4],
    --            [Exception Tracker - Gas Sales Pressure - Oil Differed - Day 5],
    --            [Exception Tracker - Gas Sales Pressure - Oil Differed - Day 6],
    --            [Exception Tracker - Gas Sales Pressure - Oil Differed - Day 7],
    --            [Exception Tracker - Gas Sales Pressure - Oil Differed],
    --            [Exception Tracker - Line Pressure - Oil Differed - Day 1],
    --            [Exception Tracker - Line Pressure - Oil Differed - Day 2],
    --            [Exception Tracker - Line Pressure - Oil Differed - Day 3],
    --            [Exception Tracker - Line Pressure - Oil Differed - Day 4],
    --            [Exception Tracker - Line Pressure - Oil Differed - Day 5],
    --            [Exception Tracker - Line Pressure - Oil Differed - Day 6],
    --            [Exception Tracker - Line Pressure - Oil Differed - Day 7],
    --            [Exception Tracker - Line Pressure - Oil Differed],
    --            [Exception Tracker - Fast Trips - Oil Differed - Day 1],
    --            [Exception Tracker - Fast Trips - Oil Differed - Day 2],
    --            [Exception Tracker - Fast Trips - Oil Differed - Day 3],
    --            [Exception Tracker - Fast Trips - Oil Differed - Day 4],
    --            [Exception Tracker - Fast Trips - Oil Differed - Day 5],
    --            [Exception Tracker - Fast Trips - Oil Differed - Day 6],
    --            [Exception Tracker - Fast Trips - Oil Differed - Day 7],
    --            [Exception Tracker - Fast Trips - Oil Differed],
    --            [Exception Tracker - Missed Oil Target - Oil Differed - Day 1],
    --            [Exception Tracker - Missed Oil Target - Oil Differed - Day 2],
    --            [Exception Tracker - Missed Oil Target - Oil Differed - Day 3],
    --            [Exception Tracker - Missed Oil Target - Oil Differed - Day 4],
    --            [Exception Tracker - Missed Oil Target - Oil Differed - Day 5],
    --            [Exception Tracker - Missed Oil Target - Oil Differed - Day 6],
    --            [Exception Tracker - Missed Oil Target - Oil Differed - Day 7],
    --            [Exception Tracker - Missed Oil Target - Oil Differed],
    --            [Exception Tracker - Missed Trips - Oil Differed - Day 1],
    --            [Exception Tracker - Missed Trips - Oil Differed - Day 2],
    --            [Exception Tracker - Missed Trips - Oil Differed - Day 3],
    --            [Exception Tracker - Missed Trips - Oil Differed - Day 4],
    --            [Exception Tracker - Missed Trips - Oil Differed - Day 5],
    --            [Exception Tracker - Missed Trips - Oil Differed - Day 6],
    --            [Exception Tracker - Missed Trips - Oil Differed - Day 7],
    --            [Exception Tracker - Missed Trips - Oil Differed],
    --            [Exception Tracker - Slow Trips - Oil Differed - Day 1],
    --            [Exception Tracker - Slow Trips - Oil Differed - Day 2],
    --            [Exception Tracker - Slow Trips - Oil Differed - Day 3],
    --            [Exception Tracker - Slow Trips - Oil Differed - Day 4],
    --            [Exception Tracker - Slow Trips - Oil Differed - Day 5],
    --            [Exception Tracker - Slow Trips - Oil Differed - Day 6],
    --            [Exception Tracker - Slow Trips - Oil Differed - Day 7],
    --            [Exception Tracker - Slow Trips - Oil Differed],
    --            [Exception Tracker - No Flow - Oil Differed - Day 1],
    --            [Exception Tracker - No Flow - Oil Differed - Day 2],
    --            [Exception Tracker - No Flow - Oil Differed - Day 3],
    --            [Exception Tracker - No Flow - Oil Differed - Day 4],
    --            [Exception Tracker - No Flow - Oil Differed - Day 5],
    --            [Exception Tracker - No Flow - Oil Differed - Day 6],
    --            [Exception Tracker - No Flow - Oil Differed - Day 7],
    --            [Exception Tracker - No Flow - Oil Differed]
    --        )
    --    ) AS pvt
