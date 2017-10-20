use derivacion;

COPY derivacion.locuciones_ivr (
	loc_dbid,
	nombre 
)
FROM '%%filename%%'
WITH DELIMITER = '|' 
 AND HEADER = FALSE 
 AND SKIPROWS = 0 
 AND MAXATTEMPTS=2
 AND MAXINSERTERRORS=1
 AND MAXPARSEERRORS=1;

quit;
