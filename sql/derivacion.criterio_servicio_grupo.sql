use derivacion
go

set nocount on
go

select 
   sdis_dbid,
   gdist_dbid,
   cder_dbid,
   tenant_dbid
from criterio_servicio_grupo
go

