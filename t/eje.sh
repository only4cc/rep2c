NUM=1000

function itera {
echo $q
date
time perl -w test_querys2.pl $NUM "`cat ./cql/$q.cql`" > ./out/$q.$NUM.out
date
tail -2 ./out/$q.$NUM.out
}

q=q_horario_atencion_plataformas
itera
exit
q=q_criterio_servicio_derivacion
itera
q=q_locuciones_ivr
itera
q=q_grupo_distribucion_detalle
itera
q=q_criterio_servicio_grupo
itera
q=q_plataformas_desborde
itera
q=q_enrutamiento_x_servicio
itera
q=q_horario_atencion_plataformas
itera
q=q_nc_clientes_contador
itera
q=q_semaforo
itera
q=q_plataforma
itera
q=q_desborde_por_reintentos
itera
q=q_nc_clientes
itera
