
use derivacion;

create table grupo_distribucion_detalle (
	gdist_dbid 	int,
	plat_dbid 	int,
	tenant_dbid 	int,
	flag_reportes 	varchar,
	flag_reportes_desborde varchar,
	porcentaje 	int,
	n_llamadas 	int ,
	id_status 	int,
    primary key  ( gdist_dbid, plat_dbid )
);

quit;
