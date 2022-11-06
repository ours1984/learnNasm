#include "graphic.h"
#include "system.h"
#include "io.h"
#include "math.h"

#define npmtimes 500000

void nop_times(int count)
{
    for(int i=0;i<count;i++)
    {
        NOP;
    }
}

void init_palette(void)
{
    static u8 rgb[] = {
        0x00, 0x00, 0x00, //黑
        0xff, 0x00, 0x00, //红
        0xff, 0xff, 0x00, 
        0x00, 0xff, 0x00, //绿
        0x00, 0xff, 0xff, 
        0x00, 0x00, 0xff, //蓝
        0xff, 0xff, 0xff, //白
    };

    int eflags = io_load_eflags(); /* 记录中断许可标志的值*/
    CLI; /* 将中断许可标志置为0，禁止中断 */

    
    int port = 0;
    u8 *next=rgb;
    u8 *last=rgb;
    for (int i = 0; i <8; i++) {
        next += 3;
        for(int j=0;j<=42;j++)
        {
            if(port>0xff)
                break;
            io_out8(PALETE_PORT, port++);
            for(int k=0;k<3;k++)
            {
                if(next[k]==last[k])
                    io_out8(PALETE_VALUE, last[k]);
                else if(next[k]>last[k])
                    io_out8(PALETE_VALUE, last[k]+6*j);
                else
                    io_out8(PALETE_VALUE, last[k]-6*j);
            }
        }
        last = next;
    }

    io_store_eflags(eflags); /* 复原中断许可标志 */

}

void draw_point_clear(int x,int y,int size1,int size2)
{
    int lim1 = -size2/2;
    int lim2 = size2/2;
    int sque = size2*size2/4;
    int sque1 = size1*size1/4;

    u8* addr = (u8*)(VIDIO_START + x + y*VIDIO_WIDTH);
    for (int i = lim1; i < lim2; i++)
    {
        for (int j = lim1; j < lim2; j++)
        {
            int tmp = i*i+j*j;
            if(tmp<=sque&&tmp>=sque1)
            {
                *(addr+i+j*VIDIO_WIDTH)=0;
            }
        }
    }
}

void draw_point_color(int x,int y,int size,u8 color)
{
    int lim1 = -size/2;
    int lim2 = size/2;
    int sque = size*size/4;

    u8* addr = (u8*)(VIDIO_START + x + y*VIDIO_WIDTH);
    for (int i = lim1; i < lim2; i++)
    {
        for (int j = lim1; j < lim2; j++)
        {
            if(i*i+j*j<=sque)
            {
                *(addr+i+j*VIDIO_WIDTH)=color;
            }
        }
    }
}

void draw_point_radom(int x,int y,int size,int count)
{
    static u8 color=0;
    u8* addr = (u8*)(VIDIO_START + x + y*VIDIO_WIDTH);
    for(int cc=0;cc<count;++cc)
    {
        draw_point_color(x,y,size,color++);
    }
}

void draw_line_color(int x0,int y0,int x1,int y1,int tmpsize,u8 color)
{
    if((x0-x1)*(x0-x1)>(y0-y1)*(y0-y1))
    {
        int delta=x0<x1?1:-1;
        for (int x = x0; x != x1; x+=delta)
        {
            int y = (y1-y0);
            y *= (x-x0);
            y /= (x1-x0);
            y += y0;
            draw_point_color(x,y,tmpsize,color);
            nop_times(npmtimes);
        }
    }
    else
    {
        int delta=y0<y1?1:-1;
        for (int y = y0; y != y1; y+=delta)
        {
            int x = (x1-x0);
            x *= (y-y0);
            x /= (y1-y0);
            x += x0;
            draw_point_color(x,y,tmpsize,color);
            nop_times(npmtimes);
        }
    }
}

void draw_line_radom(int x0,int y0,int x1,int y1,int tmpsize)
{
    static u8 color=0; 
    draw_line_color(x0,y0,x1,y1,tmpsize,color++);
}