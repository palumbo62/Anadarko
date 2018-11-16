/*
*********************************************************************************
*  Source Name:  
*        ExceptionTracker-GSDI-HistVals,sql
*  
*  Purpose:      
*        SQL Query used to retrieve an format data for the Exception Tracker -
*        Gas Sales Pressure report using historical data values.
*        
*  Author:
*        Robert Palumbo
*        
*  Creation Date: 
*        11/15/2018
*        
*  Property of Anadarko Petroleum Corporation (APC)
* 
**********************************************************************************
*/

WITH cte1 AS 
(
	SELECT
		cv.ObjectInstanceName AS WellName, 
		cv2.CurrentValue AS ForemanID,
		CONVERT(VARCHAR(10), cvh.TimeOfSample, 101) AS SampleDate,
		cvh.Value AS Indicator
	FROM 
		IVMPetexDP.ext.vw_CurrentValues cv
		JOIN IVMPetexDP.ext.vw_CurrentValues cv2 
			ON cv.ObjectInstanceId = cv2.ObjectInstanceId
		JOIN  IVMPetexDP.ext.vw_HistoryNumeric cvh
			ON (cv.DataSetId = cvh.DataSetId)
	WHERE
		(cv.ObjectTypeId = 1000000)
		AND ((cv.DataSourceName IN ('Production Surveillance')
			AND cv.ObjectTypePropertyName = 'Exception Tracker - Gas Sales Pressure Indicator - Daily'))
		AND ((cv2.DataSourceName IN ('Well Properties') 
			AND cv2.ObjectTypePropertyName = 'Foreman Area ID'))
		AND (cvh.TimeOfSample BETWEEN '2018-10-19' AND '2018-11-13') 
		AND (cvh.Value = 1)
)
, cte2 AS (
	SELECT 
		cte1.WellName,
		cte1.ForemanID,
		cv.CurrentValue AS ForemanName,
		cte1.SampleDate,
		cte1.Indicator
	FROM
		cte1
		JOIN IVMPetexDP.ext.vw_CurrentValues cv
			ON cv.ObjectInstanceName = cte1.ForemanID
	WHERE 
		(cv.ObjectTypeId = 1000017) 
		AND
			(cv.DataSourceName = 'Well Properties' 
					AND cv.ObjectTypePropertyName IN (
						'Foreman Name'))
)
, cte3 AS (
	SELECT 
		WellName,
		ForemanID,
		ForemanName,
		SampleDate,
		Indicator,
		cv.CurrentValue,
		cv.ObjectTypePropertyName

	FROM
		cte2 
		JOIN IVMPetexDP.ext.vw_CurrentValues cv
			ON cte2.WellName = cv.ObjectInstanceName 
	WHERE 
		(cv.ObjectTypeId = 1000000) 
		AND
			(cv.DataSourceName = 'Well Properties' 
					AND cv.ObjectTypePropertyName IN (
						'WINS'))
			OR
				(cv.DataSourceName = 'Production Surveillance' 
					AND cv.ObjectTypePropertyName IN (
						'HF Production Tracker - Oil Target Highest',
						'HF Production Tracker - Oil Delta - Daily'))
)
SELECT 
	[WellName], 
	[WINS],
    [ForemanID],
	[ForemanName],
    CAST([HF Production Tracker - Oil Target Highest] AS FLOAT) AS OilTargetHighest,
    CAST([HF Production Tracker - Oil Delta - Daily] AS FLOAT) AS OilDeltaDaily,
	[SampleDate],
	[Indicator]

FROM (SELECT * FROM cte3) AS v
PIVOT (
    MAX(v.CurrentValue)
	
    FOR v.ObjectTypePropertyName IN 
        (
			[WINS],
			[Foreman Area ID],
			[Foreman Name],
	 
			[HF Production Tracker - Oil Target Highest],
			[HF Production Tracker - Oil Delta - Daily]
        )
) AS pvt
ORDER BY SampleDate DESC
