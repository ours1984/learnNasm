
TARGET = test

all:${TARGET}_exe

include ../../compile.mk

FLAGS += -fno-stack-protector #不需要栈溢出
FLAGS += -no-pie	#不需要位置无关exe
FLAGS += -fno-pic	#不需要位置无关code
FLAGS += -fno-builtin	# 不需要 gcc 内置函数
FLAGS += -nostdinc		# 不需要标准头文件
FLAGS += -nostdlib		# 不需要标准库
