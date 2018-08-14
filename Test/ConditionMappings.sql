SELECT  ivm.Condition.ConditionId, 
        ivm.Condition.ConditionName, 
        ivm.Condition.[Text]  
              
FROM            IVMConfig.ivm.ConditionMapping

                INNER JOIN
                
                IVMConfig.ivm.Condition ON ivm.Condition.ConditionId = ivm.ConditionMapping.ConditionMappingId 
                
                --INNER JOIN
                
                --IVMPetexDP.ext.vw_CurrentValues

WHERE IVMConfig.ivm.Condition.ConditionName LIKE 'Bin %'
ORDER BY IVMConfig.ivm.Condition.ConditionId


--SELECT ivm.Condition.ConditionId, ivm.Condition.ConditionName, ivm.Condition.[Text]  
--              
--FROM            IVMConfig.ivm.ConditionMapping
--
--                INNER JOIN
--                
--                IVMConfig.ivm.Condition ON ivm.Condition.ConditionId = ivm.ConditionMapping.ConditionMappingId 
--                
--                --INNER JOIN
--                
--                --IVMPetexDP.ext.vw_CurrentValues
--
--WHERE IVMConfig.ivm.Condition.ConditionName LIKE 'Bin %'
--ORDER BY IVMConfig.ivm.Condition.ConditionId
