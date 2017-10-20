use derivacion
go
set nocount on
go

select 
   d.ORDEN,
   d.DESCRIPCION,
   s.SDIS_DBID SDIS_DBID,
   d.CDER_DBID CDER_DBID,
   s.TENANT_DBID TENANT_DBID,
   d.PARAMETRO PARAMETRO,
   d.CONDICION CONDICION,
   s.VALOR_CONDICION 
 From 	    [derivacion].[dbo].[CRITERIO_SERVICIO] s 
 Inner Join [derivacion].[dbo].[CRITERIO_DERIVACION] d 
		On s.CDER_DBID = d.CDER_DBID 
		And d.ID_STATUS = 1 
		And d.EVALUA_CONDICION = 1
 Where s.VALOR_CONDICION IS NOT NULL 
go

