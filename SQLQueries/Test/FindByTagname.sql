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
	  ,[CurrentText]
FROM [IVMPetexDP].[ext].[vw_CurrentValues]
WHERE -- Tagname like 'P1_C_AV' 
      --and PollGroupName  like 'Lagging Well%'
      --and PollGroupName  like 'VT Well Data%'     
	   [ObjectTypeId] = 1000048
	  and PollGroupName  like '%VT Well Data RT - _W_PI_C_AV - 1/8%'

   --group by PollGroupName