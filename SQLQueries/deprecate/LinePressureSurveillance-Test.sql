with cteValue as (
select v.ObjectInstanceName, v.ObjectTypePropertyName, case IsString when 0 then coalesce(v.CurrentValue, '0') 
    else coalesce(v.CurrentValue, '') end as CurrentValue--, v.CurrentText, v.ObjectTypePropertyId  
    FROM IVMPetexDP.ext.vw_CurrentValues v
  WHERE v.ObjectTypeId			= 1000000
	AND (
			(	    v.DataSourceName	    IN ( 'Plunger Surveillance')
			and v.ObjectTypePropertyName	IN ( 'HF Plunger Output - Tubing Pressure - Average Bin Number'
							                    ,'HF Plunger Output - Line Pressure - Average Bin Number'
							                    ,'HF Plunger Output - Gase Sales Pressure - Average Bin Number'
							                    ,'HF Plunger Output - Average XMV to Sales Gas Pressure Delta - 7 Day'
							   				)
			) or
            
			(	    v.DataSourceName	    IN ( 'Production Surveillance')
			and v.ObjectTypePropertyName	IN ( 'Exception Tracker - Line Pressure - Oil Differed - Day 1',
							                    ,'Exception Tracker - Line Pressure - Oil Revenue Differed - Day 1',
							                    ,'Exception Tracker - Line Pressure - Oil Differed - Day 2',
							                    ,'Exception Tracker - Line Pressure - Oil Revenue Differed - Day 2',
							                    ,'Exception Tracker - Line Pressure - Oil Differed - Day 3',
							                    ,'Exception Tracker - Line Pressure - Oil Revenue Differed - Day 3',
							                    ,'Exception Tracker - Line Pressure - Oil Differed - Day 4',
							                    ,'Exception Tracker - Line Pressure - Oil Revenue Differed - Day 4',
							                    ,'Exception Tracker - Line Pressure - Oil Differed - Day 5',
							                    ,'Exception Tracker - Line Pressure - Oil Revenue Differed - Day 5',
							                    ,'Exception Tracker - Line Pressure - Oil Differed - Day 6',
							                    ,'Exception Tracker - Line Pressure - Oil Revenue Differed - Day 6',
							                    ,'Exception Tracker - Line Pressure - Oil Differed - Day 7',
							                    ,'Exception Tracker - Line Pressure - Oil Revenue Differed - Day 7',
							                    ,'Exception Tracker - Line Pressure - Oil Differed',
							                    ,'Exception Tracker - Line Pressure - Oil Revenue Differed'
											)
			) 
		)
)