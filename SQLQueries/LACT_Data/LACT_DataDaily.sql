SELECT DISTINCT
       T3.ObjectInstanceId,
       dateadd (day, datediff (day, 0, T3.Timestamp), 0) AS Timestamp,
       T3.OilVolumeYesterday
FROM (SELECT cv_OilRate.DataSetId,
             cv_OilRate.ObjectInstanceId,
             hv_OilRate.TimeOfSample
                AS Timestamp,
             hv_OilRate.Value
                AS OilVolumeYesterday,
             RANK ()
             OVER (
                PARTITION BY cv_OilRate.DataSetId,
                             dateadd (
                                day,
                                datediff (day, 0, hv_OilRate.TimeOfSample),
                                0)
                ORDER BY hv_OilRate.TimeOfSample DESC)
                AS val_rank
      FROM IVMPetexDP.ext.vw_CurrentValues cv_OilRate
           INNER JOIN IVMPetexDP.ext.vw_HistoryNumeric hv_OilRate
              ON     cv_OilRate.DataSetId = hv_OilRate.DataSetId
                 AND hv_OilRate.TimeOfSample >
                     DateAdd (hour, -336, GetDate ())
      WHERE     cv_OilRate.ObjectTypeId = 1000022
            AND cv_OilRate.ObjectTypePropertyId = 1002937) T3
WHERE T3.val_rank = 1       ) ,  oil_thismonth              AS

(SELECT T3.ObjectInstanceId,
        dateadd (day, datediff (day, 0, T3.Timestamp), 0) AS Timestamp,
        T3.OilVolume_ThisMonth
 FROM (SELECT cv_OilRate.ObjectInstanceId,
              hv_OilRate.TimeOfSample
                 AS Timestamp,
              hv_OilRate.Value
                 AS OilVolume_ThisMonth,
              RANK ()
              OVER (
                 PARTITION BY cv_OilRate.DataSetId,
                              dateadd (
                                 day,
                                 datediff (day, 0, hv_OilRate.TimeOfSample),
                                 0)
                 ORDER BY hv_OilRate.TimeOfSample DESC)
                 AS val_rank
       FROM IVMPetexDP.ext.vw_CurrentValues cv_OilRate
            INNER JOIN IVMPetexDP.ext.vw_HistoryNumeric hv_OilRate
               ON     cv_OilRate.DataSetId = hv_OilRate.DataSetId
                  AND hv_OilRate.TimeOfSample >
                      DateAdd (hour, -336, GetDate ())
       WHERE     cv_OilRate.ObjectTypeId = 1000022
             AND cv_OilRate.ObjectTypePropertyId = 1002931) T3
 WHERE T3.val_rank = 1)      ,  oil_lastmonth              AS

(SELECT T3.ObjectInstanceId,
        dateadd (day, datediff (day, 0, T3.Timestamp), 0) AS Timestamp,
        T3.OilVolume_LastMonth
 FROM (SELECT cv_OilRate.ObjectInstanceId,
              hv_OilRate.TimeOfSample
                 AS Timestamp,
              hv_OilRate.Value
                 AS OilVolume_LastMonth,
              RANK ()
              OVER (
                 PARTITION BY cv_OilRate.DataSetId,
                              dateadd (
                                 day,
                                 datediff (day, 0, hv_OilRate.TimeOfSample),
                                 0)
                 ORDER BY hv_OilRate.TimeOfSample DESC)
                 AS val_rank
       FROM IVMPetexDP.ext.vw_CurrentValues cv_OilRate
            INNER JOIN IVMPetexDP.ext.vw_HistoryNumeric hv_OilRate
               ON     cv_OilRate.DataSetId = hv_OilRate.DataSetId
                  AND hv_OilRate.TimeOfSample >
                      DateAdd (hour, -336, GetDate ())
       WHERE     cv_OilRate.ObjectTypeId = 1000022
             AND cv_OilRate.ObjectTypePropertyId = 1002935) T3
 WHERE T3.val_rank = 1)      ,  oil_flowtimetoday                  AS

(SELECT T3.ObjectInstanceId,
        dateadd (day, datediff (day, 0, T3.Timestamp), 0) AS Timestamp,
        T3.FlowTime_Today
 FROM (SELECT cv_OilRate.ObjectInstanceId,
              hv_OilRate.TimeOfSample
                 AS Timestamp,
              hv_OilRate.Value
                 AS FlowTime_Today,
              RANK ()
              OVER (
                 PARTITION BY cv_OilRate.DataSetId,
                              dateadd (
                                 day,
                                 datediff (day, 0, hv_OilRate.TimeOfSample),
                                 0)
                 ORDER BY hv_OilRate.TimeOfSample DESC)
                 AS val_rank
       FROM IVMPetexDP.ext.vw_CurrentValues cv_OilRate
            INNER JOIN IVMPetexDP.ext.vw_HistoryNumeric hv_OilRate
               ON     cv_OilRate.DataSetId = hv_OilRate.DataSetId
                  AND hv_OilRate.TimeOfSample >
                      DateAdd (hour, -336, GetDate ())
       WHERE     cv_OilRate.ObjectTypeId = 1000022
             AND cv_OilRate.ObjectTypePropertyId = 1002940) T3
 WHERE T3.val_rank = 1)      ,  mass_today           AS

