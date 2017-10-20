use derivacion;

COPY grupo_distribucion_detalle (
    gdist_dbid,
    plat_dbid,
    tenant_dbid,
    flag_reportes,
    flag_reportes_desborde ,
    porcentaje,
    n_llamadas,
    id_status 	
)
FROM '/home/rep2c/proy/rep2c/tmp/derivacion.grupo_distribucion_detalle.csv'
WITH DELIMITER = '|'
 AND HEADER = FALSE
 AND SKIPROWS = 3
 AND MAXINSERTERRORS = -1
 AND MAXPARSEERRORS  = -1
 AND NULL = 'NULL';
