USE [IAMAPIUsage]
GO

/****** Object:  UserDefinedFunction [dbo].[PISDKRawQueryMultiThread]    Script Date: 12/6/2018 2:59:58 PM ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

ALTER FUNCTION [dbo].[PISDKRawQueryMultiThread](@query_typ [int], @pd_id [int], @threads [int], @start_date [datetime], @end_date [datetime], @server_name [nvarchar](30), @web_api_address [nvarchar](40) = N'http://localhost:8093/api/AF_SDK')
RETURNS  TABLE (
	[recordTagname] [nvarchar](100) NULL,
	[recordTimestamp] [datetime] NULL,
	[recordValue] [nvarchar](400) NULL
) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [historianapi_func_multithread_impersonate].[GE_API_UDF].[API_Query]
GO


