#cpp 编译链接选项
FLAGS := -Wall
#asm 链接选项
ALFLG =
#asm 编译选项
ACFLG =
#asm 调试选项
ADFLG =

ifdef m32
	FLAGS += -m32
	ACFLG = elf32
	ALFLG = elf_i386
else
	ACFLG = elf64
	ALFLG = elf_x86_64
endif

ifdef pg
	FLAGS +=  -pg
endif

ifdef cv
	FLAGS +=  -fprofile-arcs -ftest-coverage
endif

ifdef debug
	FLAGS +=  -g -O0
	ADFLG = -g
else
	FLAGS += -O2
endif

ifndef LDFLAGS
	LDFLAGS = 
endif
ifndef INCPATH
	INCPATH = 
endif
ifndef LDPATH
	LDPATH = 
endif
ifndef OUTDIR
OUTDIR = .
endif
ifndef TMPDIR
	TMPDIR = .
endif

OBJP = ${patsubst %.cpp,$(TMPDIR)/%.po,${wildcard *.cpp}}
OBJC = ${patsubst %.c,$(TMPDIR)/%.co,${wildcard *.c}}
OBJA = ${patsubst %.asm,$(TMPDIR)/%.ao,${wildcard *.asm}}
OBJ = ${OBJC} ${OBJP}

${TARGET}_asm:${OBJA}
	${RM} ${OUTDIR}/${TARGET}
	ld -m ${ALFLG} $^ -o ${OUTDIR}/${TARGET}

${TARGET}_exe:${OBJ}
	${RM} ${OUTDIR}/${TARGET}
	${CXX} ${FLAGS} ${LDPATH} $^ ${LDFLAGS} -o ${OUTDIR}/${TARGET}

${TARGET}_static:${OBJ}
	${RM} ${OUTDIR}/lib${TARGET}.a
	${AR} rsc ${OUTDIR}/lib${TARGET}.a $^

${TARGET}_dynamic:${OBJ}
	${RM} ${OUTDIR}/lib${TARGET}.so 
	${CXX} ${FLAGS}  ${LDPATH} -fpic -shared  $^ ${LDFLAGS}  -o ${OUTDIR}/lib${TARGET}.so

$(TMPDIR)/%.po:%.cpp
	${CC} -c ${FLAGS} ${INCPATH} $^ -o $@

$(TMPDIR)/%.co:%.c
	${CC} -c ${FLAGS} ${INCPATH} $^ -o $@

$(TMPDIR)/%.ao:%.asm
	nasm -f ${ACFLG} ${ADFLG} $< -o $@

.PHONY:clean show

clean:
	@${RM} ${OBJ} ${OBJA} ${OUTDIR}/${TARGET} ${OUTDIR}/lib${TARGET}.* *.o *.out
	clear

show:
	@echo TARGET:${TARGET}_exe
	@echo LDPATH:${LDPATH}
	@echo INCPATH:${INCPATH}
	@echo OUTDIR:${OUTDIR}
	@echo TMPDIR:${TMPDIR}