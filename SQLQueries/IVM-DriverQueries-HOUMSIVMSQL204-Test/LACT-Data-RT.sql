DECLARE @query_start datetime = '2018/06/01';
DECLARE @query_end datetime = '2018/12/05';


-- LACT Data RT - Charge Suction Pressure
--SELECT * FROM PISDKRawQueryMultiThread(0, 1002210, 3, @query_start, @query_end, 'houmsivmsql201\IVMSQLTEST', DEFAULT)

-- LACT Data RT - Divert Valve All
--SELECT * FROM PISDKRawQueryMultiThread(0, 1001060, 3, @query_start, @query_end, 'houmsivmsql201\IVMSQLTEST', DEFAULT)

-- LACT Data RT - LOTO
--SELECT * FROM PISDKRawQueryMultiThread(0, 1002218, 3, @query_start, @query_end, 'houmsivmsql201\IVMSQLTEST', DEFAULT)

-- LACT Data RT - Oil Volume Today
--SELECT * FROM PISDKRawQueryMultiThread(0, 1002083, 3, @query_start, @query_end, 'houmsivmsql201\IVMSQLTEST', DEFAULT)
SELECT * FROM GEHistorianRawQueryMultiThread(0,1002083, 5,@query_start, @query_end)