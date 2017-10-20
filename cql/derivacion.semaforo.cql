use derivacion;

COPY derivacion.semaforo (nombre_proceso,en_proceso)
FROM '%%filename%%'
WITH DELIMITER = '|'
 AND HEADER = FALSE
 AND SKIPROWS = 0
 AND MAXINSERTERRORS = -1
 AND MAXPARSEERRORS  = -1
 AND NULL = 'NULL';



quit;
