#!/usr/bin/bash
# Envio de avisos por errores en proceso de replicacion
# avisa.sh
# Envia correo
#
# Parametros:
#   Asunto
#   Nombre del Archivo con el texto del mail
#

HNAME=`hostname -f`
TS=`date`

#DESTINATARIOS="t@gmail.com,edg@e-contact.cl"
DESTINATARIOS="jt@gmail.com"

SUBJECT=$1
FILEBODY=$2

SUBJECT=$TS" | "$HNAME" | "$SUBJECT
echo ===========================================================
echo avisando ....
echo enviando mail a $DESTINATARIOS ... 
echo Subj: $SUBJECT
echo Text: $FILEBODY
echo ===========================================================

if [ -s "$FILEBODY" ]; then
    mail -s "${SUBJECT}" "$DESTINATARIOS" < $FILEBODY
else
    mail -s "${SUBJECT}" "$DESTINATARIOS" < /dev/null
fi

