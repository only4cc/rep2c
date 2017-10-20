set nocount on
go
use derivacion
go

select 
    id_servicio,
    enrutamiento,
    id_status		
from enrutamiento_x_servicio
go

quit
go
