#!/usr/bin/bash
#
# Replica desde SQL Server a Cassandra
# Se inhibe replica de derivacion.nc_clientes
# 
dir="/home/rep2c/proy/rep2c"
dir_perl="/home/rep2c/localperl/bin"
export PATH=$PATH:$dir

${dir_perl}/perl -w $dir/rep2c.pl derivacion.criterio_servicio_derivacion
${dir_perl}/perl -w $dir/rep2c.pl derivacion.criterio_servicio_grupo
${dir_perl}/perl -w $dir/rep2c.pl derivacion.desborde_por_reintentos
${dir_perl}/perl -w $dir/rep2c.pl derivacion.enrutamiento_x_servicio
${dir_perl}/perl -w $dir/rep2c.pl derivacion.grupo_distribucion_detalle
${dir_perl}/perl -w $dir/rep2c.pl derivacion.horario_atencion_plataformas
${dir_perl}/perl -w $dir/rep2c.pl derivacion.locuciones_ivr
${dir_perl}/perl -w $dir/rep2c.pl derivacion.plataforma
${dir_perl}/perl -w $dir/rep2c.pl derivacion.plataformas_desborde
${dir_perl}/perl -w $dir/rep2c.pl derivacion.semaforo

date > $dir/log/last_chicas.log

#perl -w rep2c.pl derivacion.nc_clientes
