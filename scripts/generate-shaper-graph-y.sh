#!/bin/bash

NEWY=$(ls -Art /tmp/resonances_y_*.csv | tail -n 1)
DATE=$(date +'%Y-%m-%d-%H%M%S')
OUTDIR=/home/pi/klipper_config/graphs

if [ ! -d "${OUTDIR}" ]
then
    mkdir "${OUTDIR}"
    chown pi:pi "${OUTDIR}"
fi

~/klipper/scripts/calibrate_shaper.py ${NEWY} -o "${OUTDIR}/resonances_y_${DATE}.png"
