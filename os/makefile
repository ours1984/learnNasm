
HOME := ${shell pwd}
export HOME

DIR = boot kernel
OUTDIR := ${HOME}/../build
TMPDIR := ${HOME}/../build/tmp
include ../config.mk

qemug:build
	qemu-system-i386 -m 32M -hda ../build/hd.img -S -s

qemug64:build
	qemu-system-x86_64 -m 320M -hda ../build/hd.img -S -s

bochs:build
	rm -f $(OUTDIR)/*.lock
	bochs -q -f bochs

build:all
	rm -rf $(OUTDIR)/hd.img
	bximage -q -hd=16 -func=create -sectsize=512 -imgmode=flat $(OUTDIR)/hd.img
	dd if=${TMPDIR}/boot.ao of=$(OUTDIR)/hd.img bs=512 skip=0 seek=0 count=1 conv=notrunc
	dd if=${TMPDIR}/setup.ao of=$(OUTDIR)/hd.img bs=512 skip=0 seek=1 count=2 conv=notrunc
	dd if=${OUTDIR}/kernel.bin of=$(OUTDIR)/hd.img bs=512 seek=3 count=60 conv=notrunc

.PHONY: cleanall
cleanall:
	rm -rf ../build