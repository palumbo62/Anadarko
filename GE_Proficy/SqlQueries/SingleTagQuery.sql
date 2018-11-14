SELECT TOP 2000
    tagname,
    timestamp,
    value,
    quality,
    samplingmode,
    daylightsavingtime
FROM ihrawdata 
WHERE 
    tagname = 'WTTNBERG.UIS02.CROWDER_A_15C_18_W_PI_C_AV'
AND (timestamp > '09/22/2018 00:00:00'
AND timestamp < '09/26/2018 00:00:00')





