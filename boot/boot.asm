;[ORG  0x7c00]
section maintext vstart=0x7c00
BOOT_MAIN_ADDR equ 0x7E00
;extern print
[BITS 16]
global boot_start
boot_start:
    ; 设置屏幕模式为文本模式，清除屏幕
    mov ax, 3
    int 0x10

    mov     si, strHello
    call    print

    mov     si, strSelect
    call    print

    mov ah,0x10
    int 0x16
    cmp al,'0'

jz .readf
    call readDisk
    mov si, selhd
    jmp .end
    
.readf
    call readFlopy
    mov si, selfp

.end
    call    print
    jmp     BOOT_MAIN_ADDR

; 如何调用
; call    readFlopy     ; 2 调用
readDisk:
    pusha
    mov ecx, 2  ; 从硬盘哪个扇区开始读
    mov bl, 1   ; 读取的扇区数量

    ; 0x1f2 8bit 指定读取或写入的扇区数
    mov dx, 0x1f2
    mov al, bl
    out dx, al

    ; 0x1f3 8bit iba地址的第八位 0-7
    inc dx
    mov al, cl
    out dx, al

    ; 0x1f4 8bit iba地址的中八位 8-15
    inc dx
    mov al, ch      ; 取中8位
    out dx, al

    ; 0x1f5 8bit iba地址的高八位 16-23
    inc dx
    shr ecx, 16
    mov al, cl
    out dx, al

    ; 0x1f6 8bit
    ; 0-3 位iba地址的24-27
    ; 4 0表示主盘 1表示从盘
    ; 5、7位固定为1
    ; 6 0表示CHS模式，1表示LAB模式
    inc dx
    mov al, ch
    and al, 0b11101111
    out dx, al

    ; 0x1f7 8bit  命令或状态端口
    inc dx
    mov al, 0x20
    out dx, al

    ; 验证状态
    ; 3 0表示硬盘未准备好与主机交换数据 1表示准备好了
    ; 7 0表示硬盘不忙 1表示硬盘忙
    ; 0 0表示前一条指令正常执行 1表示执行出错 出错信息通过0x1f1端口获得
.read_check:
    mov dx, 0x1f7
    in al, dx
    and al, 0b10001000  ; 取硬盘状态的第3、7位
    cmp al, 0b00001000  ; 硬盘数据准备好了且不忙了
    jnz .read_check

    ; 读数据
    mov dx, 0x1f0
    mov cx, 256
    mov edi, BOOT_MAIN_ADDR
.read_data:
    in ax, dx
    mov [edi], ax
    add edi, 2
    loop .read_data

    popa
    ret

; 如何调用
; call    readFlopy     ; 2 调用
readFlopy:
    pusha
    mov     dh, 0   ; 0 磁头
    mov     dl, 0   ; 驱动器编号

    mov     ch, 0   ; 0 柱面
    mov     cl, 2   ; 2 扇区

    mov     bx, BOOT_MAIN_ADDR  ; 数据往哪读

    mov     ah, 0x02    ; 读盘操作
    mov     al, 1       ; 连续读几个扇区

    int     0x13

    cmp ah,0
    jz .doneDisl
    mov     si, error_msg
    call    print
    jmp $

.doneDisl:
    popa
    ret

; 如何调用
; mov     si, msg   ; 1 传入字符串
; call    print     ; 2 调用
print:
    pusha
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
    popa
    ret

error_msg db "read error!", 10, 13, 0

strHello db "Hello,Boot!", 10, 13, 0

strSelect db "floppy:0", 10, 13, "hard:1",10, 13,0

selfp db "selct floppy!", 10, 13,0

selhd db "selct hard disk!", 10, 13,0

times 510 - ($ - $$) db 0
db 0x55, 0xaa