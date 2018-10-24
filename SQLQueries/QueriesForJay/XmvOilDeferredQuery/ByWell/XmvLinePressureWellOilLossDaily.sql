/*
*********************************************************************************
* Source Name:  
*   XmvLinePressureWellOilLossDaily.sql
*  
* Purpose:      
*   SQL Query used to retrieve and format XMV Line Pressure Oil Loss 
*   (historical values) daily for the date range 2017-12-25 thru current 
*   day for all wells.
*
* Data Source:
*   Production Surveillance
*        
* Author:
*   Robert Palumbo
*        
* Creation Date: 
*   09/11/2018
*        
*  Property of Anadarko Petroleum Corporation (APC)
* 
**********************************************************************************
*/

SELECT
    vw_CurrentValues.ObjectInstanceName AS WellName, 
    vw_CurrentValues.ObjectTypePropertyName AS PropertyName, 
    vw_HistoryNumeric.TimeOfSample AS SampleTime,
    MAX(vw_HistoryNumeric.Value) AS HistoricalValue
FROM 
    IVMPetexDP.ext.vw_CurrentValues vw_CurrentValues
    INNER JOIN IVMPetexDP.ext.vw_HistoryNumeric vw_HistoryNumeric
        ON (vw_CurrentValues.DataSetId = vw_HistoryNumeric.DataSetId)
WHERE
    (vw_CurrentValues.ObjectTypeId = 1000000) AND
    (vw_CurrentValues.DataSourceName IN ('Production Surveillance') AND
        vw_CurrentValues.ObjectTypePropertyName IN (
            'Exception Tracker - Line Pressure - Oil Differed'
        )) AND
    (vw_HistoryNumeric.TimeOfSample 
        BETWEEN '2017-12-25' AND cast(cast(getdate() as date) as datetime))
GROUP BY 
    vw_HistoryNumeric.TimeOfSample, 
    vw_CurrentValues.ObjectInstanceName,
    vw_CurrentValues.ObjectTypePropertyName

