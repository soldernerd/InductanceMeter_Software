
LMeter_display_set_address:

;LMeter.c,80 :: 		static void display_set_address(uint8_t addr)
;LMeter.c,82 :: 		I2C1_Start();
	CALL       _I2C1_Start+0
;LMeter.c,83 :: 		I2C1_Wr(I2C_DISPLAY_ADDRESS | I2C_WRITE);
	MOVLW      124
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,84 :: 		I2C1_Wr(DISPLAY_INSTRUCTION_REGISTER);
	CLRF       FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,85 :: 		I2C1_Wr(DISPLAY_SET_ADDRESS | addr);
	MOVLW      128
	IORWF       FARG_LMeter_display_set_address_addr+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,86 :: 		I2C1_Stop();
	CALL       _I2C1_Stop+0
;LMeter.c,87 :: 		}
L_end_display_set_address:
	RETURN
; end of LMeter_display_set_address

LMeter_display_init:

;LMeter.c,95 :: 		static void display_init()
;LMeter.c,98 :: 		PORTC |= DISPLAY_RESET_PIN;
	BSF        PORTC+0, 2
;LMeter.c,101 :: 		I2C1_Init(400000);
	MOVLW      10
	MOVWF      SSPADD+0
	CALL       _I2C1_Init+0
;LMeter.c,104 :: 		delay_ms(50);
	MOVLW      2
	MOVWF      R11
	MOVLW      4
	MOVWF      R12
	MOVLW      186
	MOVWF      R13
L_LMeter_display_init0:
	DECFSZ     R13, 1
	GOTO       L_LMeter_display_init0
	DECFSZ     R12, 1
	GOTO       L_LMeter_display_init0
	DECFSZ     R11, 1
	GOTO       L_LMeter_display_init0
	NOP
;LMeter.c,107 :: 		I2C1_Start();
	CALL       _I2C1_Start+0
;LMeter.c,108 :: 		I2C1_Wr(I2C_DISPLAY_ADDRESS | I2C_WRITE);
	MOVLW      124
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,109 :: 		I2C1_Wr(DISPLAY_INSTRUCTION_REGISTER);
	CLRF       FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,110 :: 		I2C1_Wr(0x38);
	MOVLW      56
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,111 :: 		I2C1_Stop();
	CALL       _I2C1_Stop+0
;LMeter.c,113 :: 		I2C1_Start();
	CALL       _I2C1_Start+0
;LMeter.c,114 :: 		I2C1_Wr(I2C_DISPLAY_ADDRESS | I2C_WRITE);
	MOVLW      124
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,115 :: 		I2C1_Wr(DISPLAY_INSTRUCTION_REGISTER);
	CLRF       FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,116 :: 		I2C1_Wr(0x38);
	MOVLW      56
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,117 :: 		I2C1_Wr(0x39);
	MOVLW      57
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,118 :: 		I2C1_Wr(0x14);
	MOVLW      20
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,119 :: 		I2C1_Wr(0x79);
	MOVLW      121
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,120 :: 		I2C1_Wr(0x50);
	MOVLW      80
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,121 :: 		I2C1_Wr(0x6C);
	MOVLW      108
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,122 :: 		I2C1_Wr(0x0C);
	MOVLW      12
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,123 :: 		I2C1_Wr(0x01);
	MOVLW      1
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,124 :: 		I2C1_Stop();
	CALL       _I2C1_Stop+0
;LMeter.c,127 :: 		delay_ms(50);
	MOVLW      2
	MOVWF      R11
	MOVLW      4
	MOVWF      R12
	MOVLW      186
	MOVWF      R13
L_LMeter_display_init1:
	DECFSZ     R13, 1
	GOTO       L_LMeter_display_init1
	DECFSZ     R12, 1
	GOTO       L_LMeter_display_init1
	DECFSZ     R11, 1
	GOTO       L_LMeter_display_init1
	NOP
;LMeter.c,130 :: 		display_set_address(DISPLAY_LINE_0);
	CLRF       FARG_LMeter_display_set_address_addr+0
	CALL       LMeter_display_set_address+0
;LMeter.c,131 :: 		I2C1_Start();
	CALL       _I2C1_Start+0
;LMeter.c,132 :: 		I2C1_Wr(I2C_DISPLAY_ADDRESS | I2C_WRITE);
	MOVLW      124
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,133 :: 		I2C1_Wr(DISPLAY_DATA_REGISTER);
	MOVLW      64
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,134 :: 		I2C1_Wr('I');
	MOVLW      73
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,135 :: 		I2C1_Wr('n');
	MOVLW      110
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,136 :: 		I2C1_Wr('d');
	MOVLW      100
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,137 :: 		I2C1_Wr('u');
	MOVLW      117
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,138 :: 		I2C1_Wr('c');
	MOVLW      99
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,139 :: 		I2C1_Wr('t');
	MOVLW      116
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,140 :: 		I2C1_Wr('a');
	MOVLW      97
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,141 :: 		I2C1_Wr('n');
	MOVLW      110
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,142 :: 		I2C1_Wr('c');
	MOVLW      99
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,143 :: 		I2C1_Wr('e');
	MOVLW      101
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,144 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,145 :: 		I2C1_Wr('M');
	MOVLW      77
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,146 :: 		I2C1_Wr('e');
	MOVLW      101
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,147 :: 		I2C1_Wr('t');
	MOVLW      116
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,148 :: 		I2C1_Wr('e');
	MOVLW      101
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,149 :: 		I2C1_Wr('r');
	MOVLW      114
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,150 :: 		I2C1_Stop();
	CALL       _I2C1_Stop+0
;LMeter.c,151 :: 		display_set_address(DISPLAY_LINE_1);
	MOVLW      64
	MOVWF      FARG_LMeter_display_set_address_addr+0
	CALL       LMeter_display_set_address+0
