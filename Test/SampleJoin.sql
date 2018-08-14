
SELECT        vw_History.NumericValue * 64 AS Choke_Size, 
              convert(datetime,convert(varchar,vw_History.TimeOfSample,101)) as TimeOfSample, 
              vw_CurrentValues.ObjectInstanceId, 
               vw_CurrentValues.ObjectInstanceName, 
               vw_WINS.CurrentValue AS WINS

FROM            IVMPetexDP.ext.vw_CurrentValues AS vw_CurrentValues 

                INNER JOIN
                
                IVMPetexDP.ext.vw_CurrentValues AS vw_WINS ON vw_CurrentValues.ObjectInstanceId = vw_WINS.ObjectInstanceId AND vw_WINS.ObjectTypePropertyName = 'WINS' AND vw_WINS.DataSourceName = 'Well Properties' 
                
                INNER JOIN
                
                IVMPetexDP.ext.vw_History AS vw_History ON vw_CurrentValues.DataSetId = vw_History.DataSetId

WHERE        (vw_CurrentValues.ObjectTypeId = 1000000) AND (vw_CurrentValues.ObjectTypePropertyId = 1004102) AND (vw_CurrentValues.DataSourceName = 'Choke Changes')

