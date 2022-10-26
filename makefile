
PWD := ${shell pwd}
DIR = boot caller class

OUTDIR := ${PWD}/output
export OUTDIR
${shell if [ ! -d $(OUTDIR) ]; then mkdir -p ${OUTDIR}; fi;}

TMPDIR := ${PWD}/build
export TMPDIR
${shell if [ ! -d $(TMPDIR) ]; then mkdir -p $(TMPDIR); fi;}


all:${DIR}

.PHONY: ${DIR}
${DIR}:
	${MAKE} -C $@

bochsfp:boot ddfp
	bochs -q -f output/bochsfp

bochshd:boot ddhd
	bochs -q -f output/bochshd

ddfp:${TMPDIR}/setupfp.ao ${TMPDIR}/boot.ao
	dd if=${TMPDIR}/boot.ao of=$(OUTDIR)/fp.img bs=512 skip=0 seek=0 count=1 conv=notrunc
	dd if=${TMPDIR}/setupfp.ao of=$(OUTDIR)/fp.img bs=512 skip=0 seek=1 count=1 conv=notrunc

ddhd:${TMPDIR}/setuphd.ao ${TMPDIR}/boot.ao
	dd if=${TMPDIR}/boot.ao of=$(OUTDIR)/hd.img bs=512 skip=0 seek=0 count=1 conv=notrunc
	dd if=${TMPDIR}/setuphd.ao of=$(OUTDIR)/hd.img bs=512 skip=0 seek=1 count=1 conv=notrunc

.PHONY:img
img:
	bximage -q -hd=16 -func=create -sectsize=512 -imgmode=flat $(OUTDIR)/hd.img
	bximage -q -fd=1.44M  -func=create -sectsize=512 -imgmode=flat $(OUTDIR)/fp.img

include mf.mk
