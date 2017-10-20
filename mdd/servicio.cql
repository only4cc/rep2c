
use derivacion

create table servicio (
	srv_nombre varchar,
	tenant_dbid int,
	srv_descripcion varchar
	primary key (srv_nombre, tenant_dbid) 
 )


