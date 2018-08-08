/*
*********************************************************************************
*  Source Name:  
*        LinePressureSurveillance,sql
*  
*  Purpose:      
*        SQL Query used to retrieve an format data for the Line Pressure
*        Surveillance IOC dashboard.
*        
*  Author:
*        Robert Palumbo
*        
*  Date: 
*        08/07/2018
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
            AND ((v.DataSourceName IN ('Plunger Surveillance') AND 
                  v.ObjectTypePropertyName IN (
                                                'HF Plunger Output - Tubing Pressure - Average Bin Number',
                                                'HF Plunger Output - Line Pressure - Average Bin Number',
                                                'HF Plunger Output - Gas Sales Pressure - Average Bin Number',
                                                'HF Plunger Output - Average XMV to Sales Gas Pressure Delta - 7 Day',
                                                'HF Plunger Output - Line Pressure - Gas Sales - Plot Flag'
                                               )) OR
                 (v.DataSourceName IN ('Production Surveillance') AND
                  v.ObjectTypePropertyName IN (
                                                'Exception Tracker - Line Pressure - Oil Differed - Day 1',
                                                'Exception Tracker - Line Pressure - Oil Revenue Differed - Day 1',
                                                'Exception Tracker - Line Pressure - Oil Differed - Day 2',
                                                'Exception Tracker - Line Pressure - Oil Revenue Differed - Day 2',
                                                'Exception Tracker - Line Pressure - Oil Differed - Day 3',
                                                'Exception Tracker - Line Pressure - Oil Revenue Differed - Day 3',
                                                'Exception Tracker - Line Pressure - Oil Differed - Day 4',
                                                'Exception Tracker - Line Pressure - Oil Revenue Differed - Day 4',
                                                'Exception Tracker - Line Pressure - Oil Differed - Day 5',
                                                'Exception Tracker - Line Pressure - Oil Revenue Differed - Day 5',
                                                'Exception Tracker - Line Pressure - Oil Differed - Day 6',
                                                'Exception Tracker - Line Pressure - Oil Revenue Differed - Day 6',
                                                'Exception Tracker - Line Pressure - Oil Differed - Day 7',
                                                'Exception Tracker - Line Pressure - Oil Revenue Differed - Day 7',
                                                'Exception Tracker - Line Pressure - Oil Differed',
                                                'Exception Tracker - Line Pressure - Oil Revenue Differed',
                                                'Exception Tracker - Gas Sales Pressure Indicator',
                                                'Exception Tracker - Line Pressure Indicator',
                                                'HF Production Tracker - Oil Target Highest'
                                               )))
)

-- Format and Pivot the internal table data for use by the Line Pressure dashboard
SELECT ObjectInstanceName,
       CAST([HF Plunger Output - Tubing Pressure - Average Bin Number] AS FLOAT) AS TubingPressureABN,
       CAST([HF Plunger Output - Line Pressure - Average Bin Number] AS FLOAT) AS LinePressureABN,
       CAST([HF Plunger Output - Gas Sales Pressure - Average Bin Number] AS FLOAT) AS GasSalesPressureABN,
       CAST([HF Plunger Output - Average XMV to Sales Gas Pressure Delta - 7 Day] AS FLOAT) AS AvgXmvToSalesGasPressureDelta7Day,
       CAST([HF Plunger Output - Line Pressure - Gas Sales - Plot Flag] AS FLOAT) AS LinePressureGasSalesPlotFlag,
       CAST([Exception Tracker - Line Pressure - Oil Differed - Day 1] AS FLOAT) AS LinePressureOilDiffDay1,
       CAST([Exception Tracker - Line Pressure - Oil Revenue Differed - Day 1] AS FLOAT) AS LinePressureRevDiffDay1,
       CAST([Exception Tracker - Line Pressure - Oil Differed - Day 2] AS FLOAT) AS LinePressureOilDiffDay2,
       CAST([Exception Tracker - Line Pressure - Oil Revenue Differed - Day 2] AS FLOAT) AS LinePressureRevDiffDay2,
       CAST([Exception Tracker - Line Pressure - Oil Differed - Day 3] AS FLOAT) AS LinePressureOilDiffDay3,
       CAST([Exception Tracker - Line Pressure - Oil Revenue Differed - Day 3] AS FLOAT) AS LinePressureRevDiffDay3,
       CAST([Exception Tracker - Line Pressure - Oil Differed - Day 4] AS FLOAT) AS LinePressureOilDiffDay4,
       CAST([Exception Tracker - Line Pressure - Oil Revenue Differed - Day 4] AS FLOAT) AS LinePressureRevDiffDay4,
       CAST([Exception Tracker - Line Pressure - Oil Differed - Day 5] AS FLOAT) AS LinePressureOilDiffDay5,
       CAST([Exception Tracker - Line Pressure - Oil Revenue Differed - Day 5] AS FLOAT) AS LinePressureRevDiffDay5,
       CAST([Exception Tracker - Line Pressure - Oil Differed - Day 6] AS FLOAT) AS LinePressureOilDiffDay6,
       CAST([Exception Tracker - Line Pressure - Oil Revenue Differed - Day 6] AS FLOAT) AS LinePressureRevDiffDay6,
       CAST([Exception Tracker - Line Pressure - Oil Differed - Day 7] AS FLOAT) AS LinePressureOilDiffDay7,
       CAST([Exception Tracker - Line Pressure - Oil Revenue Differed - Day 7] AS FLOAT) AS LinePressureRevDiffDay7,
       CAST([Exception Tracker - Line Pressure - Oil Differed] AS FLOAT) AS OilDiffered,
       CAST([Exception Tracker - Line Pressure - Oil Revenue Differed] AS FLOAT) AS RevDiffered,
       CAST([Exception Tracker - Gas Sales Pressure Indicator] AS FLOAT) AS GasSalesPressureInd,
       CAST([Exception Tracker - Line Pressure Indicator] AS FLOAT) AS LinePressureInd,
       CAST([HF Production Tracker - Oil Target Highest] AS FLOAT) AS OilTargetHighest
FROM (SELECT * FROM cteValue) AS v
PIVOT (
    MAX(v.CurrentValue)
    FOR v.ObjectTypePropertyName IN 
        (
         [HF Plunger Output - Tubing Pressure - Average Bin Number],
         [HF Plunger Output - Line Pressure - Average Bin Number],
         [HF Plunger Output - Gas Sales Pressure - Average Bin Number],
         [HF Plunger Output - Average XMV to Sales Gas Pressure Delta - 7 Day],
         [HF Plunger Output - Line Pressure - Gas Sales - Plot Flag],
         [Exception Tracker - Line Pressure - Oil Differed - Day 1],
         [Exception Tracker - Line Pressure - Oil Revenue Differed - Day 1],
         [Exception Tracker - Line Pressure - Oil Differed - Day 2],
         [Exception Tracker - Line Pressure - Oil Revenue Differed - Day 2],
         [Exception Tracker - Line Pressure - Oil Differed - Day 3],
         [Exception Tracker - Line Pressure - Oil Revenue Differed - Day 3],
         [Exception Tracker - Line Pressure - Oil Differed - Day 4],
         [Exception Tracker - Line Pressure - Oil Revenue Differed - Day 4],
         [Exception Tracker - Line Pressure - Oil Differed - Day 5],
         [Exception Tracker - Line Pressure - Oil Revenue Differed - Day 5],
         [Exception Tracker - Line Pressure - Oil Differed - Day 6],
         [Exception Tracker - Line Pressure - Oil Revenue Differed - Day 6],
         [Exception Tracker - Line Pressure - Oil Differed - Day 7],
         [Exception Tracker - Line Pressure - Oil Revenue Differed - Day 7],
         [Exception Tracker - Line Pressure - Oil Differed],
         [Exception Tracker - Line Pressure - Oil Revenue Differed],
         [Exception Tracker - Gas Sales Pressure Indicator],
         [Exception Tracker - Line Pressure Indicator],
         [HF Production Tracker - Oil Target Highest]
        )
) AS pvt
