print_string:
    ;parameter: bx
    
    pusha   ; push all registers to stack

    mov ah, 0x0e ;set to TTY mode

    ;while(string[i] != 0){print string[i]; i++}
    start:
        mov al, [bx]; 'bx is the address of the first position of the string'
        cmp al, 0 ;check if string[i] is equal to 0
        je done ;jump to end if they're equal

        int 0x10 ;call the interrupt to print

        add bx, 1 ;adding one byte to the address pointer
        jmp start
    
    done:
        popa    ; pop all saved values into regsiters
        ret     ; return to caller


print_newline:
    pusha

    mov ah, 0x0e ;set to TTY mode
    mov al, 0x0a ;set to newline character
    int 0x10 ;cal the interrupt to print
    mov al, 0x0d ;set to carriage return
    int 0x10

    popa
    ret


print_hex:
    ;parameter: dx
    pusha

    mov cx, 0 ;the index 

    hex_loop:
        cmp cx,4 ;loop condition
        je end ;if they're equal, jump to end

        mov ax,dx ;using ax as the register to work on
        and ax,0x000f ;use this as a mask to get the last 4 bits alone
        add al,0x30 ;adding 30 to the value to convert into into the value's ASCII code
        cmp al,0x39 ;check if the value is greater than 9, i.e A-F
        jle step2 ;if it is not, we move to step2
        add al,7 ;Adding 7 gets us to the ASCII codes for letters i.e 65-

        step2:
            mov bx,HEX_OUT + 5 ;base location + length - so that we can iterate from the end
            sub bx,cx ;subtract the index so that we can put it in the position before the previous one
            mov [bx], al ;copy the ASCII code in 'al' into the parameter for printing
            ror dx,4 ;to move the last part to dx to the first so that we can access the next one from the end

            add cx,1; ;increment the index
            jmp hex_loop

    end:
        mov bx,HEX_OUT ;put the final string in the print_string parameter
        call print_string

        popa
        ret

    HEX_OUT:
        db '0x0000',0 ;the empty string - reserved memory space

