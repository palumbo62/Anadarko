with oil_rate as (SELECT 
  cv_OilRate.ObjectInstanceId ,
  dateadd(hour,datediff(hour,0,hv_OilRate.TimeOfSample),0) AS Timestamp,
  Avg(hv_OilRate.Value) AS OilRate     
FROM IVMPetexDP.ext.vw_CurrentValues cv_OilRate INNER JOIN IVMPetexDP.ext.vw_HistoryNumeric hv_OilRate ON cv_OilRate.DataSetId = hv_OilRate.DataSetId AND hv_OilRate.TimeOfSample > DateAdd(hour,-336,GetDate())   
WHERE cv_OilRate.ObjectTypeId = 1000022 and cv_OilRate.ObjectTypePropertyId = 1002929 
GROUP BY cv_OilRate.ObjectInstanceId, dateadd(hour,datediff(hour,0,hv_OilRate.TimeOfSample),0))
, 

oil_today as (SELECT 
  cv_OilRate.ObjectInstanceId ,
  dateadd(hour,datediff(hour,0,hv_OilRate.TimeOfSample),0) AS Timestamp,
  Avg(hv_OilRate.Value) AS OilToday     
FROM IVMPetexDP.ext.vw_CurrentValues cv_OilRate INNER JOIN IVMPetexDP.ext.vw_HistoryNumeric hv_OilRate ON cv_OilRate.DataSetId = hv_OilRate.DataSetId AND hv_OilRate.TimeOfSample > DateAdd(hour,-336,GetDate())   
WHERE cv_OilRate.ObjectTypeId = 1000022 and cv_OilRate.ObjectTypePropertyId = 1002933 
GROUP BY cv_OilRate.ObjectInstanceId, dateadd(hour,datediff(hour,0,hv_OilRate.TimeOfSample),0))

,

oil_press as (SELECT 
  cv_OilRate.ObjectInstanceId,
  dateadd(hour,datediff(hour,0,hv_OilRate.TimeOfSample),0) AS Timestamp,
  Avg(hv_OilRate.Value) AS OilPress     
FROM IVMPetexDP.ext.vw_CurrentValues cv_OilRate INNER JOIN IVMPetexDP.ext.vw_HistoryNumeric hv_OilRate ON cv_OilRate.DataSetId = hv_OilRate.DataSetId AND hv_OilRate.TimeOfSample > DateAdd(hour,-336,GetDate())   
WHERE cv_OilRate.ObjectTypeId = 1000022 and cv_OilRate.ObjectTypePropertyId = 1002947 
GROUP BY cv_OilRate.ObjectInstanceId, dateadd(hour,datediff(hour,0,hv_OilRate.TimeOfSample),0))

, 

oil_temp as (SELECT 
  cv_OilRate.ObjectInstanceId,
  dateadd(hour,datediff(hour,0,hv_OilRate.TimeOfSample),0) AS Timestamp,
  Avg(hv_OilRate.Value) AS OilTemp     
FROM IVMPetexDP.ext.vw_CurrentValues cv_OilRate INNER JOIN IVMPetexDP.ext.vw_HistoryNumeric hv_OilRate ON cv_OilRate.DataSetId = hv_OilRate.DataSetId AND hv_OilRate.TimeOfSample > DateAdd(hour,-336,GetDate())   
WHERE cv_OilRate.ObjectTypeId = 1000022 and cv_OilRate.ObjectTypePropertyId = 1002942 
GROUP BY cv_OilRate.ObjectInstanceId, dateadd(hour,datediff(hour,0,hv_OilRate.TimeOfSample),0))

, 

oil_dens as (SELECT 
  cv_OilRate.ObjectInstanceId,
  dateadd(hour,datediff(hour,0,hv_OilRate.TimeOfSample),0) AS Timestamp,
  Avg(hv_OilRate.Value) AS OilDens     
FROM IVMPetexDP.ext.vw_CurrentValues cv_OilRate INNER JOIN IVMPetexDP.ext.vw_HistoryNumeric hv_OilRate ON cv_OilRate.DataSetId = hv_OilRate.DataSetId AND hv_OilRate.TimeOfSample > DateAdd(hour,-336,GetDate())   
WHERE cv_OilRate.ObjectTypeId = 1000022 and cv_OilRate.ObjectTypePropertyId = 1002925 and cv_OilRate.DataSourceId = 1000003
GROUP BY cv_OilRate.ObjectInstanceId, dateadd(hour,datediff(hour,0,hv_OilRate.TimeOfSample),0))

, 

drive_gain as (SELECT 
  cv_OilRate.ObjectInstanceId,
  dateadd(hour,datediff(hour,0,hv_OilRate.TimeOfSample),0) AS Timestamp,
  Avg(hv_OilRate.Value) AS DriveGain     
FROM IVMPetexDP.ext.vw_CurrentValues cv_OilRate INNER JOIN IVMPetexDP.ext.vw_HistoryNumeric hv_OilRate ON cv_OilRate.DataSetId = hv_OilRate.DataSetId AND hv_OilRate.TimeOfSample > DateAdd(hour,-336,GetDate())   
WHERE cv_OilRate.ObjectTypeId = 1000022 and cv_OilRate.ObjectTypePropertyId = 1002926 
GROUP BY cv_OilRate.ObjectInstanceId, dateadd(hour,datediff(hour,0,hv_OilRate.TimeOfSample),0))

