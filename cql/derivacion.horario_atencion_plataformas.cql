use derivacion;

COPY derivacion.horario_atencion_plataformas (
    hor_dbid,
    plat_dbid,
    dia_semana,
    hora_inicio,
    hora_fin,
    id_status
)
FROM '/home/rep2c/proy/rep2c/tmp/derivacion.horario_atencion_plataformas.csv'
WITH DELIMITER = '|'
 AND HEADER = FALSE
 AND SKIPROWS = 0
 AND MAXINSERTERRORS = -1
 AND MAXPARSEERRORS  = -1
 AND NULL = 'NULL';
