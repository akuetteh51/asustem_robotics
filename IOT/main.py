from machine import Pin, SoftI2C, RTC,Timer 
from utime import ticks_diff, ticks_us
from max30102 import MAX30102, MAX30105_PULSE_AMP_MEDIUM
from time import sleep


#weight
from hx711 import HX711
hx = HX711(dout=13, pd_sck=12)
import _thread
from Bp0 import main_fun
val =0
led = Pin(2, Pin.OUT)
MAX_HISTORY = 32
history = []
beats_history = []
beat = False
beats = 0
spO2 = 0

i2c = SoftI2C(sda=Pin(21),scl=Pin(22),freq=400000)
sensor = MAX30102(i2c=i2c)  # An I2C instance is required

# Scan I2C bus to ensure that the sensor is connected
if sensor.i2c_address not in i2c.scan():
    print("Sensor not found.")
    
elif not (sensor.check_part_id()):
    # Check that the targeted sensor is compatible
    print("I2C device ID not corresponding to MAX30102 or MAX30105.")
    
else:
    print("Sensor connected and recognized.")


sensor.setup_sensor()
sensor.set_sample_rate(400)
sensor.set_fifo_average(8)
sensor.set_active_leds_amplitude(MAX30105_PULSE_AMP_MEDIUM)
sensor.set_led_mode(2)
sleep(1)

t_start = ticks_us()  # Starting time of the acquisition  



def calculate_spO2(red, ir):
    r = red / ir if ir != 0 else 0
    spo2 = -45.060*r*r + 30.354*r + 94.845
    return spo2 if spo2 <= 100 else 100.0


def get_max30102_values():
    
    global history
    global beats_history
    global beat
    global beats
    global t_start
    spo2_b=""
    beats_b=""
    _thread.start_new_thread(main_fun(Bp=beats_b,height=spo2_b,tmp=str(round(sensor.read_temperature(), 2)),weight=str(round(val,2))),())
    sensor.check()
    
    # Check if the storage contains available samples
    if sensor.available():
        # Access the storage FIFO and gather the readings (integers)
        red_reading = sensor.pop_red_from_storage()
        ir_reading = sensor.pop_ir_from_storage()
        
        value = red_reading
        history.append(value)
        # Get the tail, up to MAX_HISTORY length
        history = history[-MAX_HISTORY:]
        minima = 0
        maxima = 0
        threshold_on = 0
        threshold_off = 0

        minima, maxima = min(history), max(history)

        threshold_on = (minima + maxima * 3) // 4   # 3/4
        threshold_off = (minima + maxima) // 2      # 1/2
        
        
        if value > 1000:
            if not beat and value > threshold_on:
                beat = True 
                                
                led.on()
                
                t_us = ticks_diff(ticks_us(), t_start)
                t_s = t_us/1000000
                f = 1/t_s
            
                bpm = f * 60
           
                if bpm < 500:
                    t_start = ticks_us()
                    beats_history.append(bpm)                    
                    beats_history = beats_history[-MAX_HISTORY:] 
                    beats = round(sum(beats_history)/len(beats_history) ,2) 
                  
                    spo2 = calculate_spO2(red_reading, ir_reading)
                   
                    print("Heart rate:", beats, "bpm")
                    print("SpO2:", spo2, "%")
                    print("Checking line")
                    beats_b=str(beats)
                    spo2_b=str(round(spo2,2))
                    
                    label_text = [beats_b,spo2_b , "27.66", ""]
                    main_fun(Bp=beats_b,height=spo2_b,tmp=str(round(sensor.read_temperature(), 2)),weight=str(round(val,2)))
                    return label_text
                
                                                    
            if beat and value< threshold_off:
                beat = False
                led.off()
                
            
        else:
            led.off()
            
#             print('No Finger Detected')
            
            
            beats = 0.00
            
            
            temp_max=str(round(sensor.read_temperature(), 2))
            main_fun(Bp=beats_b,height=spo2_b,tmp=str(round(sensor.read_temperature(), 2)),weight=str(round(val,2)))
            label_text = ["0", "0", "0",temp_max]
           
            return label_text
#     return str(beats), tmp
   
        
    return ["0","0", "0", "0"]
    

def wieght():
    global val
    hx.set_scale(-7050)
    hx.tare()

    while True:
        
        val = hx.get_units(5)
        
        print("weight: " +str(val))
        

_thread.start_new_thread(wieght,())

    
while True:
#     print(label_text)
#      main_fun(Bp=str(beats_b),height=str(spo2_b),tmp=str(temp_max),weight=str(round(val,2)))
# while True:
    print(get_max30102_values())


