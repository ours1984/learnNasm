[ORG  0x7c00]

section maintext
;extern print
;[BITS 16]
global boot_start
boot_start:
    ;push strLen
    ;push strHello
    ;call print
    
    mov ah,0x13
    mov al,1
    mov bl,0x0f
    mov bh,0
    mov cx,strLen
    mov dx,0x0508
    ;mov es,bh
    mov bp,strHello
    int 0x10

    ;mov ebx,0
    ;mov eax,1
    ;int 0x80
    jmp $

strHello db "Hello,world!",0AH
strLen equ $-strHello

times 510 - ($ - $$) db 0
db 0x55, 0xaa