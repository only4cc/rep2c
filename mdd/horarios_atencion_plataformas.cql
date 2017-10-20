use derivacion;

create table horario_atencion_plataformas (
	hor_dbid 	int ,
	plat_dbid 	int ,
	dia_semana 	int ,
	hora_inicio 	timestamp,
	hora_fin 	timestamp,
	id_status 	int ,
	primary key ( plat_dbid, hor_dbid )
);

create index idx_hora_inicio on derivacion.horario_atencion_plataformas(hora_inicio); 
create index idx_hora_fin    on derivacion.horario_atencion_plataformas(hora_fin); 

quit;
