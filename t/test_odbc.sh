# Produccion
# /home/rep2c/sqlncli-11.0.1790.0/bin/sqlcmd -S 172.18.66.51 -U sa -P econtact2010 -s "|" -W -h-1 -i /home/rep2c/proy/rep2c/sql/derivacion.locuciones.sql | egrep -v "Changed" | head -5

# QA y Desarrollo
#/home/rep2c/sqlncli-11.0.1790.0/bin/sqlcmd -S 192.168.160.224  -U sa -P Aa123456 -s "|" -W -h-1 -i /home/rep2c/proy/rep2c/sql/derivacion.locuciones.sql 
/home/rep2c/sqlncli-11.0.1790.0/bin/sqlcmd -S 192.168.160.224  -U rep2c -P rep2c -s "|" -W -h-1 -i /home/rep2c/proy/rep2c/sql/derivacion.locuciones.sql 
