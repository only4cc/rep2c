#!/usr/bin/bash
#
# Replica desde SQL Server a Cassandra
# Solo derivacion.grabaciones_ani_dnis
# 
dir="/home/rep2c/proy/rep2c"
dir_perl="/home/rep2c/localperl/bin"
export PATH=$PATH:$dir

${dir_perl}/perl -w $dir/rep2c.pl derivacion.grabaciones_ani_dnis

date > $dir/log/last_grabaciones_ani_dnis.log


