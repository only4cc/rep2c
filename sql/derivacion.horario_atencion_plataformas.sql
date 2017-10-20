use derivacion
go

set nocount on
go

select 
  hor_dbid,
  plat_dbid,
  dia_semana,
  hora_inicio,
  hora_fin,
  id_status 
 from horario_atencion_plataformas
go