;LMeter.c,152 :: 		I2C1_Start();
	CALL       _I2C1_Start+0
;LMeter.c,153 :: 		I2C1_Wr(I2C_DISPLAY_ADDRESS | I2C_WRITE);
	MOVLW      124
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,154 :: 		I2C1_Wr(DISPLAY_DATA_REGISTER);
	MOVLW      64
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,155 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,156 :: 		I2C1_Wr('s');
	MOVLW      115
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,157 :: 		I2C1_Wr('o');
	MOVLW      111
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,158 :: 		I2C1_Wr('l');
	MOVLW      108
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,159 :: 		I2C1_Wr('d');
	MOVLW      100
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,160 :: 		I2C1_Wr('e');
	MOVLW      101
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,161 :: 		I2C1_Wr('r');
	MOVLW      114
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,162 :: 		I2C1_Wr('n');
	MOVLW      110
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,163 :: 		I2C1_Wr('e');
	MOVLW      101
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,164 :: 		I2C1_Wr('r');
	MOVLW      114
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,165 :: 		I2C1_Wr('d');
	MOVLW      100
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,166 :: 		I2C1_Wr('.');
	MOVLW      46
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,167 :: 		I2C1_Wr('c');
	MOVLW      99
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,168 :: 		I2C1_Wr('o');
	MOVLW      111
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,169 :: 		I2C1_Wr('m');
	MOVLW      109
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,170 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,171 :: 		I2C1_Stop();
	CALL       _I2C1_Stop+0
;LMeter.c,172 :: 		}
L_end_display_init:
	RETURN
; end of LMeter_display_init

LMeter_init:

;LMeter.c,179 :: 		static void init()
;LMeter.c,182 :: 		overflow_count = 0;
	CLRF       _overflow_count+0
;LMeter.c,183 :: 		capture_count = 0;
	CLRF       _capture_count+0
	CLRF       _capture_count+1
;LMeter.c,184 :: 		capture_count_sav = 0;
	CLRF       _capture_count_sav+0
	CLRF       _capture_count_sav+1
;LMeter.c,185 :: 		total_count = 0;
	CLRF       _total_count+0
	CLRF       _total_count+1
	CLRF       _total_count+2
	CLRF       _total_count+3
;LMeter.c,186 :: 		total_count_sav = 0;
	CLRF       _total_count_sav+0
	CLRF       _total_count_sav+1
	CLRF       _total_count_sav+2
	CLRF       _total_count_sav+3
;LMeter.c,187 :: 		done = 0;
	CLRF       _done+0
;LMeter.c,188 :: 		measured_frequency = 0.0;
	CLRF       _measured_frequency+0
	CLRF       _measured_frequency+1
	CLRF       _measured_frequency+2
	CLRF       _measured_frequency+3
;LMeter.c,189 :: 		measured_inductance = 0.0;
	CLRF       _measured_inductance+0
	CLRF       _measured_inductance+1
	CLRF       _measured_inductance+2
	CLRF       _measured_inductance+3
;LMeter.c,190 :: 		zero_calibration = ZERO_INDUCTANCE;
	MOVLW      73
	MOVWF      _zero_calibration+0
	MOVLW      17
	MOVWF      _zero_calibration+1
	MOVLW      117
	MOVWF      _zero_calibration+2
	MOVLW      127
	MOVWF      _zero_calibration+3
;LMeter.c,191 :: 		adjusted_inductance = 0.0;
	CLRF       _adjusted_inductance+0
	CLRF       _adjusted_inductance+1
	CLRF       _adjusted_inductance+2
	CLRF       _adjusted_inductance+3
;LMeter.c,194 :: 		TRISB = 0b00010001;
	MOVLW      17
	MOVWF      TRISB+0
;LMeter.c,195 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;LMeter.c,197 :: 		TRISC = 0b00011000;
	MOVLW      24
	MOVWF      TRISC+0
;LMeter.c,198 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;LMeter.c,200 :: 		ANSELA = 0x00;
	CLRF       ANSELA+0
;LMeter.c,201 :: 		ANSELB = 0x00;
	CLRF       ANSELB+0
;LMeter.c,204 :: 		display_init();
	CALL       LMeter_display_init+0
;LMeter.c,207 :: 		T1CON = 0b01000001; //System clock, prescaler=1, timer1 on
	MOVLW      65
	MOVWF      T1CON+0
;LMeter.c,209 :: 		CCP4CON = 0b00000100; //Capture mode: every falling edge
	MOVLW      4
	MOVWF      CCP4CON+0
;LMeter.c,211 :: 		PIR1 = 0x00; //Clear interrupt flags
	CLRF       PIR1+0
;LMeter.c,212 :: 		PIE1 = 0b00000001; //Enable Timer1 overflow interrupts
	MOVLW      1
	MOVWF      PIE1+0
;LMeter.c,213 :: 		PIR3 = 0x00; //Clear interrupt flags
	CLRF       PIR3+0
;LMeter.c,214 :: 		PIE3 = 0b00100000; //Enable CCP4 capture interrupts
	MOVLW      32
	MOVWF      PIE3+0
;LMeter.c,215 :: 		INTCON = 0b11000000; //Enable peripheral inerrupts
	MOVLW      192
	MOVWF      INTCON+0
;LMeter.c,216 :: 		}
L_end_init:
	RETURN
; end of LMeter_init

_interrupt:

;LMeter.c,225 :: 		void interrupt()
;LMeter.c,231 :: 		if(PIR3 & CCP4_INTERRUPT_FLAG)
	BTFSS      PIR3+0, 5
	GOTO       L_interrupt2
