use derivacion;

create table desborde_por_reintentos (
	sdis_dbid 	varchar,
	tenant_dbid 	int,
	nro_reintentos 	int,
	plat_dbid_desb 	int,
	fec_inicio 	timestamp,
	fec_final  	timestamp,
	id_status  	int,				-- no es necesario pero  no ocupa mayor espacio
	primary key (sdis_dbid, tenant_dbid)
)

create index idx_fec_inicio on derivacion.desborde_por_reintentos(fec_inicio); 
create index idx_fec_final  on derivacion.desborde_por_reintentos(fec_final); 

quit;
