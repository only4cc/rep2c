use derivacion;

COPY derivacion.grabaciones_ani_dnis
(
	ani ,
	dnis ,
	cuenta 
)
FROM '%%filename%%'
WITH DELIMITER = '|'
 AND HEADER = FALSE
 AND SKIPROWS = 0
 AND MAXINSERTERRORS = -1
 AND MAXPARSEERRORS  = -1
 AND NULL = 'NULL'
 AND ERRFILE = '/home/rep2c/proy/rep2c/import_grabaciones_ani_dnis.err';


quit;
