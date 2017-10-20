use derivacion
go
set nocount on
go

select 
    sdis_dbid,
    tenant_dbid,
    nro_reintentos,
    plat_dbid_desb,
    fec_inicio,
    fec_final,
    id_status  	
from desborde_por_reintentos
go

quit
go