;LMeter.c,233 :: 		++capture_count;
	MOVLW      1
	ADDWF      _capture_count+0, 0
	MOVWF      R0
	MOVLW      0
	ADDWFC     _capture_count+1, 0
	MOVWF      R1
	MOVF       R0, 0
	MOVWF      _capture_count+0
	MOVF       R1, 0
	MOVWF      _capture_count+1
;LMeter.c,234 :: 		if(overflow_count>=OVERFLOW_COUNT_MINIMUM)
	MOVLW      64
	SUBWF      _overflow_count+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_interrupt3
;LMeter.c,236 :: 		timer_low = CCPR4L;
	MOVF       CCPR4L+0, 0
	MOVWF      R5+0
;LMeter.c,237 :: 		timer_value = CCPR4H;
	MOVF       CCPR4H+0, 0
	MOVWF      R3+0
	CLRF       R3+1
;LMeter.c,238 :: 		timer_value <<= 8;
	MOVF       R3+0, 0
	MOVWF      R1
	CLRF       R0
	MOVF       R0, 0
	MOVWF      R3+0
	MOVF       R1, 0
	MOVWF      R3+1
;LMeter.c,239 :: 		timer_value |= timer_low;
	MOVF       R5+0, 0
	IORWF       R0, 1
	MOVLW      0
	IORWF       R1, 1
	MOVF       R0, 0
	MOVWF      R3+0
	MOVF       R1, 0
	MOVWF      R3+1
;LMeter.c,240 :: 		total_count_sav = total_count + timer_value;
	MOVF       R0, 0
	ADDWF      _total_count+0, 0
	MOVWF      _total_count_sav+0
	MOVF       R1, 0
	ADDWFC     _total_count+1, 0
	MOVWF      _total_count_sav+1
	MOVLW      0
	ADDWFC     _total_count+2, 0
	MOVWF      _total_count_sav+2
	MOVLW      0
	ADDWFC     _total_count+3, 0
	MOVWF      _total_count_sav+3
;LMeter.c,241 :: 		total_count = 0;
	CLRF       _total_count+0
	CLRF       _total_count+1
	CLRF       _total_count+2
	CLRF       _total_count+3
;LMeter.c,242 :: 		total_count -= timer_value;
	MOVF       R0, 0
	SUBWF      _total_count+0, 1
	MOVF       R1, 0
	SUBWFB     _total_count+1, 1
	MOVLW      0
	SUBWFB     _total_count+2, 1
	SUBWFB     _total_count+3, 1
;LMeter.c,243 :: 		capture_count_sav = capture_count;
	MOVF       _capture_count+0, 0
	MOVWF      _capture_count_sav+0
	MOVF       _capture_count+1, 0
	MOVWF      _capture_count_sav+1
;LMeter.c,244 :: 		capture_count = 0;
	CLRF       _capture_count+0
	CLRF       _capture_count+1
;LMeter.c,245 :: 		overflow_count = 0;
	CLRF       _overflow_count+0
;LMeter.c,246 :: 		done = 1;
	MOVLW      1
	MOVWF      _done+0
;LMeter.c,247 :: 		}
L_interrupt3:
;LMeter.c,248 :: 		PIR3 &= ~CCP4_INTERRUPT_FLAG; //Clear interrupt flags
	BCF        PIR3+0, 5
;LMeter.c,249 :: 		return;
	GOTO       L__interrupt50
;LMeter.c,250 :: 		}
L_interrupt2:
;LMeter.c,253 :: 		if(PIR1 & TIMER1_OVERFLOW_FLAG)
	BTFSS      PIR1+0, 0
	GOTO       L_interrupt4
;LMeter.c,255 :: 		++overflow_count;
	INCF       _overflow_count+0, 0
	MOVWF      R0
	MOVF       R0, 0
	MOVWF      _overflow_count+0
;LMeter.c,256 :: 		total_count += 65536;
	MOVLW      0
	ADDWF      _total_count+0, 1
	MOVLW      0
	ADDWFC     _total_count+1, 1
	MOVLW      1
	ADDWFC     _total_count+2, 1
	MOVLW      0
	ADDWFC     _total_count+3, 1
;LMeter.c,257 :: 		if(overflow_count>OVERFLOW_COUNT_MAXIMUM)
	MOVF       _overflow_count+0, 0
	SUBLW      128
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt5
;LMeter.c,259 :: 		done = 2;
	MOVLW      2
	MOVWF      _done+0
;LMeter.c,260 :: 		}
L_interrupt5:
;LMeter.c,261 :: 		PIR1 &= ~TIMER1_OVERFLOW_FLAG; //Clear interrupt flags
	BCF        PIR1+0, 0
;LMeter.c,262 :: 		return;
	GOTO       L__interrupt50
;LMeter.c,263 :: 		}
L_interrupt4:
;LMeter.c,264 :: 		}
L_end_interrupt:
L__interrupt50:
	RETFIE     %s
; end of _interrupt

_main:

;LMeter.c,270 :: 		void main()
;LMeter.c,276 :: 		init();
	CALL       LMeter_init+0
;LMeter.c,278 :: 		delay_ms(1000);
	MOVLW      21
	MOVWF      R11
	MOVLW      75
	MOVWF      R12
	MOVLW      190
	MOVWF      R13
L_main6:
	DECFSZ     R13, 1
	GOTO       L_main6
	DECFSZ     R12, 1
	GOTO       L_main6
	DECFSZ     R11, 1
	GOTO       L_main6
	NOP
;LMeter.c,280 :: 		done = 0;
	CLRF       _done+0
;LMeter.c,283 :: 		while(1)
L_main7:
;LMeter.c,286 :: 		if(done==1)
	MOVF       _done+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main9
