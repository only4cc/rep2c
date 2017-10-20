use derivacion;

COPY derivacion.desborde_por_reintentos (
        sdis_dbid,
	tenant_dbid,
	nro_reintentos,
	plat_dbid_desb,
	fec_inicio,
	fec_final,
	id_status  
)
FROM '%%filename%%'
WITH DELIMITER = '|' 
 AND HEADER = FALSE 
 AND SKIPROWS = 0 
 AND MAXATTEMPTS=2
 AND MAXINSERTERRORS=1
 AND MAXPARSEERRORS=1;

quit;
