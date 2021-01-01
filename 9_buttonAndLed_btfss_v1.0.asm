;   program :	PICTEST1.ASM
;    date :	OCT, 2020
;  written by :	ENES MERCAN
;  scenerio :	button connected to RA0... When you push it, an LED turns off
;		connected to RB0. When you push the button connected to RA4,
;		it turns on the LED.
;   purpose :	to learn the using the BTFSS and BTFSC commands
;
;----------------------------------------------------------------------
; indicate what pic we're using to the complier    
    
    LIST P  = 16F628A
    INCLUDE "P16F628A.INC"

;----------------------------------------------------------------------
;configuration bits
	
    __CONFIG	_XT_OSC	& _WDT_OFF & _PWRTE_ON & _MCLRE_ON & _BODEN_OFF & 
    _LVP_OFF & _DATA_CP_OFF & _CP_OFF
 
    ;_XT_OSC	--> external crystal oscillator
    ;_WDT_OFF	--> watchdog timer off
    ;_PWRTE_ON	--> power up timer is on (will wait 72ms when powered)
    ;_MCLRE_ON	--> external reset is active
    ;_BODEN_OFF --> low voltage protection is off (diff to handle for beginners)
    ;_LVP_OFF	--> low power programming is disabled
    ; _DATA_CP_OFF  --> no eeprom data protection (it's readable)
    ;_CP_OFF	--> no rom code protection (anyone can read)
    
    
;----------------------------------------------------------------------
; starts the program from this address
	
    ORG	H'0000'

;----------------------------------------------------------------------
; This is basically SETUP block of our program
	
    CLRF    PORTB
    BANKSEL TRISB
    CLRF    TRISB
    MOVLW   b'00010001'
    MOVWF   TRISA
    BANKSEL CMCON
    MOVLW   h'07'
    MOVWF   CMCON
    BANKSEL PORTA
    
;----------------------------------------------------------------------
; The program execution block (main program flow block)
	
START
    
    BTFSS   PORTA, 0
    BCF	    PORTB, 0
    BTFSC   PORTA, 4
    GOTO    START
    BSF	    PORTB, 0
    GOTO    START
	
;----------------------------------------------------------------------
; Ending the program
	
LOOP
    
    GOTO LOOP
    END
	
;----------------------------------------------------------------------
 