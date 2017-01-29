/*
 * Stand-alone Inductance Meter
 * Lukas Fässler, 2015-01-22
 * To be compiled using MikroC for PIC
 * See www.soldernerd.com for description, schematics, Eagle files, photos and more
 */
 
 /******************************************************************************
 * Standard Data Types                                                        *
 ******************************************************************************/
#define uint8_t unsigned short int
#define int8_t short int
#define uint16_t unsigned int
#define int16_t int
#define uint32_t unsigned long int
#define int32_t long int

/******************************************************************************
 * GPIO                                                                       *
 ******************************************************************************/
#define BUTTON_PORT PORTB
#define BUTTON_MASK 0b00010000

/******************************************************************************
 * I2C                                                                        *
 ******************************************************************************/
#define I2C_DISPLAY_ADDRESS 0b01111100   /*(0x3E<<1)*/
#define I2C_READ 1
#define I2C_WRITE 0
#define I2C_NOT_ACKNOWLEDGE 0
#define I2C_ACKNOWLEDGE 1
#define I2C_CONTINUE 0b10000000

/******************************************************************************
 * Display                                                                    *
 ******************************************************************************/
#define DISPLAY_RESET_PIN 0b00000100
#define DISPLAY_INSTRUCTION_REGISTER 0b00000000
#define DISPLAY_DATA_REGISTER 0b01000000
#define DISPLAY_CONTINUE_FLAG 0b10000000
#define DISPLAY_LINE_0 0x00
#define DISPLAY_LINE_1 0x40
#define DISPLAY_CLEAR 0b00000001
#define DISPLAY_SET_ADDRESS 0b10000000

/******************************************************************************
 * Timer/Capture                                                              *
 ******************************************************************************/
#define TIMER1_OVERFLOW_FLAG 0b00000001
#define CCP4_INTERRUPT_FLAG 0b00100000
#define OVERFLOW_COUNT_MINIMUM 64
#define OVERFLOW_COUNT_MAXIMUM 128

/******************************************************************************
 * Measurement                                                                *
 ******************************************************************************/
#define CPU_FREQUENCY 16000000.0 /* must be a float. use 16000000.0 as default */
#define CAPACITY 0.0000000005 /* in Farad */
#define ZERO_INDUCTANCE 1.91459 /* in microHenry (uH) */
#define PI 3.14159265359

/******************************************************************************
 * Global variables                                                           *
 ******************************************************************************/
volatile uint8_t overflow_count;
volatile uint16_t capture_count;
volatile uint16_t capture_count_sav;
volatile int32_t total_count;
volatile int32_t total_count_sav;
volatile uint8_t done;
float measured_frequency;
float measured_inductance;
float zero_calibration;
float adjusted_inductance;

/******************************************************************************
 * display_set_address()                                                      *
 * Sets display cursor to a certain address                                   *
 ******************************************************************************/
static void display_set_address(uint8_t addr)
{
  I2C1_Start();
  I2C1_Wr(I2C_DISPLAY_ADDRESS | I2C_WRITE);
  I2C1_Wr(DISPLAY_INSTRUCTION_REGISTER);
  I2C1_Wr(DISPLAY_SET_ADDRESS | addr);
  I2C1_Stop();
}


/******************************************************************************
 * display_init()                                                             *
 * Set up I2C and initialize display                                          *
 * Ports/Pins are assumed to be set up correctly                              *
 ******************************************************************************/
