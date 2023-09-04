gdt_start:
    ;needs 8 null bytes to start
    dd 0x0 ;4 bytes
    dd 0x0 ;4 bytes


;descriptor for code segement
gdt_code:
    ;base has to be 0x0
    ;limit is 0xfffff
    ;1st flags - present:1, privilege:00, descriptor type: 1 > 1001
    ;type flags - code:1, conforming:0, readable:1, accessed:0 > 1010
    ;2nd flags: granularity:1,32-bit default:1,64-bit seg:0,AVL,0 > 1100

    dw 0xffff    ;segment length mltiplier-ish - limit - (bits 0-15)
    dw 0x0       ;Base address (bits 0-15)
    db 0x0       ;Base address (bits 16-23)
    db 10011010b ;1st flags, type flags
    db 11001111b ;2nd flags, limit - (bits 16-19)
    db 0x0       ;Base address (bits 24-31) 

gdt_data:
    ;basically everything except type flags are the same, because we are creating overlapping segments
    ;type flags - code:0, expand down:0, writable: 1, accessed:0 >0010
    dw 0xffff
    dw 0x0
    db 0x0
    db 10010010b ;1st flags, type flags
    db 11001111b
    db 0x0

gdt_end:
    ;only to calculate the size of the GDT

gdt_descriptor:
    dw gdt_end - gdt_start - 1 ;indexing, logic and shit right? - basically size of the descriptor
    dd gdt_start ;address of the descriptor (32-bit)

;points to the code and data segments
CODE_SEGMENT equ gdt_code - gdt_start
DATA_SEGMENT equ gdt_data - gdt_start
