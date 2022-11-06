
#cpp 编译链接选项
FLAGS := -Wall
#asm 调试选项
ADFLG =

ifdef pg
	FLAGS += -pg
endif

ifdef cv
	FLAGS += -fprofile-arcs -ftest-coverage
endif

ifdef debug
	FLAGS +=  -g
	ADFLG = -g
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

FLAGS:=$(strip ${FLAGS})

ifdef m32
	OBJ += ${OBJA32} 
	FLAGS += -m32
endif
ifdef m64
	OBJ += ${OBJA64} 
endif

OBJP = ${patsubst %.cpp,$(TMPDIR)/%.po,${wildcard *.cpp}}
OBJC = ${patsubst %.c,$(TMPDIR)/%.co,${wildcard *.c}}
OBJA = ${patsubst %.asm,$(TMPDIR)/%.ao,${wildcard *.asm}}
OBJA32 = ${patsubst %.asm32,$(TMPDIR)/%.a32,${wildcard *.asm32}}
OBJA64 = ${patsubst %.asm64,$(TMPDIR)/%.a64,${wildcard *.asm64}}
OBJ += ${OBJC} ${OBJP} ${OBJA}


${TARGET}_emp:${OBJ}

${TARGET}_exe:${OBJ}
	${CXX} ${FLAGS} ${LDPATH} $^ ${LDFLAGS} -o ${OUTDIR}/${TARGET}

${TARGET}_static:${OBJ}
	${AR} rsc ${OUTDIR}/lib${TARGET}.a $^

${TARGET}_dynamic:${OBJ}
	${RM} ${OUTDIR}/lib${TARGET}.so 
	${CXX} ${FLAGS}  ${LDPATH} -fpic -shared  $^ ${LDFLAGS}  -o ${OUTDIR}/lib${TARGET}.so

$(TMPDIR)/%.po:%.cpp
	${CXX} -c ${FLAGS} ${INCPATH} $^ -o $@

$(TMPDIR)/%.co:%.c
	${CC} -c ${FLAGS} ${INCPATH} $^ -o $@

$(TMPDIR)/%.ao:%.asm
	nasm ${ADFLG} $< -o $@

$(TMPDIR)/%.a32:%.asm32
	nasm -f elf32 ${ADFLG} $< -o $@

$(TMPDIR)/%.a64:%.asm64
	nasm -f elf64 ${ADFLG} $< -o $@

.PHONY:show clean

clean:
	${RM} ${TMPDIR}/* ${OUTDIR}/${TARGET}
	clear

show:
	@echo TARGET:${TARGET}
	@echo LDPATH:${LDPATH}
	@echo INCPATH:${INCPATH}
	@echo OUTDIR:${OUTDIR}
	@echo TMPDIR:${TMPDIR}