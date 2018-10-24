/*
*********************************************************************************
* Source Name:  
*   ExceptionTrackerOilLossByDayOfWeek.sql
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
        ROW_NUMBER() OVER(ORDER BY cv.ObjectTypePropertyName) AS DayOfWeek,
        cv.ObjectTypePropertyName, 
        cv.LastGoodSampleTime AS SampleTime,
        (select 'Gas Sales Pressure') PropertyName,
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
        ROW_NUMBER() OVER(ORDER BY cv.ObjectTypePropertyName) AS DayOfWeek,
        cv.ObjectTypePropertyName, 
        cv.LastGoodSampleTime AS SampleTime,
        (select 'Line Pressure') AS PropertyName,
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
        (ROW_NUMBER() OVER(ORDER BY cv.ObjectTypePropertyName) ) AS DayOfWeek,
        cv.ObjectTypePropertyName, 
        cv.LastGoodSampleTime AS SampleTime,
        (select 'Fast Trips') AS PropertyName,
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
, cteValue4 AS ( 
    SELECT 
        (ROW_NUMBER() OVER(ORDER BY cv.ObjectTypePropertyName) ) AS DayOfWeek,
        cv.ObjectTypePropertyName, 
        cv.LastGoodSampleTime AS SampleTime,
        (select 'Missed Oil Target') AS PropertyName,
        CASE IsString 
            WHEN 0 THEN COALESCE(cv.CurrentValue, '0') 
            ELSE COALESCE(cv.CurrentValue, '') 
        END AS CurrentValue
    FROM IVMPetexDP.ext.vw_CurrentValues cv
    WHERE 
        (cv.ObjectTypeId = 1000001) AND
        (cv.DataSourceName IN ('Production Surveillance') AND
            cv.ObjectTypePropertyName IN (
                'Exception Tracker - Missed Oil Target - Oil Differed - Day 1',
                'Exception Tracker - Missed Oil Target - Oil Differed - Day 2',
                'Exception Tracker - Missed Oil Target - Oil Differed - Day 3',
                'Exception Tracker - Missed Oil Target - Oil Differed - Day 4',
                'Exception Tracker - Missed Oil Target - Oil Differed - Day 5',
                'Exception Tracker - Missed Oil Target - Oil Differed - Day 6',
                'Exception Tracker - Missed Oil Target - Oil Differed - Day 7'
            ))
)
, cteValue5 AS ( 
    SELECT 
        (ROW_NUMBER() OVER(ORDER BY cv.ObjectTypePropertyName) ) AS DayOfWeek,
        cv.ObjectTypePropertyName, 
        cv.LastGoodSampleTime AS SampleTime,
        (select 'Missed Trips') AS PropertyName,
        CASE IsString 
            WHEN 0 THEN COALESCE(cv.CurrentValue, '0') 
            ELSE COALESCE(cv.CurrentValue, '') 
        END AS CurrentValue
    FROM IVMPetexDP.ext.vw_CurrentValues cv
    WHERE 
        (cv.ObjectTypeId = 1000001) AND
        (cv.DataSourceName IN ('Production Surveillance') AND
            cv.ObjectTypePropertyName IN (
                'Exception Tracker - Missed Trips - Oil Differed - Day 1',
                'Exception Tracker - Missed Trips - Oil Differed - Day 2',
                'Exception Tracker - Missed Trips - Oil Differed - Day 3',
                'Exception Tracker - Missed Trips - Oil Differed - Day 4',
                'Exception Tracker - Missed Trips - Oil Differed - Day 5',
                'Exception Tracker - Missed Trips - Oil Differed - Day 6',
                'Exception Tracker - Missed Trips - Oil Differed - Day 7'
            ))
)
, cteValue6 AS ( 
    SELECT 
        (ROW_NUMBER() OVER(ORDER BY cv.ObjectTypePropertyName) ) AS DayOfWeek,
        cv.ObjectTypePropertyName, 
        cv.LastGoodSampleTime AS SampleTime,
        (select 'Slow Trips') AS PropertyName,
        CASE IsString 
            WHEN 0 THEN COALESCE(cv.CurrentValue, '0') 
            ELSE COALESCE(cv.CurrentValue, '') 
        END AS CurrentValue
    FROM IVMPetexDP.ext.vw_CurrentValues cv
    WHERE 
        (cv.ObjectTypeId = 1000001) AND
        (cv.DataSourceName IN ('Production Surveillance') AND
            cv.ObjectTypePropertyName IN (
                'Exception Tracker - Slow Trips - Oil Differed - Day 1',
                'Exception Tracker - Slow Trips - Oil Differed - Day 2',
                'Exception Tracker - Slow Trips - Oil Differed - Day 3',
                'Exception Tracker - Slow Trips - Oil Differed - Day 4',
                'Exception Tracker - Slow Trips - Oil Differed - Day 5',
                'Exception Tracker - Slow Trips - Oil Differed - Day 6',
                'Exception Tracker - Slow Trips - Oil Differed - Day 7'
            ))
)
, cteValue7 AS ( 
    SELECT 
        (ROW_NUMBER() OVER(ORDER BY cv.ObjectTypePropertyName) ) AS DayOfWeek,
        cv.ObjectTypePropertyName, 
        cv.LastGoodSampleTime AS SampleTime,
        (select 'No Flow') AS PropertyName,
        CASE IsString 
            WHEN 0 THEN COALESCE(cv.CurrentValue, '0') 
            ELSE COALESCE(cv.CurrentValue, '') 
        END AS CurrentValue
    FROM IVMPetexDP.ext.vw_CurrentValues cv
    WHERE 
        (cv.ObjectTypeId = 1000001) AND
        (cv.DataSourceName IN ('Production Surveillance') AND
            cv.ObjectTypePropertyName IN (
                'Exception Tracker - No Flow - Oil Differed - Day 1',
                'Exception Tracker - No Flow - Oil Differed - Day 2',
                'Exception Tracker - No Flow - Oil Differed - Day 3',
                'Exception Tracker - No Flow - Oil Differed - Day 4',
                'Exception Tracker - No Flow - Oil Differed - Day 5',
                'Exception Tracker - No Flow - Oil Differed - Day 6',
                'Exception Tracker - No Flow - Oil Differed - Day 7'
            ))
)

SELECT 
    --(ROW_NUMBER() OVER(ORDER BY cv1.PropertyName)) AS DayOfWeek, 
    --convert(varchar, DATEADD(DAY, -1, cv1.SampleTime), 101) AS Date,
    convert(varchar, cv1.SampleTime, 101) AS Date,

    cv1.CurrentValue AS 'Gas Sales Pressure',
    cv2.CurrentValue AS 'Line Pressure',
    cv3.CurrentValue AS 'Fast Trips',
    cv4.CurrentValue AS 'Missed Oil Target',
    cv5.CurrentValue AS 'Missed Trips',
    cv6.CurrentValue AS 'Slow Trips',
    cv7.CurrentValue AS 'No Flow'
FROM cteValue1 cv1
    INNER JOIN cteValue2 cv2
        ON cv1.DayOfWeek = cv2.DayOfWeek
    INNER JOIN cteValue3 cv3
        ON cv1.DayOfWeek = cv3.DayOfWeek
    INNER JOIN cteValue4 cv4
        ON cv1.DayOfWeek = cv4.DayOfWeek
    INNER JOIN cteValue5 cv5
        ON cv1.DayOfWeek = cv5.DayOfWeek
    INNER JOIN cteValue6 cv6
        ON cv1.DayOfWeek = cv6.DayOfWeek
    INNER JOIN cteValue7 cv7
        ON cv1.DayOfWeek = cv7.DayOfWeek
