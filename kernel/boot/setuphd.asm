;[ORG  0x7c00]
section maintext vstart=0x7E00
BOOT_MAIN_ADDR equ 0x7E00
;extern print
[BITS 16]
global setup_start
setup_start:
    mov     ax, 0
    mov     ss, ax
    mov     ds, ax
    mov     es, ax
    mov     fs, ax
    mov     gs, ax
    mov     si, ax

    mov     si, strHello
    call    print

    jmp     $

; 如何调用
; mov     si, msg   ; 1 传入字符串
; call    print     ; 2 调用
print:
    push bx
    mov ah, 0x0e
    mov bh, 0
    mov bl, 0b01000011 ;红色/青色
.loop:
    mov al, [si]
    cmp al, 0
    jz .done
    int 0x10
    inc si
    jmp .loop
.done:
    pop bx
    ret

strHello db "Hello,Setup hard!", 10, 13, 0
times 510 - ($ - $$) db 0
db 0x55, 0xaa