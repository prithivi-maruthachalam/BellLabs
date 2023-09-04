[org 0x7c00]

    ; set up stack
    mov bp, 0x9000
    mov sp, bp

    mov bx, REAL_MSG
    call print_string
    
    ; switch to 32-bit mode
    call switch_to_pm

    ; infinite loop
    jmp $

;inlcuding files
%include "printing.asm"
%include "32bit_gdt.asm"
%include "32bit_printing.asm"
%include "32bit_switch.asm"

[bits 32]
BEGIN_PM:
    mov ebx, PROTECTED_MSG
    call pm_print_string
    jmp $

; data 
REAL_MSG db "Starting bootloader in Real Mode", 0
PROTECTED_MSG db "Entered 32-bit protected mode", 0

; bootsector
times (510-($-$$)) db 0
dw 0xAA55