(SELECT T3.ObjectInstanceId,
        dateadd (day, datediff (day, 0, T3.Timestamp), 0) AS Timestamp,
        T3.MassRate_Today
 FROM (SELECT cv_OilRate.ObjectInstanceId,
              hv_OilRate.TimeOfSample
                 AS Timestamp,
              hv_OilRate.Value
                 AS MassRate_Today,
              RANK ()
              OVER (
                 PARTITION BY cv_OilRate.DataSetId,
                              dateadd (
                                 day,
                                 datediff (day, 0, hv_OilRate.TimeOfSample),
                                 0)
                 ORDER BY hv_OilRate.TimeOfSample DESC)
                 AS val_rank
       FROM IVMPetexDP.ext.vw_CurrentValues cv_OilRate
            INNER JOIN IVMPetexDP.ext.vw_HistoryNumeric hv_OilRate
               ON     cv_OilRate.DataSetId = hv_OilRate.DataSetId
                  AND hv_OilRate.TimeOfSample >
                      DateAdd (hour, -336, GetDate ())
       WHERE     cv_OilRate.ObjectTypeId = 1000022
             AND cv_OilRate.ObjectTypePropertyId = 1002934) T3
 WHERE T3.val_rank = 1)      ,  mass_yest          AS

(SELECT T3.ObjectInstanceId,
        dateadd (day, datediff (day, 0, T3.Timestamp), 0) AS Timestamp,
        T3.MassRateYesterday
 FROM (SELECT cv_OilRate.ObjectInstanceId,
              hv_OilRate.TimeOfSample
                 AS Timestamp,
              hv_OilRate.Value
                 AS MassRateYesterday,
              RANK ()
              OVER (
                 PARTITION BY cv_OilRate.DataSetId,
                              dateadd (
                                 day,
                                 datediff (day, 0, hv_OilRate.TimeOfSample),
                                 0)
                 ORDER BY hv_OilRate.TimeOfSample DESC)
                 AS val_rank
       FROM IVMPetexDP.ext.vw_CurrentValues cv_OilRate
            INNER JOIN IVMPetexDP.ext.vw_HistoryNumeric hv_OilRate
               ON     cv_OilRate.DataSetId = hv_OilRate.DataSetId
                  AND hv_OilRate.TimeOfSample >
                      DateAdd (hour, -336, GetDate ())
       WHERE     cv_OilRate.ObjectTypeId = 1000022
             AND cv_OilRate.ObjectTypePropertyId = 1002938) T3
 WHERE T3.val_rank = 1)      ,  mass_thismonth               AS

(SELECT T3.ObjectInstanceId,
        dateadd (day, datediff (day, 0, T3.Timestamp), 0) AS Timestamp,
        T3.Mass_ThisMonth
 FROM (SELECT cv_OilRate.ObjectInstanceId,
              hv_OilRate.TimeOfSample
                 AS Timestamp,
              hv_OilRate.Value
                 AS Mass_ThisMonth,
              RANK ()
              OVER (
                 PARTITION BY cv_OilRate.DataSetId,
                              dateadd (
                                 day,
                                 datediff (day, 0, hv_OilRate.TimeOfSample),
                                 0)
                 ORDER BY hv_OilRate.TimeOfSample DESC)
                 AS val_rank
       FROM IVMPetexDP.ext.vw_CurrentValues cv_OilRate
            INNER JOIN IVMPetexDP.ext.vw_HistoryNumeric hv_OilRate
               ON     cv_OilRate.DataSetId = hv_OilRate.DataSetId
                  AND hv_OilRate.TimeOfSample >
                      DateAdd (hour, -336, GetDate ())
       WHERE     cv_OilRate.ObjectTypeId = 1000022
             AND cv_OilRate.ObjectTypePropertyId = 1002932) T3
 WHERE T3.val_rank = 1)      ,  mass_lastmonth               AS

