
/*
 * @Author: Edward.Shaw 
 * @Date: 2022-11-06 16:43:44 
 * @Last Modified by: Edward.Shaw
 * @Last Modified time: 2022-11-06 21:08:41
 */

#ifndef OURS1984_KERNEL_GRAPHIC_H
#define OURS1984_KERNEL_GRAPHIC_H

#include "types.h"

void draw_point_radom(int x,int y,int size,int count);

void draw_point_color(int x,int y,int size,u8 color);

void draw_point_clear(int x,int y,int size1,int size2);

void draw_line_radom(int x0,int y0,int x1,int y1,int tmpsize);

void draw_line_color(int x0,int y0,int x1,int y1,int tmpsize,u8 color);

#endif // OURS1984_KERNEL_GRAPHIC_H