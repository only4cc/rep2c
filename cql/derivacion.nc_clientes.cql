use derivacion;

COPY derivacion.nc_clientes
(
	rut ,
	ani ,
	tipo_producto ,
	ranking ,
	tipo_cliente ,
	contador_llamadas ,
	campo_01 ,
	campo_02 ,
	campo_03 ,
	campo_04 
)
FROM '%%filename%%'
WITH DELIMITER = '|'
 AND HEADER = FALSE
 AND SKIPROWS = 0
 AND MAXINSERTERRORS = -1
 AND MAXPARSEERRORS  = -1
 AND NULL = 'NULL'
 AND ERRFILE = '/home/rep2c/proy/rep2c/import_derivacion_nc_clientes.err';


quit;
