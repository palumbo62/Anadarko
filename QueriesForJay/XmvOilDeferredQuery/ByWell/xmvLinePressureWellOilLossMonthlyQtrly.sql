/*
*********************************************************************************
* Source Name:  
*   xmvLinePressureWellOilLossMonthlyQtrly.sql
*  
* Purpose:      
*   SQL Query used to retrieve and format XMV Line Pressure Oil Loss  
*   (current values) monthly and quarterly for all wells.
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
        (cv.ObjectTypeId = 1000000) AND
        (cv.DataSourceName IN ('Production Surveillance') AND
            cv.ObjectTypePropertyName IN (
                'Summary - XMV Pressure - Oil Deferred - Cumulative - Jan',
                'Summary - XMV Pressure - Oil Deferred - Cumulative - Feb',
                'Summary - XMV Pressure - Oil Deferred - Cumulative - Mar',
                'Summary - XMV Pressure - Oil Deferred - Cumulative - Apr',
                'Summary - XMV Pressure - Oil Deferred - Cumulative - May',
                'Summary - XMV Pressure - Oil Deferred - Cumulative - Jun',
                'Summary - XMV Pressure - Oil Deferred - Cumulative - Jul',
                'Summary - XMV Pressure - Oil Deferred - Cumulative - Aug',
                'Summary - XMV Pressure - Oil Deferred - Cumulative - Sep',
                'Summary - XMV Pressure - Oil Deferred - Cumulative - Oct',
                'Summary - XMV Pressure - Oil Deferred - Cumulative - Nov',
                'Summary - XMV Pressure - Oil Deferred - Cumulative - Dec',
                'Summary - XMV Pressure - Oil Deferred - Cumulative - Q1',
                'Summary - XMV Pressure - Oil Deferred - Cumulative - Q2',
                'Summary - XMV Pressure - Oil Deferred - Cumulative - Q3',
                'Summary - XMV Pressure - Oil Deferred - Cumulative - Q4'
            ))
)

-- Format and Pivot the internal table data for use by the Line Pressure dashboard
SELECT 
    ObjectInstanceName as WellName,
    CAST([Summary - XMV Pressure - Oil Deferred - Cumulative - Jan] AS FLOAT) 
        AS XmvOilDeferJan,
    CAST([Summary - XMV Pressure - Oil Deferred - Cumulative - Feb] AS FLOAT) 
        AS XmvOilDeferFeb,
    CAST([Summary - XMV Pressure - Oil Deferred - Cumulative - Mar] AS FLOAT) 
        AS XmvOilDeferMar,
    CAST([Summary - XMV Pressure - Oil Deferred - Cumulative - Apr] AS FLOAT) 
        AS XmvOilDeferApr,
    CAST([Summary - XMV Pressure - Oil Deferred - Cumulative - May] AS FLOAT) 
        AS XmvOilDeferMay,
    CAST([Summary - XMV Pressure - Oil Deferred - Cumulative - Jun] AS FLOAT) 
        AS XmvOilDeferJun,
    CAST([Summary - XMV Pressure - Oil Deferred - Cumulative - Jul] AS FLOAT) 
        AS XmvOilDeferJul,
    CAST([Summary - XMV Pressure - Oil Deferred - Cumulative - Aug] AS FLOAT) 
        AS XmvOilDeferAug,
    CAST([Summary - XMV Pressure - Oil Deferred - Cumulative - Sep] AS FLOAT) 
        AS XmvOilDeferSep,
    CAST([Summary - XMV Pressure - Oil Deferred - Cumulative - Oct] AS FLOAT) 
        AS XmvOilDeferOct,
    CAST([Summary - XMV Pressure - Oil Deferred - Cumulative - Nov] AS FLOAT) 
        AS XmvOilDeferNov,
    CAST([Summary - XMV Pressure - Oil Deferred - Cumulative - Dec] AS FLOAT) 
        AS XmvOilDeferDec,
    CAST([Summary - XMV Pressure - Oil Deferred - Cumulative - Q1] AS FLOAT) 
        AS XmvOilDeferQ1,
    CAST([Summary - XMV Pressure - Oil Deferred - Cumulative - Q2] AS FLOAT) 
        AS XmvOilDeferQ2,
    CAST([Summary - XMV Pressure - Oil Deferred - Cumulative - Q3] AS FLOAT) 
        AS XmvOilDeferQ3,
    CAST([Summary - XMV Pressure - Oil Deferred - Cumulative - Q4] AS FLOAT) 
        AS XmvOilDeferQ4
FROM 
    (SELECT * FROM cteValue) AS cv
        PIVOT (
            MAX(cv.CurrentValue)
            FOR cv.ObjectTypePropertyName IN 
            (
                [Summary - XMV Pressure - Oil Deferred - Cumulative - Jan],
                [Summary - XMV Pressure - Oil Deferred - Cumulative - Feb],
                [Summary - XMV Pressure - Oil Deferred - Cumulative - Mar],
                [Summary - XMV Pressure - Oil Deferred - Cumulative - Apr],
                [Summary - XMV Pressure - Oil Deferred - Cumulative - May],
                [Summary - XMV Pressure - Oil Deferred - Cumulative - Jun],
                [Summary - XMV Pressure - Oil Deferred - Cumulative - Jul],
                [Summary - XMV Pressure - Oil Deferred - Cumulative - Aug],
                [Summary - XMV Pressure - Oil Deferred - Cumulative - Sep],
                [Summary - XMV Pressure - Oil Deferred - Cumulative - Oct],
                [Summary - XMV Pressure - Oil Deferred - Cumulative - Nov],
                [Summary - XMV Pressure - Oil Deferred - Cumulative - Dec],
                [Summary - XMV Pressure - Oil Deferred - Cumulative - Q1],
                [Summary - XMV Pressure - Oil Deferred - Cumulative - Q2],
                [Summary - XMV Pressure - Oil Deferred - Cumulative - Q3],
                [Summary - XMV Pressure - Oil Deferred - Cumulative - Q4]
            )
        ) AS pvt
ORDER BY ObjectInstanceName
