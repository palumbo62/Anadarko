SELECT Convert(date,vw_HistoryNumeric.TimeOfSample) as TimeOfSample,
       Max(vw_HistoryNumeric.Value) as Oil_Yesterday,
       vw_CurrentValues.ObjectInstanceName,
       vw_CurrentValues.ObjectTypePropertyName
FROM IVMPetexDP.ext.vw_CurrentValues vw_CurrentValues
     INNER JOIN IVMPetexDP.ext.vw_HistoryNumeric vw_HistoryNumeric
        ON (vw_CurrentValues.DataSetId = vw_HistoryNumeric.DataSetId)
WHERE     (vw_HistoryNumeric.TimeOfSample
           BETWEEN '2018-08-12' AND '2018-08-18')
      AND (vw_CurrentValues.ObjectTypePropertyId = 1002937)
      AND (vw_CurrentValues.ObjectTypeId = 1000022)
 
GROUP BY Convert(date,vw_HistoryNumeric.TimeOfSample), vw_CurrentValues.ObjectInstanceName,
       vw_CurrentValues.ObjectTypePropertyName
