;MBR
    org 0x7c00

    mov ax, cs
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov ss, ax
    mov sp, 0x7c00

;clean screen by using funtion 0x06
    ;ah = 06
    ;al = 00 (clean all)
    mov ax, 0x0600
    mov bx, 0x0700
    mov cx, 0x0000  ;(0, 0)
    mov dx, 0x184f  ;(80, 25) 0x18=24 0x4f=79
    int 0x10

;get cursor position
    mov ah, 0x03    ;funtion code
    mov bh, 0x00    ;page that will get

    int 0x10    ; ch = cursor starting line, cl = cursor ending line
                ; dh = The line number where the cursor is located
                ; dl = The column number where the cursor is located

;print string
    mov ax, message
    mov bp, ax
    mov cx, 5       ;length of the string
    mov ax, 0x1301  ;ah=13 printing string, al=01 the cursor follow the movement
    mov bx, 0x02    ;bh=0 the first page, bl=02 black background with green character
    int 0x10

    jmp $   ;pause the program

    message db "Hello"
    time    510-($-$$) db 0 ;fill the whole 512 block with 0
    
    dw 0xaa55
