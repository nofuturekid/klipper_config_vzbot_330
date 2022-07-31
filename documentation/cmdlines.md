# HowTo Flash Stuff

## General Commands for Flashing

### Check available CAN devices
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

### Flash Klipper over CAN
```shell
python3 /home/pi/klipper/lib/canboot/flash_can.py -i can0 -f "BTT-EBB_v1.1_(CAN)_(v0.10.0-531-g3796a319).bin" -u d4515d96685b
```

## Mainboards
```shell
~/klipper/lib/hidflash/hid-flash "Mellow-Fly_Super_8_(v0.10.0-546-ga709ba43).bin"
```
```shell
make flash FLASH_DEVICE=/dev/ttyACM0
```
