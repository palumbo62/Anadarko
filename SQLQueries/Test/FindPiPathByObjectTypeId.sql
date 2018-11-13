SELECT [DataSetId]
      ,[ObjectTypeId]
      ,[ObjectTypeName]
      ,[ObjectInstanceId]
      ,[ObjectInstanceName]
      ,[ObjectTypePropertyName]
      ,[DataSourceName]
      ,[PollGroupId]
      ,[PollGroupName]
      ,[Tagname]
      ,[AliasText]
      ,[CurrentValue]
      ,[LastGoodSampleTime]
  FROM [IVMPetexDP].[ext].[vw_CurrentValues]
  where ObjectTypePropertyName like 'PI Path%' 
	AND ObjectTypeId = 1000023
      --and PollGroupName  like 'Lagging Well%'
      --and PollGroupName  like 'VT Well Data%'     
	  --and DataSourceId = 1000000
	  --and PollGroupName  like 'Well Data%'
	  --and AliasText like 'MMscf'
   --group by PollGroupName
   order by 
	ObjectTypeId