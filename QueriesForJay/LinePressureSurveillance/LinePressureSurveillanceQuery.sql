/*
*********************************************************************************
*  Source Name:  
*       LinePressureSurveillance.sql
*  
*  Purpose:      
*       SQL Query used to retrieve and format data for the Line Pressure
*       Surveillance IOC dashboard.
*        
*  Author:
*       Robert Palumbo
*        
*  Creation Date: 
*       08/07/2018
*        
*  Property of Anadarko Petroleum Corporation (APC)
* 
**********************************************************************************
*/

-- Create temp table containing the BIN name text values
WITH cteBinLabels AS (
    SELECT  
        IVMConfig.ivm.Condition.ConditionId, 
        IVMConfig.ivm.Condition.ConditionName, 
        IVMConfig.ivm.Condition.[Text],
        ROW_NUMBER() OVER 
            (ORDER BY IVMConfig.ivm.Condition.ConditionId) AS RowNum
    FROM 
        IVMConfig.ivm.ConditionMapping 
        INNER JOIN
            IVMConfig.ivm.Condition ON 
                IVMConfig.ivm.Condition.ConditionId = 
                    IVMConfig.ivm.ConditionMapping.ConditionMappingId
    WHERE 
        IVMConfig.ivm.Condition.ConditionName LIKE 'Bin %'
)

-- Perform the query to retrieve the requisite Line Pressure data
,cteValue AS ( 
    SELECT 
        v.ObjectInstanceName, 
        v.ObjectTypePropertyName, 
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
SELECT 
    ObjectInstanceName,
    [HF Plunger Output - Tubing Pressure - Average Bin Number] + 1 
        AS TubingPressBinNum,
    (SELECT Text FROM cteBinLabels WHERE RowNum = 
        ([HF Plunger Output - Tubing Pressure - Average Bin Number] + 1)) 
        AS TubingPressBin,
    [HF Plunger Output - Line Pressure - Average Bin Number] + 1 
        AS LinePressBinNum,
    (SELECT Text FROM cteBinLabels WHERE RowNum = 
        ([HF Plunger Output - Line Pressure - Average Bin Number] + 1)) 
        AS LinePressBin,
    [HF Plunger Output - Gas Sales Pressure - Average Bin Number] + 1
        AS GasSalesPressBinNum,
    (SELECT Text FROM cteBinLabels WHERE RowNum = 
        ([HF Plunger Output - Gas Sales Pressure - Average Bin Number] + 1))
        AS GasSalesPressBin,

    CAST([HF Plunger Output - Average XMV to Sales Gas Pressure Delta - 7 Day] AS FLOAT) 
        AS AvgXmvToSalesGasPressDelta7Day,
    [HF Plunger Output - Line Pressure - Gas Sales - Plot Flag] 
        AS LinePressGasSalesPlotFlag,

    CAST([Exception Tracker - Line Pressure - Oil Differed - Day 1] AS FLOAT) 
        AS LinePressOilDiffDay1,
    CAST([Exception Tracker - Line Pressure - Oil Differed - Day 2] AS FLOAT) 
        AS LinePressOilDiffDay2,
    CAST([Exception Tracker - Line Pressure - Oil Differed - Day 3] AS FLOAT) 
        AS LinePressOilDiffDay3,
    CAST([Exception Tracker - Line Pressure - Oil Differed - Day 4] AS FLOAT) 
        AS LinePressOilDiffDay4,
    CAST([Exception Tracker - Line Pressure - Oil Differed - Day 5] AS FLOAT) 
        AS LinePressOilDiffDay5,
    CAST([Exception Tracker - Line Pressure - Oil Differed - Day 6] AS FLOAT) 
        AS LinePressOilDiffDay6,
    CAST([Exception Tracker - Line Pressure - Oil Differed - Day 7] AS FLOAT) 
        AS LinePressOilDiffDay7,
    CAST([Exception Tracker - Line Pressure - Oil Differed] AS FLOAT) 
        AS LinePressOilDiff,

    CAST([Exception Tracker - Line Pressure - Oil Revenue Differed - Day 1] AS FLOAT) 
        AS LinePressOilRevDiffDay1,
    CAST([Exception Tracker - Line Pressure - Oil Revenue Differed - Day 2] AS FLOAT) 
        AS LinePressOilRevDiffDay2,
    CAST([Exception Tracker - Line Pressure - Oil Revenue Differed - Day 3] AS FLOAT) 
        AS LinePressOilRevDiffDay3,
    CAST([Exception Tracker - Line Pressure - Oil Revenue Differed - Day 4] AS FLOAT) 
        AS LinePressOilRevDiffDay4,
    CAST([Exception Tracker - Line Pressure - Oil Revenue Differed - Day 5] AS FLOAT) 
        AS LinePressOilRevDiffDay5,
    CAST([Exception Tracker - Line Pressure - Oil Revenue Differed - Day 6] AS FLOAT) 
        AS LinePressOilRevDiffDay6,
    CAST([Exception Tracker - Line Pressure - Oil Revenue Differed - Day 7] AS FLOAT) 
        AS LinePressOilRevDiffDay7,
    CAST([Exception Tracker - Line Pressure - Oil Revenue Differed] AS FLOAT) 
        AS LinePressOilRevDiff,
    
    CAST([HF Production Tracker - Oil Target Highest] AS FLOAT) 
        AS OilTargetHighest,
    [Exception Tracker - Gas Sales Pressure Indicator] 
        AS GasSalesPressInd,
    [Exception Tracker - Line Pressure Indicator] 
        AS LinePressInd
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

         [Exception Tracker - Gas Sales Pressure Indicator],
         [Exception Tracker - Line Pressure Indicator],
         [HF Production Tracker - Oil Target Highest]
        )
) AS pvt
ORDER BY ObjectInstanceName
