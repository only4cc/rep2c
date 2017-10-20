use derivacion
go
set nocount on
go

select 
   srv_nombre,
   tenant_dbid,
   srv_descripcion
from servicio
go

quit
go
