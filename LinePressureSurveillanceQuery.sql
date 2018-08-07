WITH cteValue AS ( 
    SELECT v.ObjectInstanceName, v.ObjectTypePropertyName, 
        CASE IsString 
            WHEN 0 THEN COALESCE(v.CurrentValue, '0') 
            ELSE COALESCE(v.CurrentValue, '') 
        END AS CurrentValue
    FROM IVMPetexDP.ext.vw_CurrentValues v
    WHERE v.ObjectTypeId = 1000000
            AND ((v.DataSourceName IN ('Plunger Surveillance') AND 
                  v.ObjectTypePropertyName IN ('HF Plunger Output - Tubing Pressure - Average Bin Number',
                                               'HF Plunger Output - Line Pressure - Average Bin Number',
                                               'HF Plunger Output - Gas Sales Pressure - Average Bin Number',
                                               'HF Plunger Output - Average XMV to Sales Gas Pressure Delta - 7 Day')) OR
                 (v.DataSourceName IN ('Production Surveillance') AND
                  v.ObjectTypePropertyName IN ('Exception Tracker - Line Pressure - Oil Differed - Day 1',
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
                                               'Exception Tracker - Line Pressure - Oil Revenue Differed')))
)

--SELECT * from cteValue



SELECT ObjectInstanceName,
       cast([HF Plunger Output - Tubing Pressure - Average Bin Number] AS FLOAT) AS TubingPressureABN,
       cast([HF Plunger Output - Line Pressure - Average Bin Number] AS FLOAT) AS LinePressureABN,
       cast([HF Plunger Output - Gas Sales Pressure - Average Bin Number] AS FLOAT) AS GasSalesPressureABN,
       cast([HF Plunger Output - Average XMV to Sales Gas Pressure Delta - 7 Day] AS FLOAT) AS AvgXmvToSalesGasPressureDelta7Day
FROM (SELECT * FROM cteValue) AS v
PIVOT (
    max(v.CurrentValue)
    FOR v.ObjectTypePropertyName IN 
        ([HF Plunger Output - Tubing Pressure - Average Bin Number],
         [HF Plunger Output - Line Pressure - Average Bin Number],
         [HF Plunger Output - Gas Sales Pressure - Average Bin Number],
         [HF Plunger Output - Average XMV to Sales Gas Pressure Delta - 7 Day])
 
) AS pvt

--ORDER BY cast(p.[Plunger Output - 7 Day Casing Slope] as float)