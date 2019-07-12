\ WiringPI

0 CONSTANT INPUT
1 CONSTANT OUTPUT

0 CONSTANT LOW
1 CONSTANT HIGH

Library: libwiringPi.so

Extern: int wiringPiSetup (
        void
);

Extern: int wiringPiSPISetup (
        int channel,
        int speed
);

Extern: void pinMode (
	int pin,
	int mode
);

Extern: int digitalRead (
        int pin
);

Extern: void digitalWrite (
        int pin,
        int value
);

Extern: int wiringPiSPIDataRW (
	int channel,
	unsigned char *data,
	int len
);

Extern: void delayMicroseconds (
	unsigned int howLong
) ;
