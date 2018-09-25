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
WITH cteValue AS ( 
    SELECT 
        cv.ObjectInstanceName, 
        cv.ObjectTypePropertyName, 
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
                'Exception Tracker - Gas Sales Pressure - Oil Differed - Day 7',
                'Exception Tracker - Gas Sales Pressure - Oil Differed',
                'Exception Tracker - Line Pressure - Oil Differed - Day 1',
                'Exception Tracker - Line Pressure - Oil Differed - Day 2',
                'Exception Tracker - Line Pressure - Oil Differed - Day 3',
                'Exception Tracker - Line Pressure - Oil Differed - Day 4',
                'Exception Tracker - Line Pressure - Oil Differed - Day 5',
                'Exception Tracker - Line Pressure - Oil Differed - Day 6',
                'Exception Tracker - Line Pressure - Oil Differed - Day 7',
                'Exception Tracker - Line Pressure - Oil Differed',
                'Exception Tracker - Fast Trips - Oil Differed - Day 1',
                'Exception Tracker - Fast Trips - Oil Differed - Day 2',
                'Exception Tracker - Fast Trips - Oil Differed - Day 3',
                'Exception Tracker - Fast Trips - Oil Differed - Day 4',
                'Exception Tracker - Fast Trips - Oil Differed - Day 5',
                'Exception Tracker - Fast Trips - Oil Differed - Day 6',
                'Exception Tracker - Fast Trips - Oil Differed - Day 7',
                'Exception Tracker - Fast Trips - Oil Differed',
                'Exception Tracker - Missed Oil Target - Oil Differed - Day 1',
                'Exception Tracker - Missed Oil Target - Oil Differed - Day 2',
                'Exception Tracker - Missed Oil Target - Oil Differed - Day 3',
                'Exception Tracker - Missed Oil Target - Oil Differed - Day 4',
                'Exception Tracker - Missed Oil Target - Oil Differed - Day 5',
                'Exception Tracker - Missed Oil Target - Oil Differed - Day 6',
                'Exception Tracker - Missed Oil Target - Oil Differed - Day 7',
                'Exception Tracker - Missed Oil Target - Oil Differed',
                'Exception Tracker - Missed Trips - Oil Differed - Day 1',
                'Exception Tracker - Missed Trips - Oil Differed - Day 2',
                'Exception Tracker - Missed Trips - Oil Differed - Day 3',
                'Exception Tracker - Missed Trips - Oil Differed - Day 4',
                'Exception Tracker - Missed Trips - Oil Differed - Day 5',
                'Exception Tracker - Missed Trips - Oil Differed - Day 6',
                'Exception Tracker - Missed Trips - Oil Differed - Day 7',
                'Exception Tracker - Missed Trips - Oil Differed',
                'Exception Tracker - Slow Trips - Oil Differed - Day 1',
                'Exception Tracker - Slow Trips - Oil Differed - Day 2',
                'Exception Tracker - Slow Trips - Oil Differed - Day 3',
                'Exception Tracker - Slow Trips - Oil Differed - Day 4',
                'Exception Tracker - Slow Trips - Oil Differed - Day 5',
                'Exception Tracker - Slow Trips - Oil Differed - Day 6',
                'Exception Tracker - Slow Trips - Oil Differed - Day 7',
                'Exception Tracker - Slow Trips - Oil Differed',
                'Exception Tracker - No Flow - Oil Differed - Day 1',
                'Exception Tracker - No Flow - Oil Differed - Day 2',
                'Exception Tracker - No Flow - Oil Differed - Day 3',
                'Exception Tracker - No Flow - Oil Differed - Day 4',
                'Exception Tracker - No Flow - Oil Differed - Day 5',
                'Exception Tracker - No Flow - Oil Differed - Day 6',
                'Exception Tracker - No Flow - Oil Differed - Day 7',
                'Exception Tracker - No Flow - Oil Differed'

            ))
)

