use derivacion;

COPY derivacion.plataforma (
   plat_dbid ,
   cc_nombre ,
   srv_nombre ,
   tenant_dbid ,
   descripcion ,
   numero_transferencia ,
   grupo_transferencia ,
   tipo_transferencia ,
   ruteo_x_zona ,
   loc_dbid_transferencia ,
   loc_dbid_aviso_grabacion ,
   loc_dbid_fuera_horario ,
   id_status ,
   max_llamadas ,
   cont_llamadas 
)
FROM '%%filename%%'
WITH DELIMITER = '|'
 AND HEADER = FALSE
 AND SKIPROWS = 0
 AND MAXINSERTERRORS = -1
 AND MAXPARSEERRORS  = -1
 AND NULL = 'NULL';

quit;
