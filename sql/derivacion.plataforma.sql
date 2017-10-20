use derivacion
go

set nocount on
go

select 
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
 from plataforma
go

