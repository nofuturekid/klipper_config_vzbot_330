# HowTo Flash Stuff

## General Commands Before Flashing

### Check for available CAN devices
Only not initialized ones will be shown
```shell
python3 /home/pi/klipper/lib/canboot/flash_can.py -q
```

## Toolboards
### Flash Bootloader over DFU (USB)
```shell
sudo dfu-util -a 0 -d 0483:df11 --dfuse-address 0x08000000 -D ~/CanBoot/out/canboot.bin
```

### Flash Klipper over DFU (USB) (8KiB Bootloader CANBus Bootloader)
```shell
sudo dfu-util -a 0 -d 0483:df11 --dfuse-address 0x08002000 -D out/klipper.bin
```

################################################################################
# VzBot
################################################################################
### Flash BTT-EBB
```shell
python3 /home/pi/klipper/lib/canboot/flash_can.py -i can0 -u d4515d96685b -f "BTT-EBB_v1.1_(CAN)_(v0.10.0-531-g3796a319).bin"
```
### Flash MellowFly8
```shell
./scripts/flash_usb.py -t stm32f407xx -s 0x8008000 -d /dev/ttyACM0 "/home/pi/klipper_config/firmware_binaries/Mellow-Fly_Super_8_(v0.10.0-591-ga2482d4f).bin"
```