static void display_init()
{
  //Set display reset pin high (reset is active-low)
  PORTC |= DISPLAY_RESET_PIN;

  //Initialize I2C module with 400kbit/s
  I2C1_Init(400000);
  
  //The display needs some start-up time
  delay_ms(50);

  //Initialize display (see datasheet page 10)
  I2C1_Start();
  I2C1_Wr(I2C_DISPLAY_ADDRESS | I2C_WRITE);
  I2C1_Wr(DISPLAY_INSTRUCTION_REGISTER);
  I2C1_Wr(0x38);
  I2C1_Stop();

  I2C1_Start();
  I2C1_Wr(I2C_DISPLAY_ADDRESS | I2C_WRITE);
  I2C1_Wr(DISPLAY_INSTRUCTION_REGISTER);
  I2C1_Wr(0x38);
  I2C1_Wr(0x39);
  I2C1_Wr(0x14);
  I2C1_Wr(0x79);
  I2C1_Wr(0x50);
  I2C1_Wr(0x6C);
  I2C1_Wr(0x0C);
  I2C1_Wr(0x01);
  I2C1_Stop();
  
  //The display needs some time again
  delay_ms(50);
  
  //Print welcome message
  display_set_address(DISPLAY_LINE_0);
  I2C1_Start();
  I2C1_Wr(I2C_DISPLAY_ADDRESS | I2C_WRITE);
  I2C1_Wr(DISPLAY_DATA_REGISTER);
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
    display_set_address(DISPLAY_LINE_1);
  I2C1_Start();
  I2C1_Wr(I2C_DISPLAY_ADDRESS | I2C_WRITE);
  I2C1_Wr(DISPLAY_DATA_REGISTER);
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


/******************************************************************************
 * init()                                                                     *
 * Initialize variables, ports/pins, timer, input capture and interrupts      *
 ******************************************************************************/
static void init()
{
  //Initialize variables
  overflow_count = 0;
  capture_count = 0;
  capture_count_sav = 0;
  total_count = 0;
  total_count_sav = 0;
  done = 0;
  measured_frequency = 0.0;
  measured_inductance = 0.0;
  zero_calibration = ZERO_INDUCTANCE;
  adjusted_inductance = 0.0;

  //Configure Port B
  TRISB = 0b00010001;
  PORTB = 0x00;
  //Configure Port C
  TRISC = 0b00011000;
  PORTC = 0x00;
  //All inputs digital
  ANSELA = 0x00;
  ANSELB = 0x00;
  
  //Initialize display
  display_init();
  
  //Initialize Timer1
  T1CON = 0b01000001; //System clock, prescaler=1, timer1 on
  //Initialize CCP4
  CCP4CON = 0b00000100; //Capture mode: every falling edge
  //Configure interrupts
  PIR1 = 0x00; //Clear interrupt flags
  PIE1 = 0b00000001; //Enable Timer1 overflow interrupts
  PIR3 = 0x00; //Clear interrupt flags
  PIE3 = 0b00100000; //Enable CCP4 capture interrupts
  INTCON = 0b11000000; //Enable peripheral inerrupts
}


/******************************************************************************
 * interrupt()                                                                *
 * Interrupt service routine (ISR)                                            *
 * Handles timer1 overflow and CCP4 input capture                             *
 * Beware: the I2C library triggers and handles interrupts as well            *
 ******************************************************************************/
void interrupt()
{
  uint16_t timer_value;
  uint8_t timer_low;
  
  //CCP4 capture interrupt
  if(PIR3 & CCP4_INTERRUPT_FLAG)
  {
    ++capture_count;
      if(overflow_count>=OVERFLOW_COUNT_MINIMUM)
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
    PIR3 &= ~CCP4_INTERRUPT_FLAG; //Clear interrupt flags
    return;
  }
  
  //Timer1 overflow interrupt
  if(PIR1 & TIMER1_OVERFLOW_FLAG)
  {
    ++overflow_count;
    total_count += 65536;
    if(overflow_count>OVERFLOW_COUNT_MAXIMUM)
    {
      done = 2;
    }
    PIR1 &= ~TIMER1_OVERFLOW_FLAG; //Clear interrupt flags
    return;
  }
}


/******************************************************************************
 * main()                                                                     *
 ******************************************************************************/
void main() 
{
  int8_t i;
  char valstring[16];
  
  //Set everything up
  init();
  //Display welcome screen for some time
  delay_ms(1000);
  //Reset done flag
  done = 0;

  //Enter an endless loop
  while(1)
  {
    //Oscillator is resonating
    if(done==1)
    {
      //Do the math
      measured_frequency = (256.0 * CPU_FREQUENCY * capture_count_sav) / total_count_sav;
      measured_inductance = 2 * PI * measured_frequency * sqrt(CAPACITY);
      measured_inductance = 1000000 / (measured_inductance * measured_inductance);
      //Update calibration if button is pressed
      if(~BUTTON_PORT&BUTTON_MASK)
      {
        zero_calibration = measured_inductance;
      }
      //Display frequency
      FloatToStr(measured_frequency/1000.0, &valstring);
      display_set_address(DISPLAY_LINE_0);
      I2C1_Start();
      I2C1_Wr(I2C_DISPLAY_ADDRESS | I2C_WRITE);
      I2C1_Wr(DISPLAY_DATA_REGISTER);
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
      //Display inductance
      adjusted_inductance = measured_inductance - zero_calibration;
      display_set_address(DISPLAY_LINE_1);
      if(abs(adjusted_inductance)<1)
      {
        //Display in nanoHenry
        FloatToStr(adjusted_inductance*1000.0, &valstring);
        I2C1_Start();
        I2C1_Wr(I2C_DISPLAY_ADDRESS | I2C_WRITE);
        I2C1_Wr(DISPLAY_DATA_REGISTER);
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
        //Display in microHenry
        FloatToStr(adjusted_inductance, &valstring);
        I2C1_Start();
        I2C1_Wr(I2C_DISPLAY_ADDRESS | I2C_WRITE);
        I2C1_Wr(DISPLAY_DATA_REGISTER);
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
    
    //Oscillator is not resonating
    if(done==2)
    {
      //Display message
      display_set_address(DISPLAY_LINE_0);
      I2C1_Start();
      I2C1_Wr(I2C_DISPLAY_ADDRESS | I2C_WRITE);
      I2C1_Wr(DISPLAY_DATA_REGISTER);
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
      //Display zero calibration
      display_set_address(DISPLAY_LINE_1);
      if(abs(zero_calibration)<1)
      {
        //Display in nanoHenry
        FloatToStr(zero_calibration*1000.0, &valstring);
        I2C1_Start();
        I2C1_Wr(I2C_DISPLAY_ADDRESS | I2C_WRITE);
        I2C1_Wr(DISPLAY_DATA_REGISTER);
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
        //Display in microHenry
        FloatToStr(zero_calibration, &valstring);
        I2C1_Start();
        I2C1_Wr(I2C_DISPLAY_ADDRESS | I2C_WRITE);
        I2C1_Wr(DISPLAY_DATA_REGISTER);
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