-- Format and Pivot the internal table data for use by the Line Pressure dashboard
SELECT 
    ObjectInstanceName as WellName,
    CAST([Exception Tracker - Gas Sales Pressure - Oil Differed - Day 1] AS FLOAT) 
        AS GasSalesPressureDay1,
    CAST([Exception Tracker - Gas Sales Pressure - Oil Differed - Day 2] AS FLOAT) 
        AS GasSalesPressureDay2,
    CAST([Exception Tracker - Gas Sales Pressure - Oil Differed - Day 3] AS FLOAT) 
        AS GasSalesPressureDay3,
    CAST([Exception Tracker - Gas Sales Pressure - Oil Differed - Day 4] AS FLOAT) 
        AS GasSalesPressureDay4,
    CAST([Exception Tracker - Gas Sales Pressure - Oil Differed - Day 5] AS FLOAT) 
        AS GasSalesPressureDay5,
    CAST([Exception Tracker - Gas Sales Pressure - Oil Differed - Day 6] AS FLOAT) 
        AS GasSalesPressureDay6,
    CAST([Exception Tracker - Gas Sales Pressure - Oil Differed - Day 7] AS FLOAT) 
        AS GasSalesPressureDay7,
    CAST([Exception Tracker - Gas Sales Pressure - Oil Differed] AS FLOAT) 
        AS GasSalesPressure,
    CAST([Exception Tracker - Line Pressure - Oil Differed - Day 1] AS FLOAT) 
        AS LinePressureDay1,
    CAST([Exception Tracker - Line Pressure - Oil Differed - Day 2] AS FLOAT) 
        AS LinePressureDay2,
    CAST([Exception Tracker - Line Pressure - Oil Differed - Day 3] AS FLOAT) 
        AS LinePressureDay3,
    CAST([Exception Tracker - Line Pressure - Oil Differed - Day 4] AS FLOAT) 
        AS LinePressureDay4,
    CAST([Exception Tracker - Line Pressure - Oil Differed - Day 5] AS FLOAT) 
        AS LinePressureDay5,
    CAST([Exception Tracker - Line Pressure - Oil Differed - Day 6] AS FLOAT) 
        AS LinePressureDay6,
    CAST([Exception Tracker - Line Pressure - Oil Differed - Day 7] AS FLOAT) 
        AS LinePressureDay7,
    CAST([Exception Tracker - Line Pressure - Oil Differed] AS FLOAT)
        AS LinePressure,
    CAST([Exception Tracker - Fast Trips - Oil Differed - Day 1] AS FLOAT) 
        AS FastTripsDay1,
    CAST([Exception Tracker - Fast Trips - Oil Differed - Day 2] AS FLOAT) 
        AS FastTripsDay2,
    CAST([Exception Tracker - Fast Trips - Oil Differed - Day 3] AS FLOAT) 
        AS FastTripsDay3,
    CAST([Exception Tracker - Fast Trips - Oil Differed - Day 4] AS FLOAT) 
        AS FastTripsDay4,
    CAST([Exception Tracker - Fast Trips - Oil Differed - Day 5] AS FLOAT) 
        AS FastTripsDay5,
    CAST([Exception Tracker - Fast Trips - Oil Differed - Day 6] AS FLOAT) 
        AS FastTripsDay6,
    CAST([Exception Tracker - Fast Trips - Oil Differed - Day 7] AS FLOAT) 
        AS FastTripsDay7,
    CAST([Exception Tracker - Fast Trips - Oil Differed] AS FLOAT) 
        AS FastTrips,
    CAST([Exception Tracker - Missed Oil Target - Oil Differed - Day 1] AS FLOAT) 
        AS MissedOilTargetDay1,
    CAST([Exception Tracker - Missed Oil Target - Oil Differed - Day 2] AS FLOAT) 
        AS MissedOilTargetDay2,
    CAST([Exception Tracker - Missed Oil Target - Oil Differed - Day 3] AS FLOAT) 
        AS MissedOilTargetDay3,
    CAST([Exception Tracker - Missed Oil Target - Oil Differed - Day 4] AS FLOAT) 
        AS MissedOilTargetDay4,
    CAST([Exception Tracker - Missed Oil Target - Oil Differed - Day 5] AS FLOAT) 
        AS MissedOilTargetDay5,
    CAST([Exception Tracker - Missed Oil Target - Oil Differed - Day 6] AS FLOAT) 
        AS MissedOilTargetDay6,
    CAST([Exception Tracker - Missed Oil Target - Oil Differed - Day 7] AS FLOAT) 
        AS MissedOilTargetDay7,
    CAST([Exception Tracker - Missed Oil Target - Oil Differed] AS FLOAT) 
        AS MissedOilTarget,
    CAST([Exception Tracker - Missed Trips - Oil Differed - Day 1] AS FLOAT) 
        AS MissedTripsDay1,
    CAST([Exception Tracker - Missed Trips - Oil Differed - Day 2] AS FLOAT) 
        AS MissedTripsDay2,
    CAST([Exception Tracker - Missed Trips - Oil Differed - Day 3] AS FLOAT) 
        AS MissedTripsDay3,
    CAST([Exception Tracker - Missed Trips - Oil Differed - Day 4] AS FLOAT) 
        AS MissedTripsDay4,
    CAST([Exception Tracker - Missed Trips - Oil Differed - Day 5] AS FLOAT) 
        AS MissedTripsDay5,
    CAST([Exception Tracker - Missed Trips - Oil Differed - Day 6] AS FLOAT) 
        AS MissedTripsDay6,
    CAST([Exception Tracker - Missed Trips - Oil Differed - Day 7] AS FLOAT) 
        AS MissedTripsDay7,
    CAST([Exception Tracker - Missed Trips - Oil Differed] AS FLOAT) 
        AS MissedTrips,
    CAST([Exception Tracker - Slow Trips - Oil Differed - Day 1] AS FLOAT) 
        AS SlowTripsDay1,
    CAST([Exception Tracker - Slow Trips - Oil Differed - Day 2] AS FLOAT) 
        AS SlowTripsDay2,
    CAST([Exception Tracker - Slow Trips - Oil Differed - Day 3] AS FLOAT) 
        AS SlowTripsDay3,
    CAST([Exception Tracker - Slow Trips - Oil Differed - Day 4] AS FLOAT) 
        AS SlowTripsDay4,
    CAST([Exception Tracker - Slow Trips - Oil Differed - Day 5] AS FLOAT) 
        AS SlowTripsDay5,
    CAST([Exception Tracker - Slow Trips - Oil Differed - Day 6] AS FLOAT) 
        AS SlowTripsDay6,
    CAST([Exception Tracker - Slow Trips - Oil Differed - Day 7] AS FLOAT) 
        AS SlowTripsDay7,
    CAST([Exception Tracker - Slow Trips - Oil Differed] AS FLOAT) 
        AS SlowTrips,
    CAST([Exception Tracker - No Flow - Oil Differed - Day 1] AS FLOAT) 
        AS NoFlowDay1,
    CAST([Exception Tracker - No Flow - Oil Differed - Day 2] AS FLOAT) 
        AS NoFlowDay2,
    CAST([Exception Tracker - No Flow - Oil Differed - Day 3] AS FLOAT) 
        AS NoFlowDay3,
    CAST([Exception Tracker - No Flow - Oil Differed - Day 4] AS FLOAT) 
        AS NoFlowDay4,
    CAST([Exception Tracker - No Flow - Oil Differed - Day 5] AS FLOAT) 
        AS NoFlowDay5,
    CAST([Exception Tracker - No Flow - Oil Differed - Day 6] AS FLOAT) 
        AS NoFlowDay6,
    CAST([Exception Tracker - No Flow - Oil Differed - Day 7] AS FLOAT) 
        AS NoFlowDay7,
    CAST([Exception Tracker - No Flow - Oil Differed] AS FLOAT) 
        AS NoFlow
