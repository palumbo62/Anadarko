/****** Script for SelectTopNRows command from SSMS  ******/
SELECT DISTINCT
	   t1.DataSetId
      ,t1.ObjectTypeName
      ,t1.ObjectInstanceName
      ,t1.ObjectTypePropertyId
      ,t1.ObjectTypePropertyName
      ,t1.DataSourceName
	  ,ForemanDataSouce
	  ,ForemanAreaID
      ,t1.CurrentValue
      ,t1.LastGoodSampleTime
      ,t1.CurrentText
  FROM [IVMPetexDP].[ext].[vw_CurrentValues] t1
	inner join (SELECT DISTINCT
					t1.DataSetId
					,t1.ObjectTypeName
					,t1.ObjectInstanceName
					,t1.ObjectTypePropertyId
					,t1.ObjectTypePropertyName
					,t1.DataSourceName		ForemanDataSouce
					,t1.Tagname
					,t1.CurrentValue		ForemanAreaID
					,t1.LastGoodSampleTime
					,t1.CurrentText
				FROM [IVMPetexDP].[ext].[vw_CurrentValues] t1
					inner join IVMPetexDP.ext.vw_CurrentValues t2
						on (t1.ObjectTypePropertyName = t2.ObjectTypePropertyName) 
				--		on (t1.ObjectTypePropertyName = 'Foreman Area ID' and t1.ObjectTypePropertyName = t2.ObjectTypePropertyName) 
				WHERE 
					t1.ObjectTypeId = 1000000
					and t1.ObjectTypePropertyName = 'Foreman Area ID' and (t1.CurrentValue = 'E4' or t1.CurrentValue = 'E5')
			) t2
		on (t1.ObjectInstanceName = t2.ObjectInstanceName) 
	--inner join IVMPetexDP.ext.vw_HistoryNumeric t3
	--		on t1.DataSetId = t3.DataSetId

--		on (t1.ObjectTypePropertyName = 'Foreman Area ID' and t1.ObjectTypePropertyName = t2.ObjectTypePropertyName) 
  WHERE 
	t1.ObjectTypeId = 1000000
  	and t1.DataSourceName  like '%External%'
	and t1.ObjectTypePropertyName = 'LP Separator Oil Rate - MBX'
	--and t3.TimeOfSample > '2018/10/01'

  ORDER BY t1.ObjectTypePropertyName



  
