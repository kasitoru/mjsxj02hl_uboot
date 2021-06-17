UBOOT_SRC := u-boot-2016.11
UBOOT_CFG := mjsxj02hl_defconfig
UBOOT_REG := reg_info.bin
UBOOT_BIN := u-boot-mjsxj02hl.bin
FIRMWARE := firmware-mjsxj02hl.bin

all: clean config compile reg_info gzip build

build:
	make ARCH=arm CROSS_COMPILE=arm-himix100-linux- u-boot-z.bin -C $(UBOOT_SRC)
	cp -f $(UBOOT_SRC)/u-boot-hi3518ev300.bin $(UBOOT_BIN)
	truncate -s 256K $(UBOOT_BIN)

gzip:
	cp -f gzip $(UBOOT_SRC)/arch/arm/cpu/armv7/hi3518ev300/hw_compressed/
	chmod 755 $(UBOOT_SRC)/arch/arm/cpu/armv7/hi3518ev300/hw_compressed/gzip

reg_info:
	cp -f $(UBOOT_REG) $(UBOOT_SRC)/.reg

compile:
	make ARCH=arm CROSS_COMPILE=arm-himix100-linux- -C $(UBOOT_SRC)

config:
	cp -f $(UBOOT_CFG) $(UBOOT_SRC)/.config
	make menuconfig -C $(UBOOT_SRC)

clean:
	make distclean -C $(UBOOT_SRC)
	rm -f $(UBOOT_BIN) $(FIRMWARE)

patch_firmware:
	dd conv=notrunc if=$(UBOOT_BIN) of=$(FIRMWARE)

erase_firmware:
	ch341prog -v -e

read_firmware:
	ch341prog -v -r $(FIRMWARE)

write_firmware:
	ch341prog -v -w $(FIRMWARE)
	
flash_firmware: read_firmware patch_firmware erase_firmware write_firmware