FROM 
    (SELECT * FROM cteValue) AS cv
        PIVOT (
            MAX(cv.CurrentValue)
            FOR cv.ObjectTypePropertyName IN 
            (
                [Exception Tracker - Gas Sales Pressure - Oil Differed - Day 1],
                [Exception Tracker - Gas Sales Pressure - Oil Differed - Day 2],
                [Exception Tracker - Gas Sales Pressure - Oil Differed - Day 3],
                [Exception Tracker - Gas Sales Pressure - Oil Differed - Day 4],
                [Exception Tracker - Gas Sales Pressure - Oil Differed - Day 5],
                [Exception Tracker - Gas Sales Pressure - Oil Differed - Day 6],
                [Exception Tracker - Gas Sales Pressure - Oil Differed - Day 7],
                [Exception Tracker - Gas Sales Pressure - Oil Differed],
                [Exception Tracker - Line Pressure - Oil Differed - Day 1],
                [Exception Tracker - Line Pressure - Oil Differed - Day 2],
                [Exception Tracker - Line Pressure - Oil Differed - Day 3],
                [Exception Tracker - Line Pressure - Oil Differed - Day 4],
                [Exception Tracker - Line Pressure - Oil Differed - Day 5],
                [Exception Tracker - Line Pressure - Oil Differed - Day 6],
                [Exception Tracker - Line Pressure - Oil Differed - Day 7],
                [Exception Tracker - Line Pressure - Oil Differed],
                [Exception Tracker - Fast Trips - Oil Differed - Day 1],
                [Exception Tracker - Fast Trips - Oil Differed - Day 2],
                [Exception Tracker - Fast Trips - Oil Differed - Day 3],
                [Exception Tracker - Fast Trips - Oil Differed - Day 4],
                [Exception Tracker - Fast Trips - Oil Differed - Day 5],
                [Exception Tracker - Fast Trips - Oil Differed - Day 6],
                [Exception Tracker - Fast Trips - Oil Differed - Day 7],
                [Exception Tracker - Fast Trips - Oil Differed],
                [Exception Tracker - Missed Oil Target - Oil Differed - Day 1],
                [Exception Tracker - Missed Oil Target - Oil Differed - Day 2],
                [Exception Tracker - Missed Oil Target - Oil Differed - Day 3],
                [Exception Tracker - Missed Oil Target - Oil Differed - Day 4],
                [Exception Tracker - Missed Oil Target - Oil Differed - Day 5],
                [Exception Tracker - Missed Oil Target - Oil Differed - Day 6],
                [Exception Tracker - Missed Oil Target - Oil Differed - Day 7],
                [Exception Tracker - Missed Oil Target - Oil Differed],
                [Exception Tracker - Missed Trips - Oil Differed - Day 1],
                [Exception Tracker - Missed Trips - Oil Differed - Day 2],
                [Exception Tracker - Missed Trips - Oil Differed - Day 3],
                [Exception Tracker - Missed Trips - Oil Differed - Day 4],
                [Exception Tracker - Missed Trips - Oil Differed - Day 5],
                [Exception Tracker - Missed Trips - Oil Differed - Day 6],
                [Exception Tracker - Missed Trips - Oil Differed - Day 7],
                [Exception Tracker - Missed Trips - Oil Differed],
                [Exception Tracker - Slow Trips - Oil Differed - Day 1],
                [Exception Tracker - Slow Trips - Oil Differed - Day 2],
                [Exception Tracker - Slow Trips - Oil Differed - Day 3],
                [Exception Tracker - Slow Trips - Oil Differed - Day 4],
                [Exception Tracker - Slow Trips - Oil Differed - Day 5],
                [Exception Tracker - Slow Trips - Oil Differed - Day 6],
                [Exception Tracker - Slow Trips - Oil Differed - Day 7],
                [Exception Tracker - Slow Trips - Oil Differed],
                [Exception Tracker - No Flow - Oil Differed - Day 1],
                [Exception Tracker - No Flow - Oil Differed - Day 2],
                [Exception Tracker - No Flow - Oil Differed - Day 3],
                [Exception Tracker - No Flow - Oil Differed - Day 4],
                [Exception Tracker - No Flow - Oil Differed - Day 5],
                [Exception Tracker - No Flow - Oil Differed - Day 6],
                [Exception Tracker - No Flow - Oil Differed - Day 7],
                [Exception Tracker - No Flow - Oil Differed]
            )
        ) AS pvt
ORDER BY ObjectInstanceName
