SELECT 
		CONCAT(vw_CurrentValues.PollGroupName, ' has not received new data since ', Max(vw_CurrentValues.LastGoodSampleTime), '.') as email_message,
		CONCAT('_', vw_CurrentValues.PollGroupName, '_ has not received new data since ', Max(vw_CurrentValues.LastGoodSampleTime), '.') as slack_message
FROM IVMPetexDP.ext.vw_CurrentValues vw_CurrentValues
WHERE (vw_CurrentValues.PollGroupName LIKE 'Well Data RT%' or vw_CurrentValues.PollGroupName LIKE 'Lagging%'
              	or vw_CurrentValues.PollGroupName LIKE 'Sep Data RT%' or vw_CurrentValues.PollGroupName LIKE 'LACT -%')
              	and vw_CurrentValues.PollGroupName NOT IN ('Well Data RT - _W_G_DSX - 1/8','Well Data RT - _W_G_MSK - 1/8','Well Data RT - _W_TI_SR_T - 1/8')
              	AND vw_CurrentValues.PollGroupName NOT LIKE 'Well Data RT - O_M1_FI_O_AV%'
GROUP BY vw_CurrentValues.PollGroupName
HAVING Max(vw_CurrentValues.LastGoodSampleTime) < GETDATE()-1.1
                                
UNION

SELECT 
		CONCAT(vw_CurrentValues.PollGroupName, ' has not received new data since ', Max(vw_CurrentValues.LastGoodSampleTime), '.') as email_message,
		CONCAT('_', vw_CurrentValues.PollGroupName, '_ has not received new data since ', Max(vw_CurrentValues.LastGoodSampleTime), '.') as slack_message
FROM IVMPetexDP.ext.vw_CurrentValues vw_CurrentValues
WHERE vw_CurrentValues.PollGroupName IN ('Well Data - PDB', 'Well Data - PDB Comments', 'Well Data - PDB Downtime')                                   
GROUP BY vw_CurrentValues.PollGroupName
HAVING Max(vw_CurrentValues.LastGoodSampleTime) < GETDATE()-1.5