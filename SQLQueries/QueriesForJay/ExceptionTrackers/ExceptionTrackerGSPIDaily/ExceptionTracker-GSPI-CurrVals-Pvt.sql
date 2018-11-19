/*
*********************************************************************************
*  Source Name:  
*        ExceptionTracker-GSPI-CurrPvt.sql
*  
*  Purpose:      
*        SQL Query used to retrieve and format data for the Exception Tracker -
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

WITH cte1 AS (
	SELECT cv.ObjectInstanceName,
		   cv.ObjectTypePropertyName,
		   CASE IsString
			  WHEN 0 THEN coalesce (cv.CurrentValue, '0')
			  ELSE coalesce (cv.CurrentValue, '')
		   END
			  AS CurrValue,
		   CONVERT (VARCHAR (10), GETDATE(), 101)
			  AS SampleDate
	FROM IVMPetexDP.ext.vw_CurrentValues cv
	WHERE     cv.ObjectTypeId IN (1000000, 1000017)
		  AND cv.DataSourceName IN 
				(
					'Well Properties',
					'Production Surveillance'
				)
		  AND cv.ObjectTypePropertyName IN
				(
					'Exception Tracker - Gas Sales Pressure Indicator - Daily'
					,'HF Production Tracker - Oil Target Highest'
					,'HF Production Tracker - Oil Delta - Daily'
					,'WINS'
					,'Foreman Area ID'
					,'Foreman Name'
				)
)
SELECT 
	[ObjectInstanceName] AS WellName,
	[WINS],
	[Foreman Area ID],
	[Foreman Name],
	CAST([Exception Tracker - Gas Sales Pressure Indicator - Daily] AS FLOAT) AS GSPIndicator,
	CAST([HF Production Tracker - Oil Target Highest] AS FLOAT) AS OilTargetHigh,
	CAST([HF Production Tracker - Oil Delta - Daily] AS FLOAT) AS OilDeltaDaily,
	[SampleDate]
FROM (SELECT * FROM cte1) AS cv
PIVOT (
    MAX(cv.CurrValue)

    FOR cv.ObjectTypePropertyName IN 
        (
			[WINS],
			[Foreman Area ID],
			[Foreman Name],
	 		[Exception Tracker - Gas Sales Pressure Indicator - Daily],
			[HF Production Tracker - Oil Target Highest],
			[HF Production Tracker - Oil Delta - Daily]
        )
) AS pvt2

WHERE 
	[Exception Tracker - Gas Sales Pressure Indicator - Daily] = 1
ORDER BY
	[SampleDate] DESC
