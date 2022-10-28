#!/bin/bash
# Force script to exit if an error occurs
set -e

KLIPPER_DIR="/home/pi/klipper"
KLIPPER_VERSION=$(git -C "${KLIPPER_DIR}" describe --tags)
BOARD_CONFIG_DIR="/home/pi/printer_data/config/boards"
BOARD_CONFIG_FILES="${BOARD_CONFIG_DIR}/*.config"
OUTDIR="/home/pi/printer_data/config/firmware_binaries"

##########################################################
function create_outdir {
    if [ ! -d "${OUTDIR}" ]
    then
        mkdir "${OUTDIR}"
        chown pi:pi "${OUTDIR}"
    fi
}

function compile_firmware {
    local CONFIG_FILE="${BOARD_CONFIG_DIR}/$1.config"
    echo "Compiling firmware, using \"${CONFIG_FILE}\""
    cp -f "${CONFIG_FILE}" "${KLIPPER_DIR}/.config"
    make olddefconfig &>/dev/null
    make clean &>/dev/null
    make &>/dev/null
}

function copy_firmware {
    if [ -f "${KLIPPER_DIR}/out/klipper.bin" ]
    then
        cp "${KLIPPER_DIR}/out/klipper.bin" "${OUTDIR}/${1}_(${KLIPPER_VERSION}).bin"
        return
    elif [ -f "${KLIPPER_DIR}/out/klipper.hex" ]
    then
        cp "${KLIPPER_DIR}/out/klipper.hex" "${OUTDIR}/${1}_(${KLIPPER_VERSION}).hex"
        return
    elif [ -f "${KLIPPER_DIR}/out/klipper.elf" ]
    then
        cp "${KLIPPER_DIR}/out/klipper.elf" "${OUTDIR}/${1}_(${KLIPPER_VERSION}).elf"
        return
    else
        echo "No binaries were built, please check for problems during build process."
    fi
}
##########################################################

create_outdir

pushd "${KLIPPER_DIR}" &>/dev/null

# Run make scripts for the supported boards.
for FILE in ${BOARD_CONFIG_FILES}
do
    BOARD=${FILE##*/}
    BOARD=${BOARD%.*}
    echo "Processing board: ${BOARD}"
    compile_firmware "${BOARD}"
    copy_firmware "${BOARD}"
done

popd &>/dev/null

echo "Firmware binaries compiled successfully! You can find them in the \"${OUTDIR}\" folder!"
