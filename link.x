/* Memory regions for RP2040 */
MEMORY
{
  BOOT2 : ORIGIN = 0x10000000, LENGTH = 0x100
  FLASH : ORIGIN = 0x10000100, LENGTH = 2048K - 0x100
  RAM   : ORIGIN = 0x20000000, LENGTH = 264K
}

/* Entry point used by elf2uf2 */
ENTRY(main);

SECTIONS
{
  /* Boot2 section */
  .boot2 ORIGIN(BOOT2) : ALIGN(4)
  {
    KEEP(*(.boot2));
  } > BOOT2

  /* Vector table (typically Reset handler) */
  .vector_table ORIGIN(FLASH) : ALIGN(4)
  {
    KEEP(*(.vector_table))
  } > FLASH

  /* Code and constants */
  .text : ALIGN(4)
  {
    *(.text .text.*)
    *(.rodata .rodata.*)
  } > FLASH

  /* Initialized data section */
  .data : ALIGN(4)
  {
    _sidata = LOADADDR(.data);
    _sdata = .;
    *(.data .data.*)
    _edata = .;
  } > RAM AT > FLASH

  /* Uninitialized data section */
  .bss (NOLOAD) : ALIGN(4)
  {
    _sbss = .;
    *(.bss .bss.*)
    *(COMMON)
    _ebss = .;
  } > RAM

  /* Discard extraneous preinit arrays */
  /DISCARD/ : {
    *(.preinit_array*)
  }

  /* Symbols expected by Pico SDK */
  PROVIDE(__stack_start = ORIGIN(RAM) + LENGTH(RAM));
  PROVIDE(_stack_start = __stack_start);
  PROVIDE(__bss_start__ = ADDR(.bss));
  PROVIDE(__bss_end__ = ADDR(.bss) + SIZEOF(.bss));
  PROVIDE(__data_start__ = ADDR(.data));
  PROVIDE(__data_end__ = ADDR(.data) + SIZEOF(.data));
  PROVIDE(__etext = LOADADDR(.data));
  PROVIDE(__StackTop = __stack_start);
  PROVIDE(_reset_vector = ADDR(.vector_table));
  PROVIDE(__sbss = _sbss);
  PROVIDE(__ebss = _ebss);
  PROVIDE(__sdata = _sdata);
  PROVIDE(__edata = _edata);
  PROVIDE(__sidata = _sidata);

  /* Optional stubs to prevent linker errors */
  PROVIDE(puts = 0);
  PROVIDE(putchar = 0);
  PROVIDE(__mutex_array_start = 0);
  PROVIDE(__mutex_array_end = 0);
  __scratch_x_source__ = ORIGIN(RAM);
  __scratch_x_start__ = __scratch_x_source__;
  __scratch_x_end__ = __scratch_x_source__ + 4K;

  __scratch_y_source__ = __scratch_x_end__;
  __scratch_y_start__ = __scratch_y_source__;
  __scratch_y_end__ = __scratch_y_source__ + 4K;
}
