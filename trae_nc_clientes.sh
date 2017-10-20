#!/usr/bin/bash
#
# Replica desde SQL Server a Cassandra
# Solo derivacion.nc_clientes
# 
dir="/home/rep2c/proy/rep2c"
dir_perl="/home/rep2c/localperl/bin"
export PATH=$PATH:$dir

${dir_perl}/perl -w $dir/rep2c.pl derivacion.nc_clientes
#${dir_perl}/perl -w $dir/nc_clientes.pl

date > $dir/log/last_nc_clientes.log


