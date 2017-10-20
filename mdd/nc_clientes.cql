use derivacion;

create table nc_clientes (
	rut varchar,
	ani varchar,
	tipo_producto varchar,
	ranking int,
	tipo_cliente varchar,
	contador_llamadas int,
	campo_01 varchar,
	campo_02 varchar,
	campo_03 varchar,
	campo_04 varchar,
	primary key (ani)
);

create table nc_clientes_contador (
	ani varchar,
	contador_llamadas counter,
	primary key (ani)
);


