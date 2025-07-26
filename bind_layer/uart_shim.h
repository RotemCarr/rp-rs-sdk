#ifndef UART_SHIM_H
#define UART_SHIM_H

void uart_init(void);
void uart_write(char c);
char uart_read(void);

#endif