print_newline:
    pusha

    mov ah, 0x0e
    mov al, 0x0a

    int 0x10
    
    mov al, 0x0d
    int 0x10

    popa
    ret

print_string:
    pusha
    mov ah, 0x0e
    start:
        mov al,[bx]
        cmp al, 0
        je done

        int 0x10

        add bx, 1
        jmp start
    done:
        popa
        ret
