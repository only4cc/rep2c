use grabaciones
go

set nocount on
go

-- Dias atras 50 --

select ANI,DNIS, count(*) 
from Grabaciones 
where fechaInicio >= convert(varchar(10), GETDATE()-50, 120)
 AND tipoLlamada = 'I'
 AND ANI <> '0000000000'
GROUP BY ANI,DNIS
go


