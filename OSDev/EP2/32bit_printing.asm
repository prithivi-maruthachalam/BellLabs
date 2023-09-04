[bits 32] ;instruct assembler to use 32-bit mode

VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f ;color byte

pm_print_string:
    pusha
    mov edx,VIDEO_MEMORY

    pm_print_string_loop:
        mov al, [ebx] ;char at ebx
        mov ah, WHITE_ON_BLACK ;color attributes in ah

        cmp al, 0
        je pm_print_done

        mov [edx], ax ;put into edx, the values in edx

        add ebx, 1
        add edx, 2

        jmp pm_print_string_loop

    pm_print_done:
        popa
        ret

