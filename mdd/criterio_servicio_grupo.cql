use derivacion;

create table criterio_servicio_grupo (
	sdis_dbid 	varchar,
	gdist_dbid 	int,
	cder_dbid 	int,
	tenant_dbid 	int,
	primary key ( sdis_dbid, gdist_dbid, cder_dbid ) 
);

quit;
