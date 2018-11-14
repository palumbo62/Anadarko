WITH cte1 AS (
	SELECT
		cv.ObjectInstanceName AS WellName, 
--		cv.ObjectTypePropertyName AS PropertyName, 
		cv.CurrentValue AS ForemanID,
--		cv2.ObjectTypePropertyName AS PropertyName2,
		CONVERT(VARCHAR(10), cvh.TimeOfSample, 101) AS SampleDate,
		cvh.Value AS HistoryValue
	FROM 
		IVMPetexDP.ext.vw_CurrentValues cv
		INNER JOIN IVMPetexDP.ext.vw_CurrentValues cv2 
			ON cv.ObjectInstanceId = cv2.ObjectInstanceId
		INNER JOIN IVMPetexDP.ext.vw_HistoryNumeric cvh
			ON (cv2.DataSetId = cvh.DataSetId)
	WHERE
			(cv.ObjectTypeId = 1000000)
		AND ((cv.DataSourceName IN ('Well Properties') 
			AND cv.ObjectTypePropertyName = 'Foreman Area ID'))
		AND ((cv2.DataSourceName IN ('Production Surveillance')
			AND cv2.ObjectTypePropertyName = 'Exception Tracker - Line Pressure Indicator - Daily'))
		AND (cvh.TimeOfSample BETWEEN '2018-10-19' AND '2018-11-13') 
		AND (cvh.Value = 1)
)
SELECT 
    cte1.WellName,
	cte1.ForemanID,
	cv.CurrentValue as ForemanName,
	cte1.SampleDate,
	cte1.HistoryValue
FROM
	cte1 
	INNER JOIN  IVMPetexDP.ext.vw_CurrentValues cv
		ON cv.ObjectInstanceName = cte1.ForemanID
WHERE
	(cv.DataSourceName = 'Well Properties' 
	AND cv.ObjectTypePropertyName = 'Foreman Name')
ORDER BY
	cte1.SampleDate DESC
