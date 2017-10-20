use derivacion;

COPY derivacion.criterio_servicio_derivacion (
         orden,
         descripcion, 
	 sdis_dbid, 
	 cder_dbid,
         tenant_dbid,
	 parametro,
	 condicion,
         valor_condicion
)
FROM '%%filename%%'
WITH DELIMITER = '|'
 AND HEADER = FALSE
 AND SKIPROWS = 0
 AND MAXINSERTERRORS = -1
 AND MAXPARSEERRORS  = -1
 AND NULL = 'NULL';

quit;


