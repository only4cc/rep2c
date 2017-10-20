use derivacion;

create table plataforma (
	plat_dbid int,
	cc_nombre varchar,
	srv_nombre varchar,
	tenant_dbid int,
	descripcion varchar,
	numero_transferencia varchar,
	grupo_transferencia varchar,
	tipo_transferencia tinyint ,
	ruteo_x_zona tinyint ,
	loc_dbid_transferencia int ,
	loc_dbid_aviso_grabacion int ,
	loc_dbid_fuera_horario int ,
	id_status int ,
	max_llamadas int ,
	cont_llamadas int,
	primary key ( plat_dbid ) 
);

quit;
