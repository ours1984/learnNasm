
test:test.o
	ld -o $@ $^

test.o:nasmTest.asm
	nasm -f elf64 -g -o $@ $^

.PHONY:clean
clean:
	${RM} *.o test *.out
	clear