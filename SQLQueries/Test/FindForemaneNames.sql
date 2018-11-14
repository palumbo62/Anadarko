
SELECT 
	cv.ObjectInstanceName,
	cv.CurrentValue as ForemanName
FROM
	IVMPetexDP.ext.vw_CurrentValues AS cv 
WHERE
	(cv.DataSourceName = 'Well Properties' 
	AND cv.ObjectTypePropertyName = 'Foreman Name')
