#!/bin/bash

DATE=$(date +'%Y-%m-%d-%H%M%S')
OUTDIR=/home/pi/klipper_config/graphs

if [ ! -d "${OUTDIR}" ]
then
    mkdir "${OUTDIR}"
    chown pi:pi "${OUTDIR}"
fi

function graph_x {
  NEWX=$(ls -Art /tmp/resonances_x_*.csv | tail -n 1)
  ~/klipper/scripts/calibrate_shaper.py ${NEWX} -o "${OUTDIR}/resonances_x_${DATE}.png"
}

function graph_y {
  NEWY=$(ls -Art /tmp/resonances_y_*.csv | tail -n 1)
  ~/klipper/scripts/calibrate_shaper.py ${NEWY} -o "${OUTDIR}/resonances_y_${DATE}.png"
}

opt=${1}
shopt -s nocasematch
case $opt in
    "x")
        graph_x
        ;;
    "y")
        graph_y
        ;;
    *)
        graph_x
        graph_y
        ;;
esac
shopt -u nocasematch
