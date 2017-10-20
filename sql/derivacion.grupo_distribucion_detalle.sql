use derivacion
go
set nocount on
go

select 
     gdist_dbid,
     plat_dbid,
     tenant_dbid,
     flag_reportes,
     flag_reportes_desborde,
     porcentaje,
     n_llamadas,
     id_status 	
from grupo_distribucion_detalle
go

quit
go
