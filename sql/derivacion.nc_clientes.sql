use NC_Claro_Clientes
go

set nocount on
go

select 
	rut ,
	ani ,
	rtrim(tipo_producto) ,
	isnull(ranking,1) ,
	isnull(tipo_cliente,'NO VIP'),
	isnull(contador_llamadas,0),
	' ', --campo_01 ,
	campo_02 ,
	campo_03 ,
	campo_04 
from nc_clientes
go

quit
go

