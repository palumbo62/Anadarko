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
                                                
                                                'Exception Tracker - Gas Sales Pressure - Oil Differed - Day 1',
                                                'Exception Tracker - Gas Sales Pressure - Oil Differed - Day 2',
                                                'Exception Tracker - Gas Sales Pressure - Oil Differed - Day 3',
                                                'Exception Tracker - Gas Sales Pressure - Oil Differed - Day 4',
                                                'Exception Tracker - Gas Sales Pressure - Oil Differed - Day 5',
                                                'Exception Tracker - Gas Sales Pressure - Oil Differed - Day 6',
                                                'Exception Tracker - Gas Sales Pressure - Oil Differed - Day 7',
                                                'Exception Tracker - Gas Sales Pressure - Oil Differed',
                                                
                                                'Exception Tracker - Gas Sales Pressure - Oil Revenue Differed - Day 1',
                                                'Exception Tracker - Gas Sales Pressure - Oil Revenue Differed - Day 2',
                                                'Exception Tracker - Gas Sales Pressure - Oil Revenue Differed - Day 3',
                                                'Exception Tracker - Gas Sales Pressure - Oil Revenue Differed - Day 4',
                                                'Exception Tracker - Gas Sales Pressure - Oil Revenue Differed - Day 5',
                                                'Exception Tracker - Gas Sales Pressure - Oil Revenue Differed - Day 6',
                                                'Exception Tracker - Gas Sales Pressure - Oil Revenue Differed - Day 7',
                                                'Exception Tracker - Gas Sales Pressure - Oil Revenue Differed'
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
       CAST([Exception Tracker - Line Pressure - Oil Differed] AS FLOAT) AS LinePressOilDiff,
       
       CAST([Exception Tracker - Line Pressure - Oil Revenue Differed - Day 1] AS FLOAT) AS LinePressOilRevDiffDay1,
       CAST([Exception Tracker - Line Pressure - Oil Revenue Differed - Day 2] AS FLOAT) AS LinePressOilRevDiffDay2,
       CAST([Exception Tracker - Line Pressure - Oil Revenue Differed - Day 3] AS FLOAT) AS LinePressOilRevDiffDay3,
       CAST([Exception Tracker - Line Pressure - Oil Revenue Differed - Day 4] AS FLOAT) AS LinePressOilRevDiffDay4,
       CAST([Exception Tracker - Line Pressure - Oil Revenue Differed - Day 5] AS FLOAT) AS LinePressOilRevDiffDay5,
       CAST([Exception Tracker - Line Pressure - Oil Revenue Differed - Day 6] AS FLOAT) AS LinePressOilRevDiffDay6,
       CAST([Exception Tracker - Line Pressure - Oil Revenue Differed - Day 7] AS FLOAT) AS LinePressOilRevDiffDay7,
       CAST([Exception Tracker - Line Pressure - Oil Revenue Differed] AS FLOAT) AS LinePressOilRevDiff,
       
       CAST([Exception Tracker - Gas Sales Pressure - Oil Differed - Day 1] AS FLOAT) AS GasSalesPressOilDiffDay1,
       CAST([Exception Tracker - Gas Sales Pressure - Oil Differed - Day 2] AS FLOAT) AS GasSalesPressOilDiffDay2,
       CAST([Exception Tracker - Gas Sales Pressure - Oil Differed - Day 3] AS FLOAT) AS GasSalesPressOilDiffDay3,
       CAST([Exception Tracker - Gas Sales Pressure - Oil Differed - Day 4] AS FLOAT) AS GasSalesPressOilDiffDay4,
       CAST([Exception Tracker - Gas Sales Pressure - Oil Differed - Day 5] AS FLOAT) AS GasSalesPressOilDiffDay5,
       CAST([Exception Tracker - Gas Sales Pressure - Oil Differed - Day 6] AS FLOAT) AS GasSalesPressOilDiffDay6,
       CAST([Exception Tracker - Gas Sales Pressure - Oil Differed - Day 7] AS FLOAT) AS GasSalesPressOilDiffDay7,
       CAST([Exception Tracker - Gas Sales Pressure - Oil Differed] AS FLOAT) AS GasSalesPressOilDiff,
       
       CAST([Exception Tracker - Gas Sales Pressure - Oil Revenue Differed - Day 1] AS FLOAT) AS GasSalesPressOilRevDiffDay1,
       CAST([Exception Tracker - Gas Sales Pressure - Oil Revenue Differed - Day 2] AS FLOAT) AS GasSalesPressOilRevDiffDay2,
       CAST([Exception Tracker - Gas Sales Pressure - Oil Revenue Differed - Day 3] AS FLOAT) AS GasSalesPressOilRevDiffDay3,
       CAST([Exception Tracker - Gas Sales Pressure - Oil Revenue Differed - Day 4] AS FLOAT) AS GasSalesPressOilRevDiffDay4,
       CAST([Exception Tracker - Gas Sales Pressure - Oil Revenue Differed - Day 5] AS FLOAT) AS GasSalesPressOilRevDiffDay5,
       CAST([Exception Tracker - Gas Sales Pressure - Oil Revenue Differed - Day 6] AS FLOAT) AS GasSalesPressOilRevDiffDay6,
       CAST([Exception Tracker - Gas Sales Pressure - Oil Revenue Differed - Day 7] AS FLOAT) AS GasSalesPressOilRevDiffDay7,
       CAST([Exception Tracker - Gas Sales Pressure - Oil Revenue Differed] AS FLOAT) AS GasSalesPressOilRevDiffered

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
         [Exception Tracker - Line Pressure - Oil Revenue Differed],
         
         [Exception Tracker - Gas Sales Pressure - Oil Differed - Day 1],
         [Exception Tracker - Gas Sales Pressure - Oil Differed - Day 2],
         [Exception Tracker - Gas Sales Pressure - Oil Differed - Day 3],
         [Exception Tracker - Gas Sales Pressure - Oil Differed - Day 4],
         [Exception Tracker - Gas Sales Pressure - Oil Differed - Day 5],
         [Exception Tracker - Gas Sales Pressure - Oil Differed - Day 6],
         [Exception Tracker - Gas Sales Pressure - Oil Differed - Day 7],
         [Exception Tracker - Gas Sales Pressure - Oil Differed],
         
         [Exception Tracker - Gas Sales Pressure - Oil Revenue Differed - Day 1],
         [Exception Tracker - Gas Sales Pressure - Oil Revenue Differed - Day 2],
         [Exception Tracker - Gas Sales Pressure - Oil Revenue Differed - Day 3],
         [Exception Tracker - Gas Sales Pressure - Oil Revenue Differed - Day 4],
         [Exception Tracker - Gas Sales Pressure - Oil Revenue Differed - Day 5],
         [Exception Tracker - Gas Sales Pressure - Oil Revenue Differed - Day 6],
         [Exception Tracker - Gas Sales Pressure - Oil Revenue Differed - Day 7],
         [Exception Tracker - Gas Sales Pressure - Oil Revenue Differed]
         
        )
) AS pvt
