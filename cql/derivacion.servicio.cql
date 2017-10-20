use derivacion;

COPY derivacion.servicio (srv_nombre, tenant_dbid, srv_descripcion )
FROM '%%filename%%'
WITH DELIMITER = '|'
 AND HEADER = FALSE
 AND SKIPROWS = 0;

quit;
