
export OUTDIR
${shell if [ ! -d $(OUTDIR) ]; then mkdir -p ${OUTDIR}; fi;}

export TMPDIR
${shell if [ ! -d $(TMPDIR) ]; then mkdir -p $(TMPDIR); fi;}


all:${DIR}
${DIR}:
	${MAKE} -C $@

.PHONY: ${DIR} clean
clean:
	for dir in ${DIR};do ${MAKE} -C $${dir} clean;done
