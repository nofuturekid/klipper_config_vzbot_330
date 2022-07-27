#!/bin/bash

NEWX=$(ls -Art /tmp/resonances_x_*.csv | tail -n 1)
DATE=$(date +'%Y-%m-%d-%H%M%S')
OUTDIR=/home/pi/klipper_config/graphs

if [ ! -d "${OUTDIR}" ]
then
    mkdir "${OUTDIR}"
    chown pi:pi "${OUTDIR}"
fi

~/klipper/scripts/calibrate_shaper.py ${NEWX} -o "${OUTDIR}/resonances_x_${DATE}.png"
