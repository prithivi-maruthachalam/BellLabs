[bits 16] ;16-bit instructions to switch to 32-bit protected mode
switch_to_pm:
    cli ;disable interrupts
    lgdt [gdt_descriptor] ;load gdt
    mov eax, cr0 ;put the value of cr0 in a register
    or eax, 0x1 ;set 32-bit mode in cr0
    mov cr0, eax
    jmp CODE_SEGMENT:init_pm ;the offset of the code segment in the gdt to perform a far jump


[bits 32]
init_pm:
    mov ax, DATA_SEGMENT ;put the address in ax temporarily
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000 ;set stack base to start of free space
    mov esp, ebp

    call BEGIN_PM
