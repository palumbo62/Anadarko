/*
*********************************************************************************
*  Source Name:  
*        ExceptionTracker-GSDI-CurrVals,sql
*  
*  Purpose:      
*        SQL Query used to retrieve an format data for the Exception Tracker -
*        Gas Sales Pressure report using current data values.
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
		cv.CurrentValue AS ForemanID,
		CONVERT(VARCHAR(10), cv2.LastGoodSampleTime, 101) AS SampleDate,
		cv2.CurrentValue AS Indicator
	FROM 
		IVMPetexDP.ext.vw_CurrentValues cv
		INNER JOIN IVMPetexDP.ext.vw_CurrentValues cv2 
			ON cv.ObjectInstanceId = cv2.ObjectInstanceId
	WHERE
		(cv.ObjectTypeId = 1000000)
		AND ((cv.DataSourceName IN ('Well Properties') 
			AND cv.ObjectTypePropertyName = 'Foreman Area ID'))
		AND ((cv2.DataSourceName IN ('Production Surveillance')
			AND cv2.ObjectTypePropertyName = 'Exception Tracker - Gas Sales Pressure Indicator - Daily'))
		AND (cv2.CurrentValue = 1)
), cte2 AS
(
	SELECT 
		cte1.WellName,
		cv.CurrentValue as WINS,
		cte1.ForemanID,
		cte1.SampleDate,
		cte1.Indicator
	FROM
		cte1 
		INNER JOIN  IVMPetexDP.ext.vw_CurrentValues cv
			ON cv.ObjectInstanceName = cte1.WellName
	WHERE
		(cv.DataSourceName = 'Well Properties' 
		AND cv.ObjectTypePropertyName = 'WINS')
)
, cte3 AS
(
	SELECT 
		cte2.WellName,
		cte2.WINS,
		cte2.ForemanID,
		cv.CurrentValue as OilTargetHighest,
		cte2.SampleDate,
		cte2.Indicator
	FROM
		cte2 
		INNER JOIN  IVMPetexDP.ext.vw_CurrentValues cv
			ON cv.ObjectInstanceName = cte2.WellName
	WHERE
		(cv.DataSourceName = 'Production Surveillance' 
		AND cv.ObjectTypePropertyName IN (
				'HF Production Tracker - Oil Target Highest' 
				)
		)
)
, cte4 AS 
(
	SELECT 
		cte3.WellName,
		cte3.WINS,
		cte3.ForemanID,
		cv.CurrentValue as ForemanName,
		cte3.OilTargetHighest,
		cte3.SampleDate,
		cte3.Indicator
	FROM
		cte3
		INNER JOIN  IVMPetexDP.ext.vw_CurrentValues cv
			ON cv.ObjectInstanceName = cte3.ForemanID
	WHERE
		(cv.DataSourceName = 'Well Properties' 
		AND cv.ObjectTypePropertyName = 'Foreman Name')
)
SELECT 
	WellName,
	WINS,
	ForemanID,
	ForemanName,
	OilTargetHighest,
	cv.CurrentValue as OilDeltaDaily,
	SampleDate,
	Indicator
FROM
	cte4
	INNER JOIN IVMPetexDP.ext.vw_CurrentValues cv
		ON cv.ObjectInstanceName = cte4.WellName
WHERE
	cv.DataSourceName = 'Production Surveillance' 
	AND cv.ObjectTypePropertyName IN (
			'HF Production Tracker - Oil Delta - Daily' 
			)
ORDER BY SampleDate DESC

