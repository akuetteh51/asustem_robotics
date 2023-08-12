import machine
import gc
import time



#import Display lib
import gfx
gc.collect()
from ili9341 import Display, color565
from xglcd_font import XglcdFont

#weight
from hx711 import HX711
hx = HX711(dout=13, pd_sck=12)
# TFT display constants
TFTWIDTH = 240
TFTHEIGHT = 320

# SPI constants
SPI_BAUDRATE = 20000000
SPI_SCK = 18
SPI_MOSI = 23
SPI_MISO = 19
SPI_CS = 5
SPI_DC = 16
SPI_RST = 17

# Color constants
BLACK = 0x000000
WHITE = 0xFFFFFF
RED = 0xFF0000
GREEN = 0x00FF00
BLUE = 0x0000FF

# Initialize SPI bus
spi = machine.SPI(2,
    baudrate=SPI_BAUDRATE,
    polarity=0,
    phase=0,
    bits=8,
    firstbit=machine.SPI.MSB,
    sck=machine.Pin(SPI_SCK),
    mosi=machine.Pin(SPI_MOSI),
    miso=machine.Pin(SPI_MISO),
)

# Initialize TFT display
display = Display(
    spi,
    cs=machine.Pin(SPI_CS),
    dc=machine.Pin(SPI_DC),
    rst=machine.Pin(SPI_RST),
    width=TFTHEIGHT,
    height=TFTWIDTH,rotation=90
)
graphics = gfx.GFX(320, 240, display.draw_pixel)
unispace = XglcdFont('Unispace12x24.c', 12, 24)


def fill_rect(x, y, width, height, color):
    display.fill_rectangle(x, y,  y + height - 1,x + width - 1, color)

def fill_screen(color):
    fill_rect(0, 0, TFTWIDTH, TFTHEIGHT, color)

# Main loop
fill_screen(WHITE)
def main_fun(Bp,height,tmp,weight):
    
    box_width = 150
    box_height = 100
    padding = 10
    x1 = padding
    y1 = padding
    x2 = x1 + box_width
    y2 = y1 + box_height

    graphics.round_rect(5, 10,box_width,box_height, 10,0x3E64FF)

    graphics.round_rect(5, 120, box_width,box_height, 10,BLUE)
    graphics.round_rect(160, 10,box_width,box_height, 10,BLUE)

    graphics.round_rect(160, 120, box_width,box_height, 10,0x3E64FF)

    label_text = [Bp,height,tmp,weight]
    image_paths = ["bp50x50.raw", "height50x50.raw", "temp50x50.raw", "weight50x50.raw"]
    label_unit= ["mmhg", "ft", "C", "kg"]



    for i, text in enumerate(label_text):
        x = padding + (i % 2) * (box_width + padding)
        y = padding + (i // 2) * (box_height + padding)
        display.draw_text(x + 130 // 2, y + 32,text,  unispace,color565(0, 0, 255),WHITE)
        display.draw_text(x + 130 // 2, y + 60,label_unit[i],  unispace,color565(0, 0, 255),WHITE)


    for i, path in enumerate(image_paths):
        x = padding + (i % 2) * (box_width + padding)
        y = padding + (i // 2) * (box_height + padding)
        display.draw_image('sensor/'+path,x + 10 // 2, y + 25,50,50)


        



    

