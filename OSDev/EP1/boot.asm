[org 0x7c00]

; stack set up
mov bp, 0x8000
mov sp, bp


mov bx, HELLO
call print_string
call print_newline

jmp $

;includes
%include "printing.asm"

; data
HELLO:
    db "Hello World", 0

;do not touch
times (510 - ($ - $$)) db 0
dw 0xAA55