;LMeter.c,289 :: 		measured_frequency = (256.0 * CPU_FREQUENCY * capture_count_sav) / total_count_sav;
	MOVF       _capture_count_sav+0, 0
	MOVWF      R0
	MOVF       _capture_count_sav+1, 0
	MOVWF      R1
	CALL       _Word2Double+0
	MOVLW      0
	MOVWF      R4
	MOVLW      36
	MOVWF      R5
	MOVLW      116
	MOVWF      R6
	MOVLW      158
	MOVWF      R7
	CALL       _Mul_32x32_FP+0
	MOVF       R0, 0
	MOVWF      FLOC__main+0
	MOVF       R1, 0
	MOVWF      FLOC__main+1
	MOVF       R2, 0
	MOVWF      FLOC__main+2
	MOVF       R3, 0
	MOVWF      FLOC__main+3
	MOVF       _total_count_sav+0, 0
	MOVWF      R0
	MOVF       _total_count_sav+1, 0
	MOVWF      R1
	MOVF       _total_count_sav+2, 0
	MOVWF      R2
	MOVF       _total_count_sav+3, 0
	MOVWF      R3
	CALL       _Longint2Double+0
	MOVF       R0, 0
	MOVWF      R4
	MOVF       R1, 0
	MOVWF      R5
	MOVF       R2, 0
	MOVWF      R6
	MOVF       R3, 0
	MOVWF      R7
	MOVF       FLOC__main+0, 0
	MOVWF      R0
	MOVF       FLOC__main+1, 0
	MOVWF      R1
	MOVF       FLOC__main+2, 0
	MOVWF      R2
	MOVF       FLOC__main+3, 0
	MOVWF      R3
	CALL       _Div_32x32_FP+0
	MOVF       R0, 0
	MOVWF      _measured_frequency+0
	MOVF       R1, 0
	MOVWF      _measured_frequency+1
	MOVF       R2, 0
	MOVWF      _measured_frequency+2
	MOVF       R3, 0
	MOVWF      _measured_frequency+3
;LMeter.c,290 :: 		measured_inductance = 2 * PI * measured_frequency * sqrt(CAPACITY);
	MOVLW      219
	MOVWF      R4
	MOVLW      15
	MOVWF      R5
	MOVLW      73
	MOVWF      R6
	MOVLW      129
	MOVWF      R7
	CALL       _Mul_32x32_FP+0
	MOVF       R0, 0
	MOVWF      FLOC__main+0
	MOVF       R1, 0
	MOVWF      FLOC__main+1
	MOVF       R2, 0
	MOVWF      FLOC__main+2
	MOVF       R3, 0
	MOVWF      FLOC__main+3
	MOVLW      95
	MOVWF      FARG_sqrt_x+0
	MOVLW      112
	MOVWF      FARG_sqrt_x+1
	MOVLW      9
	MOVWF      FARG_sqrt_x+2
	MOVLW      96
	MOVWF      FARG_sqrt_x+3
	CALL       _sqrt+0
	MOVF       FLOC__main+0, 0
	MOVWF      R4
	MOVF       FLOC__main+1, 0
	MOVWF      R5
	MOVF       FLOC__main+2, 0
	MOVWF      R6
	MOVF       FLOC__main+3, 0
	MOVWF      R7
	CALL       _Mul_32x32_FP+0
	MOVF       R0, 0
	MOVWF      _measured_inductance+0
	MOVF       R1, 0
	MOVWF      _measured_inductance+1
	MOVF       R2, 0
	MOVWF      _measured_inductance+2
	MOVF       R3, 0
	MOVWF      _measured_inductance+3
;LMeter.c,291 :: 		measured_inductance = 1000000 / (measured_inductance * measured_inductance);
	MOVF       R0, 0
	MOVWF      R4
	MOVF       R1, 0
	MOVWF      R5
	MOVF       R2, 0
	MOVWF      R6
	MOVF       R3, 0
	MOVWF      R7
	CALL       _Mul_32x32_FP+0
	MOVF       R0, 0
	MOVWF      R4
	MOVF       R1, 0
	MOVWF      R5
	MOVF       R2, 0
	MOVWF      R6
	MOVF       R3, 0
	MOVWF      R7
	MOVLW      0
	MOVWF      R0
	MOVLW      36
	MOVWF      R1
	MOVLW      116
	MOVWF      R2
	MOVLW      146
	MOVWF      R3
	CALL       _Div_32x32_FP+0
	MOVF       R0, 0
	MOVWF      _measured_inductance+0
	MOVF       R1, 0
	MOVWF      _measured_inductance+1
	MOVF       R2, 0
	MOVWF      _measured_inductance+2
	MOVF       R3, 0
	MOVWF      _measured_inductance+3
;LMeter.c,293 :: 		if(~BUTTON_PORT&BUTTON_MASK)
	COMF       PORTB+0, 0
	MOVWF      R1
	BTFSS      R1, 4
	GOTO       L_main10
;LMeter.c,295 :: 		zero_calibration = measured_inductance;
	MOVF       _measured_inductance+0, 0
	MOVWF      _zero_calibration+0
	MOVF       _measured_inductance+1, 0
	MOVWF      _zero_calibration+1
	MOVF       _measured_inductance+2, 0
	MOVWF      _zero_calibration+2
	MOVF       _measured_inductance+3, 0
	MOVWF      _zero_calibration+3
;LMeter.c,296 :: 		}
L_main10:
;LMeter.c,298 :: 		FloatToStr(measured_frequency/1000.0, &valstring);
	MOVLW      0
	MOVWF      R4
	MOVLW      0
	MOVWF      R5
	MOVLW      122
	MOVWF      R6
	MOVLW      136
	MOVWF      R7
	MOVF       _measured_frequency+0, 0
	MOVWF      R0
	MOVF       _measured_frequency+1, 0
	MOVWF      R1
	MOVF       _measured_frequency+2, 0
	MOVWF      R2
	MOVF       _measured_frequency+3, 0
	MOVWF      R3
	CALL       _Div_32x32_FP+0
	MOVF       R0, 0
	MOVWF      FARG_FloatToStr_fnum+0
	MOVF       R1, 0
	MOVWF      FARG_FloatToStr_fnum+1
	MOVF       R2, 0
	MOVWF      FARG_FloatToStr_fnum+2
	MOVF       R3, 0
	MOVWF      FARG_FloatToStr_fnum+3
	MOVLW      main_valstring_L0+0
	MOVWF      FARG_FloatToStr_str+0
	MOVLW      hi_addr(main_valstring_L0+0)
	MOVWF      FARG_FloatToStr_str+1
	CALL       _FloatToStr+0
