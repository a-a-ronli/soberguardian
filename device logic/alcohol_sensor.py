import time
import board
import busio
import adafruit_ads1x15.ads1115 as ADS
from adafruit_ads1x15.analog_in import AnalogIn

def setup_ads1115():
    """Set up the ADS1115 converter"""
    i2c = busio.I2C(board.SCL, board.SDA)
    ads = ADS.ADS1115(i2c)
    return ads

def read_alcohol_level(ads, channel=0):
    """Read the alcohol level from the specified ADS1115 channel"""
    chan = AnalogIn(ads, getattr(ADS, f"P{channel}"))
    return chan.voltage

def main():
    ads = setup_ads1115()
    print("Detecting alcohol levels...")

    try:
        while True:
            result = read_alcohol_level(ads)
            print(f"Alcohol Level: {alcohol_voltage:.3f} V")

            if result > 0.4:
                print("Alcohol detected!")

            time.sleep(1)

    except KeyboardInterrupt:
        print("Measurement stopped by user.")

if __name__ == "__main__":
    main()