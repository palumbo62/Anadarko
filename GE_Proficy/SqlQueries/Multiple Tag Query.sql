SET rowcount = 0

SELECT tagname,
    timestamp,
    value
    
FROM ihRawData

WHERE
    (
     tagname= 'WTTNBERG.UIS06:CLINE_A_28N_2_W_PI_T_AV'
    OR tagname= 'WTTNBERG.UIS06:CLINE_A_28N_2_W_PI_C_AV'
    OR tagname=  'WTTNBERG.UIS06:CLINE_A_28N_2_M1_PI_S_AV'
    OR tagname=  'WTTNBERG.UIS06:CLINE_A_28N_2_M1_FQ_GY'
    OR tagname=  'WTTNBERG.UIS06:CLINE_A_28N_2_M2_FQ_GY'
    OR tagname=  'WTTNBERG.UIS06:CLINE_A_28N_2_M1_FI_G_AV'
    OR tagname=  'WTTNBERG.UIS06:CLINE_A_28N_2O_M1_FQ_OY'
    OR tagname=  'WTTNBERG.UIS06:CLINE_A_28N_2_W_FQ_WY'

    )
    AND samplingmode = 'rawbytime' 
    AND quality = 'Good NonSpecific'
    AND timestamp < '2016-11-15 0:00:00'
    AND timestamp >  '2016-11-01 0:00:00'
    AND daylightsavingtime = 'False'