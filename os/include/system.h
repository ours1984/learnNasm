/*
 * @Author: Edward.Shaw 
 * @Date: 2022-11-06 15:47:04 
 * @Last Modified by: Edward.Shaw
 * @Last Modified time: 2022-11-06 17:51:13
 */

#ifndef OURS1984_KERNEL_SYSTEM_H
#define OURS1984_KERNEL_SYSTEM_H

#define BOCHS_DEBUG_MAGIC   __asm__("xchg bx, bx");

#define VIDIO_START (0xa0000)
#define VIDIO_END (0xaffff)
#define VIDIO_WIDTH (320)
#define VIDIO_HIGHT (200)
#define PALETE_PORT (0X03C8)
#define PALETE_VALUE (0x03c9)

#define STI   __asm__("sti")
#define CLI   __asm__("cli")
#define HLT   __asm__("hlt")
#define NOP   __asm__("nop")

typedef enum {
    rc_black = 0,
    rc_blue = 1,
    rc_green = 2,
    rc_cyan = 3,
    rc_red = 4,
    rc_magenta = 5,
    rc_brown = 6,
    rc_light_grey = 7,
    rc_dark_grey = 8,
    rc_light_blue = 9,
    rc_light_green = 10,
    rc_light_cyan = 11,
    rc_light_red = 12,
    rc_light_magenta = 13,
    rc_light_brown = 14,
    rc_white = 15
} real_color_t;


#endif // OURS1984_KERNEL_SYSTEM_H

