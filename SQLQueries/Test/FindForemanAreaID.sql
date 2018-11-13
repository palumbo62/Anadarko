SELECT DISTINCT
					t1.DataSetId
					,t1.ObjectTypeName
					,t1.ObjectInstanceName
					,t1.ObjectTypePropertyId
					,t1.ObjectTypePropertyName
					,t1.DataSourceName
					,t1.Tagname
					,t1.CurrentValue
					,t1.LastGoodSampleTime
					,t1.CurrentText
				FROM [IVMPetexDP].[ext].[vw_CurrentValues] t1
					inner join IVMPetexDP.ext.vw_CurrentValues t2
						on (t1.ObjectTypePropertyName = t2.ObjectTypePropertyName) 
				--		on (t1.ObjectTypePropertyName = 'Foreman Area ID' and t1.ObjectTypePropertyName = t2.ObjectTypePropertyName) 
				WHERE 
					t1.ObjectTypeId = 1000000
  					and t1.DataSourceName = 'Well Properties'
					and t1.ObjectTypePropertyName = 'Foreman Area ID' and (t1.CurrentValue = 'E4' or t1.CurrentValue = 'E5')