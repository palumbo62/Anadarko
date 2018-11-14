
-- Sample GE Historian Query 
-- The where clause should remain intact except for changing of the tagname

Select *
From ihRawData
WHERE tagname like 'WTTNBERG.UIS02.*M1_FI_G_AV'

and samplingmode = "rawbytime" and quality = "Good NonSpecific"
and timestamp < Now-6h
and timestamp > Now-48h 
and daylightsavingtime=False
and rowcount = 0