;LMeter.c,299 :: 		display_set_address(DISPLAY_LINE_0);
	CLRF       FARG_LMeter_display_set_address_addr+0
	CALL       LMeter_display_set_address+0
;LMeter.c,300 :: 		I2C1_Start();
	CALL       _I2C1_Start+0
;LMeter.c,301 :: 		I2C1_Wr(I2C_DISPLAY_ADDRESS | I2C_WRITE);
	MOVLW      124
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,302 :: 		I2C1_Wr(DISPLAY_DATA_REGISTER);
	MOVLW      64
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,303 :: 		I2C1_Wr('F');
	MOVLW      70
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,304 :: 		I2C1_Wr('r');
	MOVLW      114
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,305 :: 		I2C1_Wr('e');
	MOVLW      101
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,306 :: 		I2C1_Wr('q');
	MOVLW      113
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,307 :: 		I2C1_Wr(':');
	MOVLW      58
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,308 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,309 :: 		for(i=0;valstring[i]&&i<7;++i)
	CLRF       main_i_L0+0
L_main11:
	MOVLW      main_valstring_L0+0
	MOVWF      FSR0L
	MOVLW      hi_addr(main_valstring_L0+0)
	MOVWF      FSR0H
	MOVF       main_i_L0+0, 0
	ADDWF      FSR0L, 1
	MOVLW      0
	BTFSC      main_i_L0+0, 7
	MOVLW      255
	ADDWFC     FSR0H, 1
	MOVF       INDF0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main12
	MOVLW      128
	XORWF      main_i_L0+0, 0
	MOVWF      R0
	MOVLW      128
	XORLW      7
	SUBWF      R0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main12
L__main45:
;LMeter.c,311 :: 		I2C1_Wr(valstring[i]);
	MOVLW      main_valstring_L0+0
	MOVWF      FSR0L
	MOVLW      hi_addr(main_valstring_L0+0)
	MOVWF      FSR0H
	MOVF       main_i_L0+0, 0
	ADDWF      FSR0L, 1
	MOVLW      0
	BTFSC      main_i_L0+0, 7
	MOVLW      255
	ADDWFC     FSR0H, 1
	MOVF       INDF0+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,309 :: 		for(i=0;valstring[i]&&i<7;++i)
	INCF       main_i_L0+0, 1
;LMeter.c,312 :: 		}
	GOTO       L_main11
L_main12:
;LMeter.c,313 :: 		I2C1_Wr('k');
	MOVLW      107
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,314 :: 		I2C1_Wr('H');
	MOVLW      72
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,315 :: 		I2C1_Wr('z');
	MOVLW      122
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,316 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,317 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,318 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,319 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,320 :: 		I2C1_Stop();
	CALL       _I2C1_Stop+0
;LMeter.c,322 :: 		adjusted_inductance = measured_inductance - zero_calibration;
	MOVF       _zero_calibration+0, 0
	MOVWF      R4
	MOVF       _zero_calibration+1, 0
	MOVWF      R5
	MOVF       _zero_calibration+2, 0
	MOVWF      R6
	MOVF       _zero_calibration+3, 0
	MOVWF      R7
	MOVF       _measured_inductance+0, 0
	MOVWF      R0
	MOVF       _measured_inductance+1, 0
	MOVWF      R1
	MOVF       _measured_inductance+2, 0
	MOVWF      R2
	MOVF       _measured_inductance+3, 0
	MOVWF      R3
	CALL       _Sub_32x32_FP+0
	MOVF       R0, 0
	MOVWF      _adjusted_inductance+0
	MOVF       R1, 0
	MOVWF      _adjusted_inductance+1
	MOVF       R2, 0
	MOVWF      _adjusted_inductance+2
	MOVF       R3, 0
	MOVWF      _adjusted_inductance+3
;LMeter.c,323 :: 		display_set_address(DISPLAY_LINE_1);
	MOVLW      64
	MOVWF      FARG_LMeter_display_set_address_addr+0
	CALL       LMeter_display_set_address+0
;LMeter.c,324 :: 		if(abs(adjusted_inductance)<1)
	MOVF       _adjusted_inductance+0, 0
	MOVWF      R0
	MOVF       _adjusted_inductance+1, 0
	MOVWF      R1
	MOVF       _adjusted_inductance+2, 0
	MOVWF      R2
	MOVF       _adjusted_inductance+3, 0
	MOVWF      R3
	CALL       _Double2Int+0
	MOVF       R0, 0
	MOVWF      FARG_abs_a+0
	MOVF       R1, 0
	MOVWF      FARG_abs_a+1
	CALL       _abs+0
	MOVLW      128
	XORWF      R1, 0
	MOVWF      R2
	MOVLW      128
	SUBWF      R2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main52
	MOVLW      1
	SUBWF      R0, 0
L__main52:
	BTFSC      STATUS+0, 0
	GOTO       L_main16
