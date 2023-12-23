# Bootable 16-bit SUBLEQ eForth

A bootable version of [subleq eForth](https://github.com/howerj/subleq).

For more information
see:

* <https://esolangs.org/wiki/Subleq>
* <https://github.com/howerj/subleq>
* <https://en.wikipedia.org/wiki/One-instruction_set_computer>

### Building

Type `make` to build and run this version with qemu.  
Type `make keyb-FR` to build an FR keyboard mapping. Then rebuild with `make`.  
`qemu-system-i386` need to be installed.

![subleq eForthOS](https://github.com/pbrochard/subleq-eForthOS/assets/89560/3b3f17aa-25d6-4d4a-98b2-e01721b2a57b)

### Running on real hardware

To run `subleq-eForth` on a real hardware with `grub2`:

- Copy the grub configuration and make it executable:

```
sudo cp grub2-floppy.cfg /etc/grub.d/40_subleq_eForth
sudo chmod a+x /etc/grub.d/40_subleq_eForth
```

- Install `memdisk` from `syslinux`. For example on a Debian system:

```
sudo apt install syslinux
sudo cp /usr/lib/syslinux/memdisk /boot/
```

- Rebuild the grub config:

```
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

- Build the `subleq-eForth` floppy:

```
make floppy
```

- Install the floppy image in the grub `/boot` directory;

```
sudo cp subleq-boot.flp /boot/
```

- Reboot!

*Note: you may have to disable the uefi boot and fallback to legacy boot to avoid graphical problems*
