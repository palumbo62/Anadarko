SELECT TOP 2000
    tagname,
    timestamp,
    value,
    quality,
    samplingmode,
    daylightsavingtime
FROM ihrawdata 
WHERE 
    tagname = 'WTTNBERG.UIS05.A218G30_M*'
    AND samplingmode = 'rawbytime' 
    AND quality = 'Good NonSpecific'
    AND timestamp < Now - 6h
    AND timestamp >  Now - 155h
    AND daylightsavingtime = false
    AND rowcount = 0
