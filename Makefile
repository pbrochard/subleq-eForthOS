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
	cat mapping.fs  mapping-FR.fs | ./embed/eforth-embed | awk '!/.*ok/ {print $0}' | tee ./key-translation.asm

key-translation.asm:
	make keyb-EN

build: subleq-boot.asm eforth-dec.asm key-translation.asm
	rm -f subleq-boot.flp
	nasm -f bin subleq-boot.asm -o boot.com
	dd status=noxfer conv=notrunc if=boot.com of=subleq-boot.flp

run: build
	qemu-system-i386 -drive file=subleq-boot.flp,format=raw,index=0,if=floppy,readonly=on

dbg: build
	qemu-system-i386 -drive file=subleq-boot.flp,format=raw,index=0,if=floppy,readonly=on -s -S

floppy: build
	truncate -s 320k subleq-boot.flp
	@echo "===> subleq-boot.flp floppy size is: c=40 h=2 s=8"

clean:
	rm -f boot.com subleq-boot.flp eforth-dec.asm key-translation.asm
	cd embed; make clean
