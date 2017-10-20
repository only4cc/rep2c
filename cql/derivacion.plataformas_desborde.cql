use derivacion;

COPY derivacion.plataformas_desborde (
pdesb_dbid ,
gdist_dbid ,
plat_dbid ,
hor_dbid ,
cortar_llamada ,
plat_dbid_desb ,
loc_dbid_desb 	
)
FROM '%%filename%%'
WITH DELIMITER = '|'
 AND HEADER = FALSE
 AND SKIPROWS = 0
 AND MAXINSERTERRORS = -1
 AND MAXPARSEERRORS  = -1
 AND NULL = 'NULL';

quit;
