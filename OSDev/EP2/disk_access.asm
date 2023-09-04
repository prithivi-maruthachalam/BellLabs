;data is loaded to es:bx
;bx will have to be set to the position of the kernel offset in the calling function

disk_load:
    ;parameter: dh - number of sectors(512 bytes) to read starting from the second sector
    ;paraneter: bx - data will be loaded into es:bx
    ;parameter: dl - the drive to read from

    pusha ;push all existing registers to the stack to preserve them
    push dx ;input parameter - save to stack for later use

    mov ah,0x02 ;read instruction
    mov al,dh ;number of sectors to be read
    mov cl,0x02 ;the sector to be read first - 0x01 is the boot sector
    mov ch, 0x00 ;the cylinder number
    mov dh, 0x00 ;repurposing dh to be used as the head number
    ; dl will have been set by the caller to the drive number

    int 0x13 ;the iterrupt to read from disk
    jc disk_error

    pop dx ;clear the old dx values from the stack back into the register
    cmp al,dh; dh stores the number of sectors that were actually read
    jne sectors_error
    popa
    ret

    sectors_error:
        mov bx,SECTORS_ERROR_STRING
        call print_string
        call print_newline
        mov dh,ah ;ah contains the error code
        call print_hex
        jmp disk_error_loop ;put in an infinite loop on error

    disk_error:
        mov bx, DISK_ERROR_STRING
        call print_string


disk_error_loop:
    jmp $


;data
DISK_ERROR_STRING:
    db "Disk read error",0
SECTORS_ERROR_STRING:
    db "Incorrent number of sectors were read",0