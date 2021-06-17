# mjsxj02hl_uboot
Custom bootloader for Xiaomi Smart Camera Standard Edition (MJSXJ02HL)

## Preparation

Extract the contents of the u-boot source code archive (`osdrv/opensource/uboot/u-boot-2016.11.tgz`) from the [Hi3518EV300 SDK](https://dl.openipc.org/SDK/HiSilicon/Hi3516Ev200_16Ev300_18Ev300/Hi3516EV200R001C01SPC011/Hi3516EV200R001C01SPC011.rar) to the root directory of the repository. The default name of the unpacked folder is `u-boot-2016.11`.

To use the device's firmware features, you need to install [Ch341Prog](https://github.com/setarcos/ch341prog).

## Usage

### Build u-boot:
```bash
make UBOOT_SRC=u-boot-2016.11 UBOOT_BIN=u-boot-mjsxj02hl.bin all
```

or (defaults u-boot source directory `u-boot-2016.11` and output file `u-boot-mjsxj02hl.bin`):

```bash
make all
```

### Flash firmware:
Read the current firmware, replace u-boot, and write the output file to the device.

```bash
make UBOOT_BIN=u-boot-mjsxj02hl.bin FIRMWARE=firmware-mjsxj02hl.bin flash_firmware
```

or (defaults u-boot binary file `u-boot-mjsxj02hl.bin` and output firmware file `firmware-mjsxj02hl.bin`):

```bash
make flash_firmware
```
