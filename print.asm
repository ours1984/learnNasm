section .text
    mov eax,0x19
    jmp $

section printdata
file2var db 3

section printtext
global print

print:
    mov edx,[esp+8]
    mov ecx,[esp+4]

    mov ebx,1
    mov eax,4
    int 0x80
    ret