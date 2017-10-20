use derivacion;

create table criterio_servicio_derivacion (
	 orden		int, 
         descripcion    varchar,
	 sdis_dbid	varchar, 
	 cder_dbid 	int,
	 tenant_dbid 	int,
	 parametro 	varchar,
	 condicion 	varchar,
	 valor_condicion varchar,
	 primary key (sdis_dbid, cder_dbid)
);

quit;


