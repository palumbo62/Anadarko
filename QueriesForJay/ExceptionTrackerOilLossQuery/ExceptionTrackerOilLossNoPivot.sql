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
 select * from cteValue

