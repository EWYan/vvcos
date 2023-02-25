ENTRY(_vector_tbl)

MEMORY {
    flash (r)       :   ORIGIN = 0x10000000, LENGTH = 0x400*32
    iram (rwx)      :   ORIGIN = 0x00410000, LENGTH = 0x400*4
}

SECTIONS {
    . = 0x00410000;
    __vec_addr = .;
    .start_text :
    {
        *(.text.vec*);
        *(.text._start*);
    } > iram
    .text :
    {
        *(.text*);
    } > iram
    .rodata :
    {
        *(.rodata*);
    }
    . = ALIGN(4096);
    .stack (NOLOAD) : ALIGN(32) 
    {
        __stack_start = .;
        .+ = 0x4000;
        . = ALIGN(32);
        __stack_end = .;
    } > iram
    . = ALIGN(4096);
    __load_data_start = .;
    __data_start = .;
    .data :
    {
        *(.data*);
        *(.Shm.Init*);
        *(.dma_buffer*);
    } > iram
    . = ALIGN(4096);
    __data_end = .;

    __bss_start = .;
    .bss :
    {
        *(.bss*);
    } > iram

    /* ## Discarded sections */
    /DISCARD/ :
    {
        *(.ARM.exidx);
        *(.ARM.exidx.*);
        *(.ARM.extab.*);
    }
}