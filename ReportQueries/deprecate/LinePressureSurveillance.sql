with cteValue as (
select v.ObjectInstanceName, v.ObjectTypePropertyName, case IsString when 0 then coalesce(v.CurrentValue, '0') 
    else coalesce(v.CurrentValue, '') end as CurrentValue--, v.CurrentText, v.ObjectTypePropertyId  
    FROM IVMPetexDP.ext.vw_CurrentValues v
  WHERE v.ObjectTypeId			= 1000000
	AND (
			(	    v.DataSourceName		IN ( 'Plunger Surveillance')
			and v.ObjectTypePropertyName	IN ( 'Plunger Output -After Flow Time'
												,'Plunger Output - Plunger Arrivals'
												,'Plunger Output - 1 Day Casing Slope'
												,'Plunger Output - 7 Day Casing Slope'
												,'Plunger Output - Skipped Day Indicator'
												,'Plunger Output - Skipped Well Indicator'
												,'Plunger Output - Long Term Insufficient Draw Down'
											)
			) or
            
			(	    v.DataSourceName		IN ( 'Well Properties')
			and v.ObjectTypePropertyName	IN ( 'Operator Route ID'
											)
			) or
            
			(	    v.DataSourceName		IN ( 'Open Wells Plunger Data')
			and v.ObjectTypePropertyName	IN ( 'Plunger - Plunger Style'
											)
			)
		)
)
select	 ObjectInstanceName
		,[Operator Route ID] as OperatorRouteId
		,cast([Plunger Output -After Flow Time] as float) as AfterFlowTime
		,cast([Plunger Output - Plunger Arrivals] as float) as PlungerArrivals
		,[Plunger - Plunger Style] as PlungerStyle
		,cast([Plunger Output - 1 Day Casing Slope] as float) as CasingSlope1Day
		,cast([Plunger Output - 7 Day Casing Slope] as float) as CasingSlope7Day
		,[Plunger Output - Skipped Well Indicator] as SkippedWell
		,[Plunger Output - Skipped Day Indicator] as SkippedDay
		,[Plunger Output - Long Term Insufficient Draw Down] as LongTermBadDD

from 
	(select * from cteValue) as v
pivot (
	max(v.CurrentValue)
	for v.ObjectTypePropertyName in ([Operator Route ID],[Plunger - Plunger Style], 
	[Plunger Output -After Flow Time], [Plunger Output - Plunger Arrivals], 
	[Plunger Output - 1 Day Casing Slope], [Plunger Output - 7 Day Casing Slope], [Plunger Output - Skipped Well Indicator], 
	[Plunger Output - Skipped Day Indicator],[Plunger Output - Long Term Insufficient Draw Down])
) as p

where cast(p.[Plunger Output - Long Term Insufficient Draw Down] as float) = 1
    AND cast(p.[Plunger Output - Skipped Day Indicator] as float) = 0
	AND cast(p.[Plunger Output - Skipped Well Indicator] as float) = 0	

order by
	cast(p.[Plunger Output - 7 Day Casing Slope] as float)