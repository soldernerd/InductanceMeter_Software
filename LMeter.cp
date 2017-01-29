#line 1 "Z:/My Documents/EmbeddedSystems/mikroC/LMeter/LMeter.c"
#line 65 "Z:/My Documents/EmbeddedSystems/mikroC/LMeter/LMeter.c"
volatile  unsigned short int  overflow_count;
volatile  unsigned int  capture_count;
volatile  unsigned int  capture_count_sav;
volatile  long int  total_count;
volatile  long int  total_count_sav;
volatile  unsigned short int  done;
float measured_frequency;
float measured_inductance;
float zero_calibration;
float adjusted_inductance;
#line 80 "Z:/My Documents/EmbeddedSystems/mikroC/LMeter/LMeter.c"
static void display_set_address( unsigned short int  addr)
{
 I2C1_Start();
 I2C1_Wr( 0b01111100  |  0 );
 I2C1_Wr( 0b00000000 );
 I2C1_Wr( 0b10000000  | addr);
 I2C1_Stop();
}
#line 95 "Z:/My Documents/EmbeddedSystems/mikroC/LMeter/LMeter.c"
static void display_init()
{

 PORTC |=  0b00000100 ;


 I2C1_Init(400000);


 delay_ms(50);


 I2C1_Start();
 I2C1_Wr( 0b01111100  |  0 );
 I2C1_Wr( 0b00000000 );
 I2C1_Wr(0x38);
 I2C1_Stop();

 I2C1_Start();
 I2C1_Wr( 0b01111100  |  0 );
 I2C1_Wr( 0b00000000 );
 I2C1_Wr(0x38);
 I2C1_Wr(0x39);
 I2C1_Wr(0x14);
 I2C1_Wr(0x79);
 I2C1_Wr(0x50);
 I2C1_Wr(0x6C);
 I2C1_Wr(0x0C);
 I2C1_Wr(0x01);
 I2C1_Stop();


 delay_ms(50);


 display_set_address( 0x00 );
 I2C1_Start();
 I2C1_Wr( 0b01111100  |  0 );
 I2C1_Wr( 0b01000000 );
 I2C1_Wr('I');
 I2C1_Wr('n');
 I2C1_Wr('d');
 I2C1_Wr('u');
 I2C1_Wr('c');
 I2C1_Wr('t');
 I2C1_Wr('a');
 I2C1_Wr('n');
 I2C1_Wr('c');
 I2C1_Wr('e');
 I2C1_Wr(' ');
 I2C1_Wr('M');
 I2C1_Wr('e');
 I2C1_Wr('t');
 I2C1_Wr('e');
 I2C1_Wr('r');
 I2C1_Stop();
 display_set_address( 0x40 );
 I2C1_Start();
 I2C1_Wr( 0b01111100  |  0 );
 I2C1_Wr( 0b01000000 );
 I2C1_Wr(' ');
 I2C1_Wr('s');
 I2C1_Wr('o');
 I2C1_Wr('l');
 I2C1_Wr('d');
 I2C1_Wr('e');
 I2C1_Wr('r');
 I2C1_Wr('n');
 I2C1_Wr('e');
 I2C1_Wr('r');
 I2C1_Wr('d');
 I2C1_Wr('.');
 I2C1_Wr('c');
 I2C1_Wr('o');
 I2C1_Wr('m');
 I2C1_Wr(' ');
 I2C1_Stop();
}
#line 179 "Z:/My Documents/EmbeddedSystems/mikroC/LMeter/LMeter.c"
static void init()
{

 overflow_count = 0;
 capture_count = 0;
 capture_count_sav = 0;
 total_count = 0;
 total_count_sav = 0;
 done = 0;
 measured_frequency = 0.0;
 measured_inductance = 0.0;
 zero_calibration =  1.91459 ;
 adjusted_inductance = 0.0;


 TRISB = 0b00010001;
 PORTB = 0x00;

 TRISC = 0b00011000;
 PORTC = 0x00;

 ANSELA = 0x00;
 ANSELB = 0x00;


 display_init();


 T1CON = 0b01000001;

 CCP4CON = 0b00000100;

 PIR1 = 0x00;
 PIE1 = 0b00000001;
 PIR3 = 0x00;
 PIE3 = 0b00100000;
 INTCON = 0b11000000;
}
#line 225 "Z:/My Documents/EmbeddedSystems/mikroC/LMeter/LMeter.c"
void interrupt()
{
  unsigned int  timer_value;
  unsigned short int  timer_low;


 if(PIR3 &  0b00100000 )
 {
 ++capture_count;
 if(overflow_count>= 64 )
 {
 timer_low = CCPR4L;
 timer_value = CCPR4H;
 timer_value <<= 8;
 timer_value |= timer_low;
 total_count_sav = total_count + timer_value;
 total_count = 0;
 total_count -= timer_value;
 capture_count_sav = capture_count;
 capture_count = 0;
 overflow_count = 0;
 done = 1;
 }
 PIR3 &= ~ 0b00100000 ;
 return;
 }


 if(PIR1 &  0b00000001 )
 {
 ++overflow_count;
 total_count += 65536;
 if(overflow_count> 128 )
 {
 done = 2;
 }
 PIR1 &= ~ 0b00000001 ;
 return;
 }
}
#line 270 "Z:/My Documents/EmbeddedSystems/mikroC/LMeter/LMeter.c"
void main()
{
  short int  i;
 char valstring[16];


 init();

 delay_ms(1000);

 done = 0;


 while(1)
 {

 if(done==1)
 {

 measured_frequency = (256.0 *  16000000.0  * capture_count_sav) / total_count_sav;
 measured_inductance = 2 *  3.14159265359  * measured_frequency * sqrt( 0.0000000005 );
 measured_inductance = 1000000 / (measured_inductance * measured_inductance);

 if(~ PORTB & 0b00010000 )
 {
 zero_calibration = measured_inductance;
 }

 FloatToStr(measured_frequency/1000.0, &valstring);
 display_set_address( 0x00 );
 I2C1_Start();
 I2C1_Wr( 0b01111100  |  0 );
 I2C1_Wr( 0b01000000 );
 I2C1_Wr('F');
 I2C1_Wr('r');
 I2C1_Wr('e');
 I2C1_Wr('q');
 I2C1_Wr(':');
 I2C1_Wr(' ');
 for(i=0;valstring[i]&&i<7;++i)
 {
 I2C1_Wr(valstring[i]);
 }
 I2C1_Wr('k');
 I2C1_Wr('H');
 I2C1_Wr('z');
 I2C1_Wr(' ');
 I2C1_Wr(' ');
 I2C1_Wr(' ');
 I2C1_Wr(' ');
 I2C1_Stop();

 adjusted_inductance = measured_inductance - zero_calibration;
 display_set_address( 0x40 );
 if(abs(adjusted_inductance)<1)
 {

 FloatToStr(adjusted_inductance*1000.0, &valstring);
 I2C1_Start();
 I2C1_Wr( 0b01111100  |  0 );
 I2C1_Wr( 0b01000000 );
 I2C1_Wr('I');
 I2C1_Wr('n');
 I2C1_Wr('d');
 I2C1_Wr('u');
 I2C1_Wr('c');
 I2C1_Wr(':');
 I2C1_Wr(' ');
 for(i=0;valstring[i]&&i<7;++i)
 {
 I2C1_Wr(valstring[i]);
 }
 I2C1_Wr('n');
 I2C1_Wr('H');
 I2C1_Wr(' ');
 I2C1_Wr(' ');
 I2C1_Wr(' ');
 I2C1_Wr(' ');
 I2C1_Wr(' ');
 I2C1_Wr(' ');
 I2C1_Stop();
 }
 else
 {

 FloatToStr(adjusted_inductance, &valstring);
 I2C1_Start();
 I2C1_Wr( 0b01111100  |  0 );
 I2C1_Wr( 0b01000000 );
 I2C1_Wr('I');
 I2C1_Wr('n');
 I2C1_Wr('d');
 I2C1_Wr('u');
 I2C1_Wr('c');
 I2C1_Wr(':');
 I2C1_Wr(' ');
 for(i=0;valstring[i]&&i<7;++i)
 {
 I2C1_Wr(valstring[i]);
 }
 I2C1_Wr('u');
 I2C1_Wr('H');
 I2C1_Wr(' ');
 I2C1_Wr(' ');
 I2C1_Wr(' ');
 I2C1_Wr(' ');
 I2C1_Wr(' ');
 I2C1_Wr(' ');
 I2C1_Stop();
 }
 done = 0;
 }


 if(done==2)
 {

 display_set_address( 0x00 );
 I2C1_Start();
 I2C1_Wr( 0b01111100  |  0 );
 I2C1_Wr( 0b01000000 );
 I2C1_Wr('N');
 I2C1_Wr('o');
 I2C1_Wr('t');
 I2C1_Wr(' ');
 I2C1_Wr('r');
 I2C1_Wr('e');
 I2C1_Wr('s');
 I2C1_Wr('o');
 I2C1_Wr('n');
 I2C1_Wr('a');
 I2C1_Wr('t');
 I2C1_Wr('i');
 I2C1_Wr('n');
 I2C1_Wr('g');
 I2C1_Wr(' ');
 I2C1_Wr(' ');
 I2C1_Stop();

 display_set_address( 0x40 );
 if(abs(zero_calibration)<1)
 {

 FloatToStr(zero_calibration*1000.0, &valstring);
 I2C1_Start();
 I2C1_Wr( 0b01111100  |  0 );
 I2C1_Wr( 0b01000000 );
 I2C1_Wr('C');
 I2C1_Wr('a');
 I2C1_Wr('l');
 I2C1_Wr('i');
 I2C1_Wr('b');
 I2C1_Wr(':');
 I2C1_Wr(' ');
 for(i=0;valstring[i]&&i<7;++i)
 {
 I2C1_Wr(valstring[i]);
 }
 I2C1_Wr('n');
 I2C1_Wr('H');
 I2C1_Wr(' ');
 I2C1_Wr(' ');
 I2C1_Wr(' ');
 I2C1_Wr(' ');
 I2C1_Wr(' ');
 I2C1_Wr(' ');
 I2C1_Stop();
 }
 else
 {

 FloatToStr(zero_calibration, &valstring);
 I2C1_Start();
 I2C1_Wr( 0b01111100  |  0 );
 I2C1_Wr( 0b01000000 );
 I2C1_Wr('C');
 I2C1_Wr('a');
 I2C1_Wr('l');
 I2C1_Wr('i');
 I2C1_Wr('b');
 I2C1_Wr(':');
 I2C1_Wr(' ');
 for(i=0;valstring[i]&&i<7;++i)
 {
 I2C1_Wr(valstring[i]);
 }
 I2C1_Wr('u');
 I2C1_Wr('H');
 I2C1_Wr(' ');
 I2C1_Wr(' ');
 I2C1_Wr(' ');
 I2C1_Wr(' ');
 I2C1_Wr(' ');
 I2C1_Wr(' ');
 I2C1_Stop();
 }
 done = 0;
 }
 }
}
