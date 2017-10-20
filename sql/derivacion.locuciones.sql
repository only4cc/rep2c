use derivacion
go
set nocount on
go

select 
        loc_dbid,
	catloc_identificador,
	loc_nombre_orig,
	loc_nombre_sist,
	loc_texto,
	id_status,
	tenant_dbid
from dbo.locuciones
go

