use derivacion;

create table plataformas_desborde (
	pdesb_dbid 	int,
	gdist_dbid 	int,
	plat_dbid 	int,
	hor_dbid 	int,
	cortar_llamada 	int,
	plat_dbid_desb 	int,
	loc_dbid_desb 	int,
	primary key ( gdist_dbid, plat_dbid, hor_dbid )
);

quit;
