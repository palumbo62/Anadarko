USE [IAMAPIUsage]
GO

/****** Object:  SqlAssembly [historianapi_func_multithread_impersonate_xrlp]    Script Date: 12/6/2018 3:06:58 PM ******/
DROP ASSEMBLY [historianapi_func_multithread_impersonate_xrlp]
GO

/****** Object:  SqlAssembly [historianapi_func_multithread_impersonate_xrlp]    Script Date: 12/6/2018 3:06:58 PM ******/
CREATE ASSEMBLY [historianapi_func_multithread_impersonate_xrlp]
FROM "C:\Users\svcpetex\Desktop\PIAF_UDF_multithread\PIAF_UDF_Multithread\bin\Debug\historianapi_func_multithread_impersonate_xrlp.dll"
WITH PERMISSION_SET = UNRESTRICTED
GO


