OPTIONAL_MOUNT = \
  	if mount | grep /media/floppy > /dev/null; then \
  		echo "skipping mount" ; \
	else \
    		sudo mount -o loop image.img /media/floppy/; \
	fi;

boot: bootsector
	nasm -f bin src/SysBoot/Stage1/Boot1.asm -o /tmp/boot1

stage2:
	cd src/SysBoot/Stage2; nasm -f bin Stage2.asm -o ../../../dist/KRNLDR.SYS
	@$(OPTIONAL_MOUNT)
	sudo cp dist/KRNLDR.SYS /media/floppy/
	sudo umount /media/floppy

bootsector:
	dd if=/tmp/boot1 of=image.img conv=notrunc
