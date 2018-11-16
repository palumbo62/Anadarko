SELECT
	cv.ObjectInstanceName AS ForemanAreaID,
	cv.CurrentValue AS ForemanName
FROM 
	IVMPetexDP.ext.vw_CurrentValues cv
WHERE
	(cv.ObjectTypeId = 1000017)
	AND ((cv.DataSourceName IN ('Well Properties') 
		AND cv.ObjectTypePropertyName = 'Foreman Name'))
ORDER BY ForemanAreaID
