OPTIONAL_MOUNT = \
  	if mount | grep /media/floppy > /dev/null; then \
  		echo "skipping mount" ; \
	else \
    		sudo mount -o loop image.img /media/floppy/; \
	fi;

boot:
	nasm -f bin src/boot1.asm -o dist/boot1

stage2:
	cd src/ ; nasm -f bin Stage2.asm -o ../dist/STAGE2.SYS
	@$(OPTIONAL_MOUNT)
	sudo cp dist/STAGE2.SYS /media/floppy/	
	sudo umount /media/floppy

bootsector:
	dd if=dist/boot1 of=image.img conv=notrunc
	

