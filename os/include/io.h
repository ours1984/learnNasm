/*
 * @Author: Edward.Shaw 
 * @Date: 2022-11-06 15:46:54 
 * @Last Modified by: Edward.Shaw
 * @Last Modified time: 2022-11-06 17:59:42
 */

#ifndef OURS1984_KERNEL_IO_H
#define OURS1984_KERNEL_IO_H

char in_byte(int port);
short in_word(int port);

void out_byte(int port, int v);
void out_word(int port, int v);

int io_in8(int);
int io_in16(int);
int io_in32(int);

void io_out8(int,int);
void io_out16(int,int);
void io_out32(int,int);

int io_load_eflags(void);
void io_store_eflags(int);

void nop_times(int count);

#endif // OURS1984_KERNEL_IO_H

