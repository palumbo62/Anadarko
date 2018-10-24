WITH
   oil_rate
   AS
      (SELECT cv_OilRate.ObjectInstanceId,
              DATEADD (hour, DATEDIFF (hour, 0, hv_OilRate.TimeOfSample), 0)
                 AS Timestamp,
              AVG (hv_OilRate.Value)
                 AS OilRate
       FROM IVMPetexDP.ext.vw_CurrentValues AS cv_OilRate
            INNER JOIN IVMPetexDP.ext.vw_HistoryNumeric AS hv_OilRate
               ON     cv_OilRate.DataSetId = hv_OilRate.DataSetId
                  AND hv_OilRate.TimeOfSample >
                      DATEADD (hour, -336, GETDATE ())
       WHERE     (cv_OilRate.ObjectTypeId = 1000022)
             AND (cv_OilRate.ObjectTypePropertyId = 1002929)
       GROUP BY cv_OilRate.ObjectInstanceId,
                DATEADD (hour,
                         DATEDIFF (hour, 0, hv_OilRate.TimeOfSample),
                         0)),
   oil_today
   AS
      (SELECT cv_OilRate.ObjectInstanceId,
              DATEADD (hour, DATEDIFF (hour, 0, hv_OilRate.TimeOfSample), 0)
                 AS Timestamp,
              AVG (hv_OilRate.Value)
                 AS OilToday
       FROM IVMPetexDP.ext.vw_CurrentValues AS cv_OilRate
            INNER JOIN IVMPetexDP.ext.vw_HistoryNumeric AS hv_OilRate
               ON     cv_OilRate.DataSetId = hv_OilRate.DataSetId
                  AND hv_OilRate.TimeOfSample >
                      DATEADD (hour, -336, GETDATE ())
       WHERE     (cv_OilRate.ObjectTypeId = 1000022)
             AND (cv_OilRate.ObjectTypePropertyId = 1002933)
       GROUP BY cv_OilRate.ObjectInstanceId,
                DATEADD (hour,
                         DATEDIFF (hour, 0, hv_OilRate.TimeOfSample),
                         0)),
   oil_press
   AS
      (SELECT cv_OilRate.ObjectInstanceId,
              DATEADD (hour, DATEDIFF (hour, 0, hv_OilRate.TimeOfSample), 0)
                 AS Timestamp,
              AVG (hv_OilRate.Value)
                 AS OilPress
       FROM IVMPetexDP.ext.vw_CurrentValues AS cv_OilRate
            INNER JOIN IVMPetexDP.ext.vw_HistoryNumeric AS hv_OilRate
               ON     cv_OilRate.DataSetId = hv_OilRate.DataSetId
                  AND hv_OilRate.TimeOfSample >
                      DATEADD (hour, -336, GETDATE ())
       WHERE     (cv_OilRate.ObjectTypeId = 1000022)
             AND (cv_OilRate.ObjectTypePropertyId = 1002947)
       GROUP BY cv_OilRate.ObjectInstanceId,
                DATEADD (hour,
                         DATEDIFF (hour, 0, hv_OilRate.TimeOfSample),
                         0)),
   oil_temp
   AS
      (SELECT cv_OilRate.ObjectInstanceId,
              DATEADD (hour, DATEDIFF (hour, 0, hv_OilRate.TimeOfSample), 0)
                 AS Timestamp,
              AVG (hv_OilRate.Value)
                 AS OilTemp
       FROM IVMPetexDP.ext.vw_CurrentValues AS cv_OilRate
            INNER JOIN IVMPetexDP.ext.vw_HistoryNumeric AS hv_OilRate
               ON     cv_OilRate.DataSetId = hv_OilRate.DataSetId
                  AND hv_OilRate.TimeOfSample >
                      DATEADD (hour, -336, GETDATE ())
       WHERE     (cv_OilRate.ObjectTypeId = 1000022)
             AND (cv_OilRate.ObjectTypePropertyId = 1002942)
       GROUP BY cv_OilRate.ObjectInstanceId,
                DATEADD (hour,
                         DATEDIFF (hour, 0, hv_OilRate.TimeOfSample),
                         0)),
   oil_dens
   AS
      (SELECT cv_OilRate.ObjectInstanceId,
              DATEADD (hour, DATEDIFF (hour, 0, hv_OilRate.TimeOfSample), 0)
                 AS Timestamp,
              AVG (hv_OilRate.Value)
                 AS OilDens
       FROM IVMPetexDP.ext.vw_CurrentValues AS cv_OilRate
            INNER JOIN IVMPetexDP.ext.vw_HistoryNumeric AS hv_OilRate
               ON     cv_OilRate.DataSetId = hv_OilRate.DataSetId
                  AND hv_OilRate.TimeOfSample >
                      DATEADD (hour, -336, GETDATE ())
       WHERE     (cv_OilRate.ObjectTypeId = 1000022)
             AND (cv_OilRate.ObjectTypePropertyId = 1002925)
       GROUP BY cv_OilRate.ObjectInstanceId,
                DATEADD (hour,
                         DATEDIFF (hour, 0, hv_OilRate.TimeOfSample),
                         0)),
   drive_gain
   AS
      (SELECT cv_OilRate.ObjectInstanceId,
              DATEADD (hour, DATEDIFF (hour, 0, hv_OilRate.TimeOfSample), 0)
                 AS Timestamp,
              AVG (hv_OilRate.Value)
                 AS DriveGain
       FROM IVMPetexDP.ext.vw_CurrentValues AS cv_OilRate
            INNER JOIN IVMPetexDP.ext.vw_HistoryNumeric AS hv_OilRate
               ON     cv_OilRate.DataSetId = hv_OilRate.DataSetId
                  AND hv_OilRate.TimeOfSample >
                      DATEADD (hour, -336, GETDATE ())
       WHERE     (cv_OilRate.ObjectTypeId = 1000022)
             AND (cv_OilRate.ObjectTypePropertyId = 1002926)
       GROUP BY cv_OilRate.ObjectInstanceId,
                DATEADD (hour,
                         DATEDIFF (hour, 0, hv_OilRate.TimeOfSample),
                         0)),
   mass_rate
   AS
      (SELECT cv_OilRate.ObjectInstanceId,
              DATEADD (hour, DATEDIFF (hour, 0, hv_OilRate.TimeOfSample), 0)
                 AS Timestamp,
              AVG (hv_OilRate.Value)
                 AS MassRate
       FROM IVMPetexDP.ext.vw_CurrentValues AS cv_OilRate
            INNER JOIN IVMPetexDP.ext.vw_HistoryNumeric AS hv_OilRate
               ON     cv_OilRate.DataSetId = hv_OilRate.DataSetId
                  AND hv_OilRate.TimeOfSample >
                      DATEADD (hour, -336, GETDATE ())
       WHERE     (cv_OilRate.ObjectTypeId = 1000022)
             AND (cv_OilRate.ObjectTypePropertyId = 1002930)
       GROUP BY cv_OilRate.ObjectInstanceId,
                DATEADD (hour,
                         DATEDIFF (hour, 0, hv_OilRate.TimeOfSample),
                         0)),
   operating_pressure
   AS
      (SELECT cv_OilRate.ObjectInstanceId,
              DATEADD (hour, DATEDIFF (hour, 0, hv_OilRate.TimeOfSample), 0)
                 AS Timestamp,
              AVG (hv_OilRate.Value)
                 AS MeterOpPressure
       FROM IVMPetexDP.ext.vw_CurrentValues AS cv_OilRate
            INNER JOIN IVMPetexDP.ext.vw_HistoryNumeric AS hv_OilRate
               ON     cv_OilRate.DataSetId = hv_OilRate.DataSetId
                  AND hv_OilRate.TimeOfSample >
                      DATEADD (hour, -336, GETDATE ())
       WHERE     (cv_OilRate.ObjectTypeId = 1000022)
             AND (cv_OilRate.ObjectTypePropertyId = 1002941)
       GROUP BY cv_OilRate.ObjectInstanceId,
                DATEADD (hour,
                         DATEDIFF (hour, 0, hv_OilRate.TimeOfSample),
                         0)),
   bsw
   AS
      (SELECT cv_OilRate.ObjectInstanceId,
              DATEADD (hour, DATEDIFF (hour, 0, hv_OilRate.TimeOfSample), 0)
                 AS Timestamp,
              AVG (hv_OilRate.Value)
                 AS BSW
       FROM IVMPetexDP.ext.vw_CurrentValues AS cv_OilRate
            INNER JOIN IVMPetexDP.ext.vw_HistoryNumeric AS hv_OilRate
               ON     cv_OilRate.DataSetId = hv_OilRate.DataSetId
                  AND hv_OilRate.TimeOfSample >
                      DATEADD (hour, -336, GETDATE ())
       WHERE     (cv_OilRate.ObjectTypeId = 1000022)
             AND (cv_OilRate.ObjectTypePropertyId = 1009990)
       GROUP BY cv_OilRate.ObjectInstanceId,
                DATEADD (hour,
                         DATEDIFF (hour, 0, hv_OilRate.TimeOfSample),
                         0))
