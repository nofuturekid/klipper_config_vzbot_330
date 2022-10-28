#!/bin/bash

DATE=$(date +'%Y-%m-%d-%H%M%S')
OUTDIR=/home/pi/printer_data/config/graphs

if [ ! -d "${OUTDIR}" ]
then
    mkdir "${OUTDIR}"
    chown pi:pi "${OUTDIR}"
fi

~/klipper/scripts/graphstats.py ~/klipper_logs/klippy.log -m mainboard0 -s -o "${OUTDIR}/system_load_${DATE}.png"

~/klipper/scripts/graphstats.py ~/klipper_logs/klippy.log -m mainboard0 -o "${OUTDIR}/mainboard0_${DATE}.png"
~/klipper/scripts/graphstats.py ~/klipper_logs/klippy.log -m mainboard0 -f -o "${OUTDIR}/mainboard0_freq_${DATE}.png"

~/klipper/scripts/graphstats.py ~/klipper_logs/klippy.log -m toolboard0 -o "${OUTDIR}/toolboard0_${DATE}.png"
~/klipper/scripts/graphstats.py ~/klipper_logs/klippy.log -m toolboard0 -f -o "${OUTDIR}/toolboard0_freq_${DATE}.png"
