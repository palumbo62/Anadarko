/*
*********************************************************************************
*  Source Name:  
*        WeeklyExceptionTracker,sql
*  
*  Purpose:      
*        SQL Query used to retrieve an format data for the Weekly Exception
*        Tracler IOC dashboard.
*        
*  Author:
*        Robert Palumbo
*        
*  Date: 
*        08/09/2018
*        
*  Property of Anadarko Petroleum Corporation (APC)
* 
**********************************************************************************
*/

-- Perform the query to retrieve the requisite Line Pressure data
WITH cteValue AS ( 
    SELECT v.ObjectInstanceName, v.ObjectTypePropertyName, 
        CASE IsString 
            WHEN 0 THEN COALESCE(v.CurrentValue, '0') 
            ELSE COALESCE(v.CurrentValue, '') 
        END AS CurrentValue
    FROM IVMPetexDP.ext.vw_CurrentValues v
    WHERE v.ObjectTypeId = 1000000
            AND ((v.DataSourceName IN ('Production Surveillance') AND
                  v.ObjectTypePropertyName IN (
                                                'Exception Tracker - Line Pressure - Oil Differed - Day 1',
                                                'Exception Tracker - Line Pressure - Oil Differed - Day 2',
                                                'Exception Tracker - Line Pressure - Oil Differed - Day 3',
                                                'Exception Tracker - Line Pressure - Oil Differed - Day 4',
                                                'Exception Tracker - Line Pressure - Oil Differed - Day 5',
                                                'Exception Tracker - Line Pressure - Oil Differed - Day 6',
                                                'Exception Tracker - Line Pressure - Oil Differed - Day 7',
                                                'Exception Tracker - Line Pressure - Oil Differed',
                                                'Exception Tracker - Line Pressure - Oil Revenue Differed - Day 1',
                                                'Exception Tracker - Line Pressure - Oil Revenue Differed - Day 2',
                                                'Exception Tracker - Line Pressure - Oil Revenue Differed - Day 3',
                                                'Exception Tracker - Line Pressure - Oil Revenue Differed - Day 4',
                                                'Exception Tracker - Line Pressure - Oil Revenue Differed - Day 5',
                                                'Exception Tracker - Line Pressure - Oil Revenue Differed - Day 6',
                                                'Exception Tracker - Line Pressure - Oil Revenue Differed - Day 7',
                                                'Exception Tracker - Line Pressure - Oil Revenue Differed',
                                                'Exception Tracker - Gas Sales Pressure Indicator',
                                                'Exception Tracker - Line Pressure Indicator',
                                                'HF Production Tracker - Oil Target Highest'
                                               )))
)

-- Format and Pivot the internal table data for use by the Line Pressure dashboard
SELECT ObjectInstanceName,
       CAST([Exception Tracker - Line Pressure - Oil Differed - Day 1] AS FLOAT) AS LinePressOilDiffDay1,
       CAST([Exception Tracker - Line Pressure - Oil Differed - Day 2] AS FLOAT) AS LinePressOilDiffDay2,
       CAST([Exception Tracker - Line Pressure - Oil Differed - Day 3] AS FLOAT) AS LinePressOilDiffDay3,
       CAST([Exception Tracker - Line Pressure - Oil Differed - Day 4] AS FLOAT) AS LinePressOilDiffDay4,
       CAST([Exception Tracker - Line Pressure - Oil Differed - Day 5] AS FLOAT) AS LinePressOilDiffDay5,
       CAST([Exception Tracker - Line Pressure - Oil Differed - Day 6] AS FLOAT) AS LinePressOilDiffDay6,
       CAST([Exception Tracker - Line Pressure - Oil Differed - Day 7] AS FLOAT) AS LinePressOilDiffDay7,
       CAST([Exception Tracker - Line Pressure - Oil Differed] AS FLOAT) AS OilDiffered,
       CAST([Exception Tracker - Line Pressure - Oil Revenue Differed - Day 1] AS FLOAT) AS LinePressRevDiffDay1,
       CAST([Exception Tracker - Line Pressure - Oil Revenue Differed - Day 2] AS FLOAT) AS LinePressRevDiffDay2,
       CAST([Exception Tracker - Line Pressure - Oil Revenue Differed - Day 3] AS FLOAT) AS LinePressRevDiffDay3,
       CAST([Exception Tracker - Line Pressure - Oil Revenue Differed - Day 4] AS FLOAT) AS LinePressRevDiffDay4,
       CAST([Exception Tracker - Line Pressure - Oil Revenue Differed - Day 5] AS FLOAT) AS LinePressRevDiffDay5,
       CAST([Exception Tracker - Line Pressure - Oil Revenue Differed - Day 6] AS FLOAT) AS LinePressRevDiffDay6,
       CAST([Exception Tracker - Line Pressure - Oil Revenue Differed - Day 7] AS FLOAT) AS LinePressRevDiffDay7,
       CAST([Exception Tracker - Line Pressure - Oil Revenue Differed] AS FLOAT) AS RevDiffered
FROM (SELECT * FROM cteValue) AS v
PIVOT (
    MAX(v.CurrentValue)
    FOR v.ObjectTypePropertyName IN 
        (
         [Exception Tracker - Line Pressure - Oil Differed - Day 1],
         [Exception Tracker - Line Pressure - Oil Differed - Day 2],
         [Exception Tracker - Line Pressure - Oil Differed - Day 3],
         [Exception Tracker - Line Pressure - Oil Differed - Day 4],
         [Exception Tracker - Line Pressure - Oil Differed - Day 5],
         [Exception Tracker - Line Pressure - Oil Differed - Day 6],
         [Exception Tracker - Line Pressure - Oil Differed - Day 7],
         [Exception Tracker - Line Pressure - Oil Differed],
         [Exception Tracker - Line Pressure - Oil Revenue Differed - Day 1],
         [Exception Tracker - Line Pressure - Oil Revenue Differed - Day 2],
         [Exception Tracker - Line Pressure - Oil Revenue Differed - Day 3],
         [Exception Tracker - Line Pressure - Oil Revenue Differed - Day 4],
         [Exception Tracker - Line Pressure - Oil Revenue Differed - Day 5],
         [Exception Tracker - Line Pressure - Oil Revenue Differed - Day 6],
         [Exception Tracker - Line Pressure - Oil Revenue Differed - Day 7],
         [Exception Tracker - Line Pressure - Oil Revenue Differed]
        )
) AS pvt