;LMeter.c,327 :: 		FloatToStr(adjusted_inductance*1000.0, &valstring);
	MOVF       _adjusted_inductance+0, 0
	MOVWF      R0
	MOVF       _adjusted_inductance+1, 0
	MOVWF      R1
	MOVF       _adjusted_inductance+2, 0
	MOVWF      R2
	MOVF       _adjusted_inductance+3, 0
	MOVWF      R3
	MOVLW      0
	MOVWF      R4
	MOVLW      0
	MOVWF      R5
	MOVLW      122
	MOVWF      R6
	MOVLW      136
	MOVWF      R7
	CALL       _Mul_32x32_FP+0
	MOVF       R0, 0
	MOVWF      FARG_FloatToStr_fnum+0
	MOVF       R1, 0
	MOVWF      FARG_FloatToStr_fnum+1
	MOVF       R2, 0
	MOVWF      FARG_FloatToStr_fnum+2
	MOVF       R3, 0
	MOVWF      FARG_FloatToStr_fnum+3
	MOVLW      main_valstring_L0+0
	MOVWF      FARG_FloatToStr_str+0
	MOVLW      hi_addr(main_valstring_L0+0)
	MOVWF      FARG_FloatToStr_str+1
	CALL       _FloatToStr+0
;LMeter.c,328 :: 		I2C1_Start();
	CALL       _I2C1_Start+0
;LMeter.c,329 :: 		I2C1_Wr(I2C_DISPLAY_ADDRESS | I2C_WRITE);
	MOVLW      124
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,330 :: 		I2C1_Wr(DISPLAY_DATA_REGISTER);
	MOVLW      64
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,331 :: 		I2C1_Wr('I');
	MOVLW      73
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,332 :: 		I2C1_Wr('n');
	MOVLW      110
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,333 :: 		I2C1_Wr('d');
	MOVLW      100
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,334 :: 		I2C1_Wr('u');
	MOVLW      117
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,335 :: 		I2C1_Wr('c');
	MOVLW      99
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,336 :: 		I2C1_Wr(':');
	MOVLW      58
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,337 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,338 :: 		for(i=0;valstring[i]&&i<7;++i)
	CLRF       main_i_L0+0
L_main17:
	MOVLW      main_valstring_L0+0
	MOVWF      FSR0L
	MOVLW      hi_addr(main_valstring_L0+0)
	MOVWF      FSR0H
	MOVF       main_i_L0+0, 0
	ADDWF      FSR0L, 1
	MOVLW      0
	BTFSC      main_i_L0+0, 7
	MOVLW      255
	ADDWFC     FSR0H, 1
	MOVF       INDF0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main18
	MOVLW      128
	XORWF      main_i_L0+0, 0
	MOVWF      R0
	MOVLW      128
	XORLW      7
	SUBWF      R0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main18
L__main44:
;LMeter.c,340 :: 		I2C1_Wr(valstring[i]);
	MOVLW      main_valstring_L0+0
	MOVWF      FSR0L
	MOVLW      hi_addr(main_valstring_L0+0)
	MOVWF      FSR0H
	MOVF       main_i_L0+0, 0
	ADDWF      FSR0L, 1
	MOVLW      0
	BTFSC      main_i_L0+0, 7
	MOVLW      255
	ADDWFC     FSR0H, 1
	MOVF       INDF0+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,338 :: 		for(i=0;valstring[i]&&i<7;++i)
	INCF       main_i_L0+0, 1
;LMeter.c,341 :: 		}
	GOTO       L_main17
L_main18:
;LMeter.c,342 :: 		I2C1_Wr('n');
	MOVLW      110
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,343 :: 		I2C1_Wr('H');
	MOVLW      72
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,344 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,345 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,346 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,347 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,348 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,349 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,350 :: 		I2C1_Stop();
	CALL       _I2C1_Stop+0
;LMeter.c,351 :: 		}
	GOTO       L_main22
L_main16:
;LMeter.c,355 :: 		FloatToStr(adjusted_inductance, &valstring);
	MOVF       _adjusted_inductance+0, 0
	MOVWF      FARG_FloatToStr_fnum+0
	MOVF       _adjusted_inductance+1, 0
	MOVWF      FARG_FloatToStr_fnum+1
	MOVF       _adjusted_inductance+2, 0
	MOVWF      FARG_FloatToStr_fnum+2
	MOVF       _adjusted_inductance+3, 0
	MOVWF      FARG_FloatToStr_fnum+3
	MOVLW      main_valstring_L0+0
	MOVWF      FARG_FloatToStr_str+0
	MOVLW      hi_addr(main_valstring_L0+0)
	MOVWF      FARG_FloatToStr_str+1
	CALL       _FloatToStr+0
;LMeter.c,356 :: 		I2C1_Start();
	CALL       _I2C1_Start+0
;LMeter.c,357 :: 		I2C1_Wr(I2C_DISPLAY_ADDRESS | I2C_WRITE);
	MOVLW      124
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,358 :: 		I2C1_Wr(DISPLAY_DATA_REGISTER);
	MOVLW      64
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,359 :: 		I2C1_Wr('I');
	MOVLW      73
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,360 :: 		I2C1_Wr('n');
	MOVLW      110
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,361 :: 		I2C1_Wr('d');
	MOVLW      100
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,362 :: 		I2C1_Wr('u');
	MOVLW      117
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,363 :: 		I2C1_Wr('c');
	MOVLW      99
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,364 :: 		I2C1_Wr(':');
	MOVLW      58
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,365 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,366 :: 		for(i=0;valstring[i]&&i<7;++i)
	CLRF       main_i_L0+0
L_main23:
	MOVLW      main_valstring_L0+0
	MOVWF      FSR0L
	MOVLW      hi_addr(main_valstring_L0+0)
	MOVWF      FSR0H
	MOVF       main_i_L0+0, 0
	ADDWF      FSR0L, 1
	MOVLW      0
	BTFSC      main_i_L0+0, 7
	MOVLW      255
	ADDWFC     FSR0H, 1
	MOVF       INDF0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main24
	MOVLW      128
	XORWF      main_i_L0+0, 0
	MOVWF      R0
	MOVLW      128
	XORLW      7
	SUBWF      R0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main24
