SELECT
    vw_CurrentValues.ObjectInstanceName AS WellName, 
    vw_CurrentValues.ObjectTypePropertyName AS PropertyName, 
    CONVERT(VARCHAR(10), vw_HistoryNumeric.TimeOfSample, 101) AS SampleDate,
	MAX(vw_HistoryNumeric.Value) AS HistoryValue
FROM 
    IVMPetexDP.ext.vw_CurrentValues vw_CurrentValues
    INNER JOIN IVMPetexDP.ext.vw_HistoryNumeric vw_HistoryNumeric
        ON (vw_CurrentValues.DataSetId = vw_HistoryNumeric.DataSetId)
WHERE
    (vw_CurrentValues.ObjectTypeId = 1000000)
    AND (vw_CurrentValues.DataSourceName = 'Production Surveillance')
	AND (vw_CurrentValues.ObjectTypePropertyName IN ('Exception Tracker - Line Pressure Indicator - Daily'))
    AND (vw_HistoryNumeric.Value = 1)
	AND (vw_HistoryNumeric.TimeOfSample BETWEEN '2018-10-19' AND '2018-11-07') 
GROUP BY 
    vw_HistoryNumeric.TimeOfSample, 
    vw_CurrentValues.ObjectInstanceName,
    vw_CurrentValues.ObjectTypePropertyName
ORDER BY
	vw_HistoryNumeric.TimeOfSample DESC;
