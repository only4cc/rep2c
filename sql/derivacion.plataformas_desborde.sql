use derivacion
go

set nocount on
go

select 
    pdesb_dbid ,
    gdist_dbid ,
    plat_dbid ,
    hor_dbid ,
    cortar_llamada ,
    plat_dbid_desb ,
    loc_dbid_desb
 from plataformas_desborde
go

