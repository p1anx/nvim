
#include <iostream>

int main(int argc, char *argv[]) { return 0; }
#include "usart.h"
#include <stdio.h>
#ifdef __GNUC__
#define PUTCHAR_PROTOTYPE int __io_putchar(int ch)
#else
#define PUTCHAR_PROTOTYPE int fputc(int ch, FILE *f)
#endif
PUTCHAR_PROTOTYPE {
  HAL_UART_Transmit(&huart1, (uint8_t *)&ch, 1, 0xFFFF); // 阻塞方式打印,串口1
  return ch;
}
stm
