use derivacion;

COPY derivacion.locuciones (
        loc_dbid,
	catloc_identificador,
	loc_nombre_orig,
	loc_nombre_sist,
	loc_texto,
	id_status,
	tenant_dbid
)
FROM '%%filename%%'
WITH DELIMITER = '|' 
 AND HEADER = FALSE 
 AND SKIPROWS = 0 
 AND MAXATTEMPTS=2
 AND MAXINSERTERRORS=1
 AND MAXPARSEERRORS=1;

quit;