, 

mass_rate as (SELECT 
  cv_OilRate.ObjectInstanceId,
  dateadd(hour,datediff(hour,0,hv_OilRate.TimeOfSample),0) AS Timestamp,
  Avg(hv_OilRate.Value) AS MassRate     
FROM IVMPetexDP.ext.vw_CurrentValues cv_OilRate INNER JOIN IVMPetexDP.ext.vw_HistoryNumeric hv_OilRate ON cv_OilRate.DataSetId = hv_OilRate.DataSetId AND hv_OilRate.TimeOfSample > DateAdd(hour,-336,GetDate())   
WHERE cv_OilRate.ObjectTypeId = 1000022 and cv_OilRate.ObjectTypePropertyId = 1002930 
GROUP BY cv_OilRate.ObjectInstanceId, dateadd(hour,datediff(hour,0,hv_OilRate.TimeOfSample),0))

, 

operating_pressure as (SELECT 
  cv_OilRate.ObjectInstanceId,
  dateadd(hour,datediff(hour,0,hv_OilRate.TimeOfSample),0) AS Timestamp,
  Avg(hv_OilRate.Value) AS MeterOpPressure    
FROM IVMPetexDP.ext.vw_CurrentValues cv_OilRate INNER JOIN IVMPetexDP.ext.vw_HistoryNumeric hv_OilRate ON cv_OilRate.DataSetId = hv_OilRate.DataSetId AND hv_OilRate.TimeOfSample > DateAdd(hour,-336,GetDate())   
WHERE cv_OilRate.ObjectTypeId = 1000022 and cv_OilRate.ObjectTypePropertyId = 1002941 
GROUP BY cv_OilRate.ObjectInstanceId, dateadd(hour,datediff(hour,0,hv_OilRate.TimeOfSample),0))


SELECT 
  cv_Meter.ObjectInstanceId,
  cv_Meter.ObjectInstanceName as LACT_Name,
  Concat(cv_ShortName.CurrentValue, '_M1_101') as FAC_ID,
  CAST(cv_Lat.CurrentValue AS float) as Latitude,
  CAST(cv_Long.CurrentValue AS float) as Longitude,
  cv_Meter.CurrentValue as Meter_Number, oil_rate.Timestamp, oil_rate.OilRate, oil_press.OilPress,oil_temp.OilTemp,oil_dens.OilDens,oil_today.OilToday,drive_gain.DriveGain
  ,operating_pressure.MeterOpPressure,mass_rate.MassRate
FROM IVMPetexDP.ext.vw_CurrentValues cv_Meter
     INNER JOIN IVMPetexDP.ext.vw_CurrentValues cv_ShortName ON cv_Meter.ObjectInstanceId = cv_ShortName.ObjectInstanceId and cv_ShortName.ObjectTypePropertyId = 1005168
     INNER JOIN IVMPetexDP.ext.vw_CurrentValues cv_Delete ON cv_Meter.ObjectInstanceId = cv_Delete.ObjectInstanceId and cv_Delete.ObjectTypePropertyId = 1004499 and cv_Delete.CurrentValue = 0
      INNER JOIN IVMPetexDP.ext.vw_CurrentValues cv_Lat on cv_Meter.ObjectInstanceId = cv_Lat.ObjectInstanceId and cv_Lat.ObjectTypePropertyId = 1003001
     INNER JOIN IVMPetexDP.ext.vw_CurrentValues cv_Long on cv_Meter.ObjectInstanceId = cv_Long.ObjectInstanceId and cv_Long.ObjectTypePropertyId = 1003002
      INNER JOIN oil_rate on cv_Meter.ObjectInstanceId = oil_rate.ObjectInstanceId
      LEFT JOIN oil_press on cv_Meter.ObjectInstanceId = oil_press.ObjectInstanceId and oil_rate.Timestamp = oil_press.Timestamp
      LEFT JOIN oil_temp on cv_Meter.ObjectInstanceId = oil_temp.ObjectInstanceId and oil_rate.Timestamp = oil_temp.Timestamp
      LEFT JOIN oil_dens on cv_Meter.ObjectInstanceId = oil_dens.ObjectInstanceId and oil_rate.Timestamp = oil_dens.Timestamp
      LEFT JOIN oil_today on cv_Meter.ObjectInstanceId = oil_today.ObjectInstanceId and oil_rate.Timestamp = oil_today.Timestamp
      LEFT JOIN drive_gain on cv_Meter.ObjectInstanceId = drive_gain.ObjectInstanceId and oil_rate.Timestamp = drive_gain.Timestamp
      LEFT JOIN mass_rate on cv_Meter.ObjectInstanceId = mass_rate.ObjectInstanceId and oil_rate.Timestamp = mass_rate.Timestamp
      LEFT JOIN operating_pressure on cv_Meter.ObjectInstanceId = operating_pressure.ObjectInstanceId and oil_rate.Timestamp = operating_pressure.Timestamp
WHERE cv_Meter.ObjectTypeId = 1000022 and cv_Meter.ObjectTypePropertyId = 1002949 
