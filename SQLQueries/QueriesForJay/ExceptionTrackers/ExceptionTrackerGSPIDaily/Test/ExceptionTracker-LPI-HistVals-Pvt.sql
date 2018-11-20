/*
*********************************************************************************
*  Source Name:  
*        ExceptionTracker-LPI-HistPvt.sql
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

WITH cte1 AS (
	SELECT cv.ObjectInstanceName,
		   cv.ObjectTypePropertyName,
		   CASE IsString
			  WHEN 0 THEN coalesce (cvh.Value, '0')
			  ELSE coalesce (cvh.Value, '')
		   END
			  AS HistValue,
		   CONVERT (VARCHAR (10), cvh.TimeOfSample, 101)
			  AS SampleDate
	FROM IVMPetexDP.ext.vw_CurrentValues cv
		 INNER JOIN IVMPetexDP.ext.vw_HistoryNumeric cvh
			ON (cv.DataSetId = cvh.DataSetId)
	WHERE     cv.ObjectTypeId = 1000000
		  AND cv.DataSourceName IN ('Production Surveillance')
		  AND cv.ObjectTypePropertyName IN
				(
					'Exception Tracker - Line Pressure Indicator - Daily'
					,'HF Production Tracker - Oil Target Highest'
					,'HF Production Tracker - Oil Delta - Daily'
				)
		  AND cvh.TimeOfSample BETWEEN '2018-10-19' AND '2018-11-19'
)
, cte2 AS (
	SELECT cv.ObjectInstanceName,
		   cv.ObjectTypePropertyName,
		   CASE IsString
			  WHEN 0 THEN coalesce (cv.CurrentValue, '0')
			  ELSE coalesce (cv.CurrentValue, '')
		   END
			  AS CurrentValue
	FROM IVMPetexDP.ext.vw_CurrentValues cv
	WHERE	(cv.ObjectTypeId = 1000000
				AND cv.DataSourceName IN 
				(
					'Well Properties'
					--,'Production Surveillance'
				)
				AND cv.ObjectTypePropertyName IN
				(
					'WINS'
					,'Foreman Area ID'
					,'Foreman Name'
				))
)
, cte3 AS (
	SELECT 
		c1.ObjectInstanceName,
		c1.ObjectTypePropertyName, 
		c1.HistValue,
		c1.SampleDate,
		c2.ObjectTypePropertyName AS c2ObjPropName,
		c2.CurrentValue

	FROM cte1 c1	
		JOIN cte2 c2
			ON c1.ObjectInstanceName = c2.ObjectInstanceName 
)
SELECT 
	[ObjectInstanceName] AS WellName
	,[WINS]
	,[Foreman Area ID]
	,[Foreman Name]
	,CAST([Exception Tracker - Line Pressure Indicator - Daily] AS FLOAT) AS LPIndicator
	,CAST([HF Production Tracker - Oil Target Highest] AS FLOAT) AS OilTargetHigh
	,CAST([HF Production Tracker - Oil Delta - Daily] AS FLOAT) AS OilDeltaDaily
	,[SampleDate]
FROM (SELECT * FROM cte3) AS cv
PIVOT (
    MAX(cv.HistValue)
	
    FOR cv.ObjectTypePropertyName IN 
        (
			[HF Production Tracker - Oil Target Highest]
			,[HF Production Tracker - Oil Delta - Daily]
	 		,[Exception Tracker - Line Pressure Indicator - Daily]
        )
) AS pvt1
PIVOT (
    MAX(CurrentValue)
	
    FOR c2ObjPropName IN 
        (
			[WINS],
			[Foreman Area ID],
			[Foreman Name],
        )
) AS pvt2

WHERE 
	[Exception Tracker - Line Pressure Indicator - Daily] = 1
ORDER BY
	[SampleDate] DESC