(SELECT T3.ObjectInstanceId,
        dateadd (day, datediff (day, 0, T3.Timestamp), 0) AS Timestamp,
        T3.Mass_LastMonth
 FROM (SELECT cv_OilRate.ObjectInstanceId,
              hv_OilRate.TimeOfSample
                 AS Timestamp,
              hv_OilRate.Value
                 AS Mass_LastMonth,
              RANK ()
              OVER (
                 PARTITION BY cv_OilRate.DataSetId,
                              dateadd (
                                 day,
                                 datediff (day, 0, hv_OilRate.TimeOfSample),
                                 0)
                 ORDER BY hv_OilRate.TimeOfSample DESC)
                 AS val_rank
       FROM IVMPetexDP.ext.vw_CurrentValues cv_OilRate
            INNER JOIN IVMPetexDP.ext.vw_HistoryNumeric hv_OilRate
               ON     cv_OilRate.DataSetId = hv_OilRate.DataSetId
                  AND hv_OilRate.TimeOfSample >
                      DateAdd (hour, -336, GetDate ())
       WHERE     cv_OilRate.ObjectTypeId = 1000022
             AND cv_OilRate.ObjectTypePropertyId = 1002936) T3
 WHERE T3.val_rank = 1)

SELECT cv_Meter.ObjectInstanceId,
       cv_Meter.ObjectInstanceName AS LACT_Name,
       Concat (cv_ShortName.CurrentValue, '_M1_101') AS FAC_ID,
       CAST (cv_Lat.CurrentValue AS FLOAT) AS Latitude,
       CAST (cv_Long.CurrentValue AS FLOAT) AS Longitude,
       cv_Meter.CurrentValue AS Meter_Number,
       oil_yest.Timestamp,
       oil_yest.OilVolumeYesterday,
       oil_thismonth.OilVolume_ThisMonth,
       oil_lastmonth.OilVolume_LastMonth,
       oil_flowtimetoday.FlowTime_Today,
       mass_today.MassRate_Today,
       mass_yest.MassRateYesterday,
       mass_thismonth.Mass_ThisMonth,
       mass_lastmonth.Mass_LastMonth
FROM IVMPetexDP.ext.vw_CurrentValues cv_Meter
     INNER JOIN IVMPetexDP.ext.vw_CurrentValues cv_ShortName
        ON     cv_Meter.ObjectInstanceId = cv_ShortName.ObjectInstanceId
           AND cv_ShortName.ObjectTypePropertyId = 1005168
     INNER JOIN IVMPetexDP.ext.vw_CurrentValues cv_Delete
        ON     cv_Meter.ObjectInstanceId = cv_Delete.ObjectInstanceId
           AND cv_Delete.ObjectTypePropertyId = 1004499
           AND cv_Delete.CurrentValue = 0
     INNER JOIN IVMPetexDP.ext.vw_CurrentValues cv_Lat
        ON     cv_Meter.ObjectInstanceId = cv_Lat.ObjectInstanceId
           AND cv_Lat.ObjectTypePropertyId = 1003001
     INNER JOIN IVMPetexDP.ext.vw_CurrentValues cv_Long
        ON     cv_Meter.ObjectInstanceId = cv_Long.ObjectInstanceId
           AND cv_Long.ObjectTypePropertyId = 1003002
     INNER JOIN oil_yest
        ON cv_Meter.ObjectInstanceId = oil_yest.ObjectInstanceId
     LEFT JOIN oil_thismonth
        ON     cv_Meter.ObjectInstanceId = oil_thismonth.ObjectInstanceId
           AND oil_yest.Timestamp = oil_thismonth.Timestamp
     LEFT JOIN oil_lastmonth
        ON     cv_Meter.ObjectInstanceId = oil_lastmonth.ObjectInstanceId
           AND oil_yest.Timestamp = oil_lastmonth.Timestamp
     LEFT JOIN oil_flowtimetoday
        ON     cv_Meter.ObjectInstanceId = oil_flowtimetoday.ObjectInstanceId
           AND oil_yest.Timestamp = oil_flowtimetoday.Timestamp
     LEFT JOIN mass_today
        ON     cv_Meter.ObjectInstanceId = mass_today.ObjectInstanceId
           AND oil_yest.Timestamp = mass_today.Timestamp
     LEFT JOIN mass_yest
        ON     cv_Meter.ObjectInstanceId = mass_yest.ObjectInstanceId
           AND oil_yest.Timestamp = mass_yest.Timestamp
     LEFT JOIN mass_thismonth
        ON     cv_Meter.ObjectInstanceId = mass_thismonth.ObjectInstanceId
           AND oil_yest.Timestamp = mass_thismonth.Timestamp
     LEFT JOIN mass_lastmonth
        ON     cv_Meter.ObjectInstanceId = mass_lastmonth.ObjectInstanceId
           AND oil_yest.Timestamp = mass_lastmonth.Timestamp
WHERE     cv_Meter.ObjectTypeId = 1000022
      AND cv_Meter.ObjectTypePropertyId = 1002949