use derivacion;

COPY derivacion.criterio_servicio_grupo (
    sdis_dbid,
    gdist_dbid,
    cder_dbid,
    tenant_dbid
)
FROM '%%filename%%'
WITH DELIMITER = '|'
 AND HEADER = FALSE
 AND SKIPROWS = 0
 AND MAXINSERTERRORS = -1
 AND MAXPARSEERRORS  = -1
 AND NULL = 'NULL';

quit;
