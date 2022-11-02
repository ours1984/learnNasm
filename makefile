
PWD := ${shell pwd}
DIR = kernel/boot kernel/init call/caller call/class call/test

OUTDIR := ${PWD}/output
export OUTDIR
${shell if [ ! -d $(OUTDIR) ]; then mkdir -p ${OUTDIR}; fi;}

TMPDIR := ${PWD}/build
export TMPDIR
${shell if [ ! -d $(TMPDIR) ]; then mkdir -p $(TMPDIR); fi;}


all:${DIR}
.PHONY: ${DIR} clean
${DIR}:
	${MAKE} -C $@
clean:
	for dir in ${DIR};do ${MAKE} -C $${dir} clean;done

bochs:kernel/boot system ddhd
	bochs -q -f output/bochs

system:kernel/init
	objcopy -O binary ${OUTDIR}/init ${TMPDIR}/system.bin 

ddhd:${TMPDIR}/setup.ao ${TMPDIR}/boot.ao
	dd if=${TMPDIR}/boot.ao of=$(OUTDIR)/hd.img bs=512 skip=0 seek=0 count=1 conv=notrunc
	dd if=${TMPDIR}/setup.ao of=$(OUTDIR)/hd.img bs=512 skip=0 seek=1 count=1 conv=notrunc
	dd if=${TMPDIR}/system.bin of=$(OUTDIR)/hd.img bs=512 seek=3 count=60 conv=notrunc

.PHONY:img
img:
	bximage -q -hd=16 -func=create -sectsize=512 -imgmode=flat $(OUTDIR)/hd.img
#	bximage -q -fd=1.44M -func=create -sectsize=512 -imgmode=flat $(OUTDIR)/fp.img
