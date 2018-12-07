DECLARE @query_start datetime = '2018/06/01'
DECLARE @query_end datetime = '2018/12/03'

SELECT * FROM PISDKRawQueryMultiThread(1, 1002235, 1, @query_start, @query_end, 'houmsivmsql201\IVMSQLTEST', DEFAULT)
--SELECT * FROM PISDKRawQueryMultiThread(1, 1002249, 1, @query_start, @query_end, 'houmsivmsql201\IVMSQLTEST', DEFAULT)