L__main43:
;LMeter.c,368 :: 		I2C1_Wr(valstring[i]);
	MOVLW      main_valstring_L0+0
	MOVWF      FSR0L
	MOVLW      hi_addr(main_valstring_L0+0)
	MOVWF      FSR0H
	MOVF       main_i_L0+0, 0
	ADDWF      FSR0L, 1
	MOVLW      0
	BTFSC      main_i_L0+0, 7
	MOVLW      255
	ADDWFC     FSR0H, 1
	MOVF       INDF0+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,366 :: 		for(i=0;valstring[i]&&i<7;++i)
	INCF       main_i_L0+0, 1
;LMeter.c,369 :: 		}
	GOTO       L_main23
L_main24:
;LMeter.c,370 :: 		I2C1_Wr('u');
	MOVLW      117
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,371 :: 		I2C1_Wr('H');
	MOVLW      72
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,372 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,373 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,374 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,375 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,376 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,377 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,378 :: 		I2C1_Stop();
	CALL       _I2C1_Stop+0
;LMeter.c,379 :: 		}
L_main22:
;LMeter.c,380 :: 		done = 0;
	CLRF       _done+0
;LMeter.c,381 :: 		}
L_main9:
;LMeter.c,384 :: 		if(done==2)
	MOVF       _done+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_main28
;LMeter.c,387 :: 		display_set_address(DISPLAY_LINE_0);
	CLRF       FARG_LMeter_display_set_address_addr+0
	CALL       LMeter_display_set_address+0
;LMeter.c,388 :: 		I2C1_Start();
	CALL       _I2C1_Start+0
;LMeter.c,389 :: 		I2C1_Wr(I2C_DISPLAY_ADDRESS | I2C_WRITE);
	MOVLW      124
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,390 :: 		I2C1_Wr(DISPLAY_DATA_REGISTER);
	MOVLW      64
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,391 :: 		I2C1_Wr('N');
	MOVLW      78
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,392 :: 		I2C1_Wr('o');
	MOVLW      111
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,393 :: 		I2C1_Wr('t');
	MOVLW      116
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,394 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,395 :: 		I2C1_Wr('r');
	MOVLW      114
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,396 :: 		I2C1_Wr('e');
	MOVLW      101
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,397 :: 		I2C1_Wr('s');
	MOVLW      115
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,398 :: 		I2C1_Wr('o');
	MOVLW      111
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,399 :: 		I2C1_Wr('n');
	MOVLW      110
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,400 :: 		I2C1_Wr('a');
	MOVLW      97
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,401 :: 		I2C1_Wr('t');
	MOVLW      116
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,402 :: 		I2C1_Wr('i');
	MOVLW      105
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,403 :: 		I2C1_Wr('n');
	MOVLW      110
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,404 :: 		I2C1_Wr('g');
	MOVLW      103
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,405 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,406 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,407 :: 		I2C1_Stop();
	CALL       _I2C1_Stop+0
;LMeter.c,409 :: 		display_set_address(DISPLAY_LINE_1);
	MOVLW      64
	MOVWF      FARG_LMeter_display_set_address_addr+0
	CALL       LMeter_display_set_address+0
;LMeter.c,410 :: 		if(abs(zero_calibration)<1)
	MOVF       _zero_calibration+0, 0
	MOVWF      R0
	MOVF       _zero_calibration+1, 0
	MOVWF      R1
	MOVF       _zero_calibration+2, 0
	MOVWF      R2
	MOVF       _zero_calibration+3, 0
	MOVWF      R3
	CALL       _Double2Int+0
	MOVF       R0, 0
	MOVWF      FARG_abs_a+0
	MOVF       R1, 0
	MOVWF      FARG_abs_a+1
	CALL       _abs+0
	MOVLW      128
	XORWF      R1, 0
	MOVWF      R2
	MOVLW      128
	SUBWF      R2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main53
	MOVLW      1
	SUBWF      R0, 0
L__main53:
	BTFSC      STATUS+0, 0
	GOTO       L_main29
;LMeter.c,413 :: 		FloatToStr(zero_calibration*1000.0, &valstring);
	MOVF       _zero_calibration+0, 0
	MOVWF      R0
	MOVF       _zero_calibration+1, 0
	MOVWF      R1
	MOVF       _zero_calibration+2, 0
	MOVWF      R2
	MOVF       _zero_calibration+3, 0
	MOVWF      R3
	MOVLW      0
	MOVWF      R4
	MOVLW      0
	MOVWF      R5
	MOVLW      122
	MOVWF      R6
	MOVLW      136
	MOVWF      R7
	CALL       _Mul_32x32_FP+0
	MOVF       R0, 0
	MOVWF      FARG_FloatToStr_fnum+0
	MOVF       R1, 0
	MOVWF      FARG_FloatToStr_fnum+1
	MOVF       R2, 0
	MOVWF      FARG_FloatToStr_fnum+2
	MOVF       R3, 0
	MOVWF      FARG_FloatToStr_fnum+3
	MOVLW      main_valstring_L0+0
	MOVWF      FARG_FloatToStr_str+0
	MOVLW      hi_addr(main_valstring_L0+0)
	MOVWF      FARG_FloatToStr_str+1
	CALL       _FloatToStr+0
;LMeter.c,414 :: 		I2C1_Start();
	CALL       _I2C1_Start+0
;LMeter.c,415 :: 		I2C1_Wr(I2C_DISPLAY_ADDRESS | I2C_WRITE);
	MOVLW      124
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,416 :: 		I2C1_Wr(DISPLAY_DATA_REGISTER);
	MOVLW      64
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,417 :: 		I2C1_Wr('C');
	MOVLW      67
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,418 :: 		I2C1_Wr('a');
	MOVLW      97
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,419 :: 		I2C1_Wr('l');
	MOVLW      108
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,420 :: 		I2C1_Wr('i');
	MOVLW      105
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,421 :: 		I2C1_Wr('b');
	MOVLW      98
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,422 :: 		I2C1_Wr(':');
	MOVLW      58
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,423 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,424 :: 		for(i=0;valstring[i]&&i<7;++i)
	CLRF       main_i_L0+0
