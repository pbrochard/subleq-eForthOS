all: build run

.PHONY: build run

eforth-dec.asm: eforth.dec
	echo "dw \\" > eforth-dec.asm
	sed 's/$$/, \\/' eforth.dec >> eforth-dec.asm

embed/eforth-embed:
	cd embed; make

keyb-EN:
	echo "" > key-translation.asm

keyb-FR: embed/eforth-embed
	cat FR-mapping.fs | ./embed/eforth-embed | awk '!/.*ok/ {print $0}' | tee ./key-translation.asm

key-translation.asm:
	make keyb-EN

build: subleq-boot.asm eforth-dec.asm key-translation.asm
	nasm -f bin subleq-boot.asm -o boot.com
	dd status=noxfer conv=notrunc if=boot.com of=subleq-boot.flp

run: build
	qemu-system-i386 -drive file=subleq-boot.flp,format=raw,index=0,if=floppy,readonly=on

dbg: build
	qemu-system-i386 -drive file=subleq-boot.flp,format=raw,index=0,if=floppy,readonly=on -s -S

clean:
	rm -f boot.com subleq-boot.flp eforth-dec.asm key-translation.asm
