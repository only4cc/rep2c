use derivacion;

COPY derivacion.enrutamiento_x_servicio (
	id_servicio,
	enrutamiento,
	id_status
)
FROM '/home/rep2c/proy/rep2c/tmp/derivacion.enrutamiento_x_servicio.csv'
WITH DELIMITER = '|'
 AND HEADER = FALSE
 AND MAXINSERTERRORS = -1
 AND MAXPARSEERRORS  = -1
 AND NULL = 'NULL';