L_main30:
	MOVLW      main_valstring_L0+0
	MOVWF      FSR0L
	MOVLW      hi_addr(main_valstring_L0+0)
	MOVWF      FSR0H
	MOVF       main_i_L0+0, 0
	ADDWF      FSR0L, 1
	MOVLW      0
	BTFSC      main_i_L0+0, 7
	MOVLW      255
	ADDWFC     FSR0H, 1
	MOVF       INDF0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main31
	MOVLW      128
	XORWF      main_i_L0+0, 0
	MOVWF      R0
	MOVLW      128
	XORLW      7
	SUBWF      R0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main31
L__main42:
;LMeter.c,426 :: 		I2C1_Wr(valstring[i]);
	MOVLW      main_valstring_L0+0
	MOVWF      FSR0L
	MOVLW      hi_addr(main_valstring_L0+0)
	MOVWF      FSR0H
	MOVF       main_i_L0+0, 0
	ADDWF      FSR0L, 1
	MOVLW      0
	BTFSC      main_i_L0+0, 7
	MOVLW      255
	ADDWFC     FSR0H, 1
	MOVF       INDF0+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,424 :: 		for(i=0;valstring[i]&&i<7;++i)
	INCF       main_i_L0+0, 1
;LMeter.c,427 :: 		}
	GOTO       L_main30
L_main31:
;LMeter.c,428 :: 		I2C1_Wr('n');
	MOVLW      110
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,429 :: 		I2C1_Wr('H');
	MOVLW      72
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,430 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,431 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,432 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,433 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,434 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,435 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,436 :: 		I2C1_Stop();
	CALL       _I2C1_Stop+0
;LMeter.c,437 :: 		}
	GOTO       L_main35
L_main29:
;LMeter.c,441 :: 		FloatToStr(zero_calibration, &valstring);
	MOVF       _zero_calibration+0, 0
	MOVWF      FARG_FloatToStr_fnum+0
	MOVF       _zero_calibration+1, 0
	MOVWF      FARG_FloatToStr_fnum+1
	MOVF       _zero_calibration+2, 0
	MOVWF      FARG_FloatToStr_fnum+2
	MOVF       _zero_calibration+3, 0
	MOVWF      FARG_FloatToStr_fnum+3
	MOVLW      main_valstring_L0+0
	MOVWF      FARG_FloatToStr_str+0
	MOVLW      hi_addr(main_valstring_L0+0)
	MOVWF      FARG_FloatToStr_str+1
	CALL       _FloatToStr+0
;LMeter.c,442 :: 		I2C1_Start();
	CALL       _I2C1_Start+0
;LMeter.c,443 :: 		I2C1_Wr(I2C_DISPLAY_ADDRESS | I2C_WRITE);
	MOVLW      124
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,444 :: 		I2C1_Wr(DISPLAY_DATA_REGISTER);
	MOVLW      64
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,445 :: 		I2C1_Wr('C');
	MOVLW      67
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,446 :: 		I2C1_Wr('a');
	MOVLW      97
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,447 :: 		I2C1_Wr('l');
	MOVLW      108
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,448 :: 		I2C1_Wr('i');
	MOVLW      105
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,449 :: 		I2C1_Wr('b');
	MOVLW      98
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,450 :: 		I2C1_Wr(':');
	MOVLW      58
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,451 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,452 :: 		for(i=0;valstring[i]&&i<7;++i)
	CLRF       main_i_L0+0
L_main36:
	MOVLW      main_valstring_L0+0
	MOVWF      FSR0L
	MOVLW      hi_addr(main_valstring_L0+0)
	MOVWF      FSR0H
	MOVF       main_i_L0+0, 0
	ADDWF      FSR0L, 1
	MOVLW      0
	BTFSC      main_i_L0+0, 7
	MOVLW      255
	ADDWFC     FSR0H, 1
	MOVF       INDF0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main37
	MOVLW      128
	XORWF      main_i_L0+0, 0
	MOVWF      R0
	MOVLW      128
	XORLW      7
	SUBWF      R0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main37
L__main41:
;LMeter.c,454 :: 		I2C1_Wr(valstring[i]);
	MOVLW      main_valstring_L0+0
	MOVWF      FSR0L
	MOVLW      hi_addr(main_valstring_L0+0)
	MOVWF      FSR0H
	MOVF       main_i_L0+0, 0
	ADDWF      FSR0L, 1
	MOVLW      0
	BTFSC      main_i_L0+0, 7
	MOVLW      255
	ADDWFC     FSR0H, 1
	MOVF       INDF0+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,452 :: 		for(i=0;valstring[i]&&i<7;++i)
	INCF       main_i_L0+0, 1
;LMeter.c,455 :: 		}
	GOTO       L_main36
L_main37:
;LMeter.c,456 :: 		I2C1_Wr('u');
	MOVLW      117
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,457 :: 		I2C1_Wr('H');
	MOVLW      72
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,458 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,459 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,460 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,461 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,462 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,463 :: 		I2C1_Wr(' ');
	MOVLW      32
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;LMeter.c,464 :: 		I2C1_Stop();
	CALL       _I2C1_Stop+0
;LMeter.c,465 :: 		}
L_main35:
;LMeter.c,466 :: 		done = 0;
	CLRF       _done+0
;LMeter.c,467 :: 		}
L_main28:
;LMeter.c,468 :: 		}
	GOTO       L_main7
;LMeter.c,469 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