SELECT cv_Meter.ObjectInstanceId,
       cv_Meter.ObjectInstanceName AS LACT_Name,
       {FN CONCAT (cv_ShortName.CurrentValue, '_M1_101')} AS FAC_ID,
       CAST (cv_Lat.CurrentValue AS FLOAT) AS Latitude,
       CAST (cv_Long.CurrentValue AS FLOAT) AS Longitude,
       cv_Meter.CurrentValue AS Meter_Number,
       oil_rate_1.Timestamp,
       oil_rate_1.OilRate,
       oil_press_1.OilPress,
       oil_temp_1.OilTemp,
       oil_dens_1.OilDens,
       oil_today_1.OilToday,
       drive_gain_1.DriveGain,
       bsw_1.BSW,
       operating_pressure_1.MeterOpPressure,
       mass_rate_1.MassRate
FROM IVMPetexDP.ext.vw_CurrentValues AS cv_Meter
     INNER JOIN IVMPetexDP.ext.vw_CurrentValues AS cv_ShortName
        ON     cv_Meter.ObjectInstanceId = cv_ShortName.ObjectInstanceId
           AND cv_ShortName.ObjectTypePropertyId = 1005168
     INNER JOIN IVMPetexDP.ext.vw_CurrentValues AS cv_Delete
        ON     cv_Meter.ObjectInstanceId = cv_Delete.ObjectInstanceId
           AND cv_Delete.ObjectTypePropertyId = 1004499
           AND cv_Delete.CurrentValue = 0
     INNER JOIN IVMPetexDP.ext.vw_CurrentValues AS cv_Lat
        ON     cv_Meter.ObjectInstanceId = cv_Lat.ObjectInstanceId
           AND cv_Lat.ObjectTypePropertyId = 1003001
     INNER JOIN IVMPetexDP.ext.vw_CurrentValues AS cv_Long
        ON     cv_Meter.ObjectInstanceId = cv_Long.ObjectInstanceId
           AND cv_Long.ObjectTypePropertyId = 1003002
     INNER JOIN oil_rate AS oil_rate_1
        ON cv_Meter.ObjectInstanceId = oil_rate_1.ObjectInstanceId
     LEFT OUTER JOIN oil_press AS oil_press_1
        ON     cv_Meter.ObjectInstanceId = oil_press_1.ObjectInstanceId
           AND oil_rate_1.Timestamp = oil_press_1.Timestamp
     LEFT OUTER JOIN oil_temp AS oil_temp_1
        ON     cv_Meter.ObjectInstanceId = oil_temp_1.ObjectInstanceId
           AND oil_rate_1.Timestamp = oil_temp_1.Timestamp
     LEFT OUTER JOIN oil_dens AS oil_dens_1
        ON     cv_Meter.ObjectInstanceId = oil_dens_1.ObjectInstanceId
           AND oil_rate_1.Timestamp = oil_dens_1.Timestamp
     LEFT OUTER JOIN oil_today AS oil_today_1
        ON     cv_Meter.ObjectInstanceId = oil_today_1.ObjectInstanceId
           AND oil_rate_1.Timestamp = oil_today_1.Timestamp
     LEFT OUTER JOIN drive_gain AS drive_gain_1
        ON     cv_Meter.ObjectInstanceId = drive_gain_1.ObjectInstanceId
           AND oil_rate_1.Timestamp = drive_gain_1.Timestamp
     LEFT OUTER JOIN bsw AS bsw_1
        ON     cv_Meter.ObjectInstanceId = bsw_1.ObjectInstanceId
           AND oil_rate_1.Timestamp = bsw_1.Timestamp
     LEFT OUTER JOIN mass_rate AS mass_rate_1
        ON     cv_Meter.ObjectInstanceId = mass_rate_1.ObjectInstanceId
           AND oil_rate_1.Timestamp = mass_rate_1.Timestamp
     LEFT OUTER JOIN operating_pressure AS operating_pressure_1
        ON     cv_Meter.ObjectInstanceId =
               operating_pressure_1.ObjectInstanceId
           AND oil_rate_1.Timestamp = operating_pressure_1.Timestamp
WHERE     (cv_Meter.ObjectTypeId = 1000022)
      AND (cv_Meter.ObjectTypePropertyId = 1002949)