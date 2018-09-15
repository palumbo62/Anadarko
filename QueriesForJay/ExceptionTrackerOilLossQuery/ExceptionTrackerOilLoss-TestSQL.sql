    --SELECT 
    --    cv.ObjectInstanceName, 
    --    cv.ObjectTypePropertyName, 
    --    cv.ObjectInstanceId,

    --    ROW_NUMBER() OVER(ORDER BY cv.ObjectTypePropertyName) AS DayOfWeek,
    --    cv.ObjectTypePropertyName, 
    --    (select 'Fast Trips') AS PropertyName,
    --    CASE IsString 
    --        WHEN 0 THEN COALESCE(cv.CurrentValue, '0') 
    --        ELSE COALESCE(cv.CurrentValue, '') 
    --    END AS CurrentValue
    --FROM IVMPetexDP.ext.vw_CurrentValues cv
    --WHERE 
    --    (cv.ObjectTypeId = 1000001) AND
    --    (cv.DataSourceName IN ('Production Surveillance') AND
    --        cv.ObjectTypePropertyName IN (
    --            'Exception Tracker - Fast Trips - Oil Differed - Day 1',
    --            'Exception Tracker - Fast Trips - Oil Differed - Day 2',
    --            'Exception Tracker - Fast Trips - Oil Differed - Day 3',
    --            'Exception Tracker - Fast Trips - Oil Differed - Day 4',
    --            'Exception Tracker - Fast Trips - Oil Differed - Day 5',
    --            'Exception Tracker - Fast Trips - Oil Differed - Day 6',
    --            'Exception Tracker - Fast Trips - Oil Differed - Day 7',
    --            'Exception Tracker - Fast Trips - Oil Differed'
    --        ))


    SELECT 
        --cv.ObjectInstanceName, 
        --cv.ObjectInstanceId,
        --cv.ObjectTypePropertyID,

        ROW_NUMBER() OVER(ORDER BY cv.ObjectTypePropertyName) AS DayOfWeek,
        cv.ObjectTypePropertyName, 
        (select 'Gas Sales Pressure') PropertyName,
        CASE IsString 
            WHEN 0 THEN COALESCE(cv.CurrentValue, '0') 
            ELSE COALESCE(cv.CurrentValue, '') 
        END AS CurrentValue
    FROM IVMPetexDP.ext.vw_CurrentValues cv
    WHERE 
        (cv.ObjectTypeId = 1000001) AND
        (cv.DataSourceName IN ('Production Surveillance') AND
            cv.ObjectTypePropertyName IN (
                'Exception Tracker - Gas Sales Pressure - Oil Differed - Day 1',
                'Exception Tracker - Gas Sales Pressure - Oil Differed - Day 2',
                'Exception Tracker - Gas Sales Pressure - Oil Differed - Day 3',
                'Exception Tracker - Gas Sales Pressure - Oil Differed - Day 4',
                'Exception Tracker - Gas Sales Pressure - Oil Differed - Day 5',
                'Exception Tracker - Gas Sales Pressure - Oil Differed - Day 6',
                'Exception Tracker - Gas Sales Pressure - Oil Differed - Day 7',
                'Exception Tracker - Gas Sales Pressure - Oil Differed'
            ))
    ORDER BY cv.ObjectTypePropertyName
