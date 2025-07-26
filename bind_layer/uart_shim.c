#include "pico/stdlib.h"
#include "hardware/uart.h"

void uart_shim_init() {
    stdio_init_all();
}

void uart_shim_write(char c) {
    uart_putc(uart0, c);  // Direct UART write
}

char uart_shim_read() {
    return uart_getc(uart0);  // Direct UART read
}