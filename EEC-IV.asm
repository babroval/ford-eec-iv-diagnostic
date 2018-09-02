  ;
  ; EEC-IV.asm
  ;
  ; Created: 11-Sept-2012 9:00:11 PM
  ; Author : Maksim Babrou
  ;


.include "m128def.inc"
.org 0            ;Set start address
rjmp USART0_Init     ;go to label USART0_Init
.org 0x24       ;Set an Interrupt address to USART0, Rx(Receive) Complete
rjmp UART0_CMD ;go to label Receive_Complete 


USART0_Init:
  ; Set baud rate
ldi r16,0 ; 50325 fore 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR0H,r16 
ldi r16,19 ; 50325 fore 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts 0x29,r16  ;UBRR0L
  ; Enable receiver and transmitter
ldi r16,(1<<RXCIE0)|(1<<RXEN0)|(1<<TXEN0)
sts 0x2A,r16  ;UCSR0B
  ; Set frame format: 8data, 2stop bit
ldi r16, (1<<USBS0)|(1<<UCSZ00)|(1<<UCSZ01)
sts UCSR0C,r16

;USART1_Init:
  ; Enable receiver and transmitter
ldi r16,(1<<RXEN1)|(1<<TXEN1)
sts UCSR1B,r16
  ; Set frame format: 8data, 2stop bit
ldi r16, (1<<USBS1)|(1<<UCSZ10)|(1<<UCSZ11)
sts UCSR1C,r16


sbi DDRD,4  ;switch to output

USART_Start:

cbi PORTD,4 ;switch to Receive

   ; Flush Recever
ldi r16,(0<<RXEN1)
sts UCSR1B,r16
ldi r16,(1<<RXEN1)|(1<<TXEN1)
sts UCSR1B,r16

sei            ;Global interrupt permission


rjmp Idle


USART_Go:

cbi PORTD,4 ;Switch to receive

 ; Flush Recever
ldi r16,(0<<RXEN1)
sts UCSR1B,r16
ldi r16,(1<<RXEN1)|(1<<TXEN1)
sts UCSR1B,r16


ldi r16, 255      ;Load value to the register r16
ldi r17, 255      ;Load value to the register r17
ldi r18, 100       ;Load value to the register r18
delayMain:             ;Delay cycle
subi r16, 1       ;Subtract 1 from register r16
sbci r17, 0       ;Subtract with transfer from the register r17
sbci r18, 0       ;ubtract with transfer from the register r18
brcc delayMain       ;If there was no transfer back to the label delay

  ; Set baud rate
ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

 ; Flush Recever
ldi r16,(0<<RXEN1)
sts UCSR1B,r16
ldi r16,(1<<RXEN1)|(1<<TXEN1)
sts UCSR1B,r16

ldi r16, 255      
ldi r17, 100      
d22:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc d22





ldi r16, 255      ;Load value to the register r16
ldi r17, 255      ;Load value to the register r17
ldi r18, 50       ;Load value to the register r18
d:             ;Delay cycle

   ; Wait for data to be received
lds r19,UCSR1A
sbrs r19,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp dd
  ; Get and return received data from buffer
lds r19,UDR1 

rjmp USART_24

dd:
subi r16, 1       ;Subtract 1 from register r16
sbci r17, 0       ;Subtract with transfer from the register r17
sbci r18, 0       ;Subtract with transfer from the register r18
brcc d       ;If there was no transfer back to the label delay






sbi PORTD,4  ;Switch to transfer

  ; Put data (r16) into buffer, sends the data
ldi r16,0 ;send $00
sts UDR1,r16

ldi r16, 255     
ldi r17, 100     
d0:             ;Delay cycle
subi r16, 1     
sbci r17, 0     
brcc d0        

ldi r16,0 ;send $00
sts UDR1,r16

ldi r16, 255      
ldi r17, 100      
d1:             ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc d1        

ldi r16,0 ;send $00
sts UDR1,r16

ldi r16, 255      
ldi r17, 100      
d2:             ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc d2        

ldi r16,0 ;send $00
sts UDR1,r16

ldi r16, 255      
ldi r17, 100      
d3:             ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc d3        

ldi r16,0 ;send $00
sts UDR1,r16

ldi r16, 255      
ldi r17, 100     
d4:             ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc d4        

ldi r16,0 ;send $00
sts UDR1,r16

ldi r16, 255      
ldi r17, 100      
d5:             ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc d5        

ldi r16,0 ;send $00
sts UDR1,r16

ldi r16, 255      
ldi r17, 100      
d6:             ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc d6        

ldi r16,0 ;send $00
sts UDR1,r16

ldi r16, 255      
ldi r17, 100      
d7:             ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc d7       

ldi r16,0 ;send $00
sts UDR1,r16

ldi r16, 255      
ldi r17, 100      
d8:             ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc d8        

ldi r16,0 ;send $00
sts UDR1,r16

ldi r16, 255      
ldi r17, 100      
d9:             ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc d9        

ldi r16,0 ;send $00
sts UDR1,r16

ldi r16, 255
ldi r17, 100     
d10:            ;Delay cycle
subi r16, 1      
sbci r17, 0       
brcc d10        

ldi r16,0 ;send $00
sts UDR1,r16

ldi r16, 255      
ldi r17, 100      
d11:            ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc d11        

ldi r16,1 ;send $01
sts UDR1,r16

ldi r16, 255      
ldi r17, 100      
d12:            ;Delay cycle
subi r16, 1      
sbci r17, 0       
brcc d12        

ldi r16,4 ;send $04
sts UDR1,r16

ldi r16, 255      
ldi r17, 100      
d14:            ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc d14        

ldi r16,0 ;send $00
sts UDR1,r16

ldi r16, 255      
ldi r17, 100      
d15:            ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc d15        

ldi r16,0 ;send $00
sts UDR1,r16

ldi r16, 255      
ldi r17, 100      
d17:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc d17       

ldi r16,0 ;send $00
sts UDR1,r16

ldi r16, 255     
ldi r17, 100     
d18:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc d18       

ldi r16,5 ;send $05
sts UDR1,r16

ldi r16, 255      
ldi r17, 100      
d19:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc d19

cbi PORTD,4 ;Switch to receive 

 ; Flush Recever
ldi r16,(0<<RXEN1)
sts UCSR1B,r16
ldi r16,(1<<RXEN1)|(1<<TXEN1)
sts UCSR1B,r16

ldi r16,1
cpse r16,r26 ;Skip the next line if $01
rjmp  USART_9600
rjmp  USART_19200


USART_9600:

; Set baud rate
ldi r16,0 ; 9600 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,104 ; 9600 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16
 
 ; Flush Recever
ldi r16,(0<<RXEN1)
sts UCSR1B,r16
ldi r16,(1<<RXEN1)|(1<<TXEN1)
sts UCSR1B,r16

ldi r16, 255      
ldi r17, 255      
d20:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc d20  






ldi r16, 255      ;Load value to the register r16
ldi r17, 255      ;Load value to the register r17
ldi r18, 20       ;Load value to the register r18
dz:             ;Delay cycle

   ; Wait for data to be received
lds r19,UCSR1A
sbrs r19,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp dz1
  ; Get and return received data from buffer
lds r19,UDR1
 ; Flush Recever
ldi r16,(0<<RXEN1)
sts UCSR1B,r16
ldi r16,(1<<RXEN1)|(1<<TXEN1)
sts UCSR1B,r16 

rjmp A96

dz1:
subi r16, 1       ;Subtract 1 from register r16
sbci r17, 0       ;Subtract with transfer from the register r17
sbci r18, 0       ;Subtract with transfer from the register r18
brcc dz       ;If there was no transfer back to the label delay

ldi r17,25
ldi r18,161
sts 0x2C,r17   ;send usart0 UDR0 No connection
sts 0x2C,r18   ;send usart0 UDR0 No connection

rjmp Idle





A96:

ldi r20,3; $03

S_CA01:
  ; Wait for data to be received
lds r19,UCSR1A
sbrs r19,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp S_CA01
  ; Get and return received data from buffer
lds r19,UDR1

lsl r19
lsl r19
lsl r19
lsl r19
swap r19

cpse r20,r19 ;Skip the next line if $03
rjmp S_CA01

USART_96:

ldi r19,0 ; $00

AR_CA0:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp AR_CA0
  ; Get and return received data from buffer
lds r17,UDR1 

AR_CA02:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp AR_CA02
  ; Get and return received data from buffer
lds r18,UDR1 

cpse r19,r17 ;Skip the next line if $00
rjmp AR_CA0
cpse r19,r18 ;Skip the next line if $00
rjmp AR_CA0


AR_CA03:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp AR_CA03
  ; Get and return received data from buffer
lds r17,UDR1 

AR_CA04:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp AR_CA04
  ; Get and return received data from buffer
lds r17,UDR1

lsl r17
lsl r17
lsl r17
lsl r17
swap r17

cpse r19,r17 ;Skip the next line if $00
rjmp AR_CA0

ldi r16, 255      
ldi r17, 8  
de90:            ;Delay cycle
subi r16, 1      
sbci r17, 0       
brcc de90       

sbi PORTD,4 ;Switch to transfer

  ; Put data (r16) into buffer, sends the data
ldi r19,1   ;send $01
sts UDR1,r19

ldi r16, 255      
ldi r17, 15       
del90:            ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc del90        

; Set baud rate
ldi r16,0 ; 38400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,25 ; 38400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16
   ; Put data (r16) into buffer, sends the data

ldi r16, 100     
dela90:           ;Delay cycle
sbci r16, 1      
brcc dela90 

ldi r16,0 ; 9600 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,104 ; 9600 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r19,176 ;send $B0
sts UDR1,r19

ldi r16, 255      
ldi r17, 15    
delay90:          ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc delay90       

cbi PORTD,4 ;Switch to receive
 ; Flush Recever
ldi r16,(0<<RXEN1)
sts UCSR1B,r16
ldi r16,(1<<RXEN1)|(1<<TXEN1)
sts UCSR1B,r16


AR_CB1:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp AR_CB1
  ; Get and return received data from buffer
lds r17,UDR1 

AR_CB02:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp AR_CB02
  ; Get and return received data from buffer
lds r17,UDR1

AR_CB03:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp AR_CB03
  ; Get and return received data from buffer
lds r17,UDR1

AR_CB04:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp AR_CB04
  ; Get and return received data from buffer
lds r17,UDR1

ldi r16, 255     
ldi r17, 8  
de91:            ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc de91      

sbi PORTD,4 ;Switch to transfer

  ; Put data (r16) into buffer, sends the data
ldi r19,255   ;send $FF
sts UDR1,r19

ldi r16, 255     
ldi r17, 15       
del91:           ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc del91       

; Set baud rate
ldi r16,0 ; 38400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,25 ; 38400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16
   ; Put data (r16) into buffer, sends the data

ldi r16, 100     
dela91:           ;Delay cycle
sbci r16, 1      
brcc dela91        

ldi r16,0 ; 9600 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,104 ; 9600 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

  ; Put data (r16) into buffer, sends the data
ldi r19,95  ;send $5F
sts UDR1,r19
 
ldi r16, 255     
ldi r17, 15    
delay91:          ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc delay91        

cbi PORTD,4 ;Switch to receive
 ; Flush Recever
ldi r16,(0<<RXEN1)
sts UCSR1B,r16
ldi r16,(1<<RXEN1)|(1<<TXEN1)
sts UCSR1B,r16


AR_C82:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp AR_C82
  ; Get and return received data from buffer
lds r17,UDR1 

AR_C822:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp AR_C822
  ; Get and return received data from buffer
lds r17,UDR1

AR_C823:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp AR_C823
  ; Get and return received data from buffer
lds r17,UDR1

AR_C824:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp AR_C824
  ; Get and return received data from buffer
lds r17,UDR1

ldi r16, 255     
ldi r17, 8  
de92:            ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc de92      

sbi PORTD,4 ;Switch to transfer

  ; Put data (r16) into buffer, sends the data
ldi r19,129  ;send $81
sts UDR1,r19

ldi r16, 255      
ldi r17, 15       
del92:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc del92        

; Set baud rate
ldi r16,0 ; 38400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,25 ; 38400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16
   ; Put data (r16) into buffer, sends the data

ldi r16, 100     
dela92:           ;Delay cycle
sbci r16, 1      
brcc dela92   

ldi r16,0 ; 9600 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,104 ; 9600 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

  ; Put data (r16) into buffer, sends the data
ldi r19,116   ;send $74
sts UDR1,r19

ldi r16, 255      
ldi r17, 15    
delay92:          ;Delay cycle
subi r16, 1      
sbci r17, 0       
brcc delay92       

cbi PORTD,4 ;Switch to receive
 ; Flush Recever
ldi r16,(0<<RXEN1)
sts UCSR1B,r16
ldi r16,(1<<RXEN1)|(1<<TXEN1)
sts UCSR1B,r16


AR_C93:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp AR_C93
  ; Get and return received data from buffer
lds r17,UDR1 

AR_C932:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp AR_C932
  ; Get and return received data from buffer
lds r17,UDR1 

AR_C933:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp AR_C933
  ; Get and return received data from buffer
lds r17,UDR1 

AR_C934:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp AR_C934
  ; Get and return received data from buffer
lds r17,UDR1

ldi r16, 255      
ldi r17, 8  
de93:            ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc de93      

sbi PORTD,4 ;Switch to transfer

  ; Put data (r16) into buffer, sends the data
ldi r19,0   ;send $00
sts UDR1,r19

ldi r16, 255     
ldi r17, 15      
del93:           ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc del93        

; Set baud rate
ldi r16,0 ; 38400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,25 ; 38400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16
   ; Put data (r16) into buffer, sends the data

ldi r16, 100     
dela93:           ;Delay cycle
sbci r16, 1      
brcc dela93   

ldi r16,0 ; 9600 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,104 ; 9600 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

  ; Put data (r16) into buffer, sends the data
ldi r19,160   ;send $A0
sts UDR1,r19

ldi r16, 255     
ldi r17, 15   
delay93:           ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc delay93        

cbi PORTD,4 ;Switch to receive

; Set baud rate
ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

 ; Flush Recever
ldi r16,(0<<RXEN1)
sts UCSR1B,r16
ldi r16,(1<<RXEN1)|(1<<TXEN1)
sts UCSR1B,r16

rjmp USART_24



















USART_19200:

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

  ; Flush Recever
ldi r16,(0<<RXEN1)
sts UCSR1B,r16
ldi r16,(1<<RXEN1)|(1<<TXEN1)
sts UCSR1B,r16

ldi r16, 255      
ldi r17, 255      
d21:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc d21






ldi r16, 255      ;Load value to the register r16
ldi r17, 255      ;Load value to the register r17
ldi r18, 10       ;Load value to the register r18
dx:             ;Delay cycle

   ; Wait for data to be received
lds r19,UCSR1A
sbrs r19,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp dx1
  ; Get and return received data from buffer
lds r19,UDR1

 ; Flush Recever
ldi r16,(0<<RXEN1)
sts UCSR1B,r16
ldi r16,(1<<RXEN1)|(1<<TXEN1)
sts UCSR1B,r16 

rjmp A92

dx1:
subi r16, 1       ;Subtract 1 from register r16
sbci r17, 0       ;Subtract with transfer from the register r17
sbci r18, 0       ;Subtract with transfer from the register r18
brcc dx       ;If there was no transfer back to the label delay

ldi r17,25
ldi r18,161
sts 0x2C,r17   ;send usart0 UDR0 No connection
sts 0x2C,r18   ;send usart0 UDR0 No connection

rjmp Idle






A92:

ldi r20,3; $03

S_CA02:
  ; Wait for data to be received
lds r19,UCSR1A
sbrs r19,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp S_CA02
  ; Get and return received data from buffer
lds r19,UDR1

lsl r19
lsl r19
lsl r19
lsl r19
swap r19

cpse r20,r19 ;Skip the next line if $03
rjmp S_CA02

USART_19:


ldi r19,0 ; $00

SAR_CA0:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp SAR_CA0
  ; Get and return received data from buffer
lds r17,UDR1 

SAR_CA02:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp SAR_CA02
  ; Get and return received data from buffer
lds r18,UDR1 

cpse r19,r17 ;Skip the next line if $00
rjmp SAR_CA0
cpse r19,r18 ;Skip the next line if $00
rjmp SAR_CA0


SAR_CA03:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp SAR_CA03
  ; Get and return received data from buffer
lds r17,UDR1 

SAR_CA04:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp SAR_CA04
  ; Get and return received data from buffer
lds r17,UDR1

lsl r17
lsl r17
lsl r17
lsl r17
swap r17

cpse r19,r17 ;Skip the next line if $00
rjmp SAR_CA0

ldi r16, 255      
ldi r17, 4  
de0:            ;Delay cycle
subi r16, 1      
sbci r17, 0       
brcc de0       

sbi PORTD,4 ;Switch to transfer

  ; Put data (r16) into buffer, sends the data
ldi r19,1   ;send $01
sts UDR1,r19

ldi r16, 255      
ldi r17, 7       
del0:            ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc del0        

; Set baud rate
ldi r16,0 ; 38400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,25 ; 38400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16
   ; Put data (r16) into buffer, sends the data

ldi r16, 31     
dela0:           ;Delay cycle
sbci r16, 1      
brcc dela0       

ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r19,176 ;send $B0
sts UDR1,r19

ldi r16, 255      
ldi r17, 7    
delay0:          ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc delay0       

cbi PORTD,4 ;Switch to receive
   ; Flush Recever
ldi r16,(0<<RXEN1)
sts UCSR1B,r16
ldi r16,(1<<RXEN1)|(1<<TXEN1)
sts UCSR1B,r16


SAR_CB1:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp SAR_CB1
  ; Get and return received data from buffer
lds r17,UDR1 

SAR_CB02:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp SAR_CB02
  ; Get and return received data from buffer
lds r17,UDR1

SAR_CB03:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp SAR_CB03
  ; Get and return received data from buffer
lds r17,UDR1

SAR_CB04:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp SAR_CB04
  ; Get and return received data from buffer
lds r17,UDR1

ldi r16, 255     
ldi r17, 4  
de1:            ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc de1      

sbi PORTD,4 ;Switch to transfer

  ; Put data (r16) into buffer, sends the data
ldi r19,255   ;send $FF
sts UDR1,r19

ldi r16, 255     
ldi r17, 7       
del1:           ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc del1       

; Set baud rate
ldi r16,0 ; 38400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,25 ; 38400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16
   ; Put data (r16) into buffer, sends the data

ldi r16, 31     
dela1:           ;Delay cycle
sbci r16, 1      
brcc dela1       

ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

  ; Put data (r16) into buffer, sends the data
ldi r19,95  ;send $5F
sts UDR1,r19
 
ldi r16, 255     
ldi r17, 7    
delay1:          ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc delay1        

cbi PORTD,4 ;Switch to receive
   ; Flush Recever
ldi r16,(0<<RXEN1)
sts UCSR1B,r16
ldi r16,(1<<RXEN1)|(1<<TXEN1)
sts UCSR1B,r16


SAR_C82:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp SAR_C82
  ; Get and return received data from buffer
lds r17,UDR1 

SAR_C822:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp SAR_C822
  ; Get and return received data from buffer
lds r17,UDR1

SAR_C823:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp SAR_C823
  ; Get and return received data from buffer
lds r17,UDR1

SAR_C824:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp SAR_C824
  ; Get and return received data from buffer
lds r17,UDR1

ldi r16, 255     
ldi r17, 4  
de2:            ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc de2      

sbi PORTD,4 ;Switch to transfer

  ; Put data (r16) into buffer, sends the data
ldi r19,129  ;send $81
sts UDR1,r19

ldi r16, 255      
ldi r17, 7       
del2:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc del2        

; Set baud rate
ldi r16,0 ; 38400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,25 ; 38400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16
   ; Put data (r16) into buffer, sends the data

ldi r16, 31     
dela2:           ;Delay cycle
sbci r16, 1      
brcc dela2       

ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

  ; Put data (r16) into buffer, sends the data
ldi r19,116   ;send $74
sts UDR1,r19

ldi r16, 255      
ldi r17, 7    
delay2:          ;Delay cycle
subi r16, 1      
sbci r17, 0       
brcc delay2       

cbi PORTD,4 ;Switch to receive
   ; Flush Recever
ldi r16,(0<<RXEN1)
sts UCSR1B,r16
ldi r16,(1<<RXEN1)|(1<<TXEN1)
sts UCSR1B,r16


SAR_C93:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp SAR_C93
  ; Get and return received data from buffer
lds r17,UDR1 

SAR_C932:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp SAR_C932
  ; Get and return received data from buffer
lds r17,UDR1 

SAR_C933:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp SAR_C933
  ; Get and return received data from buffer
lds r17,UDR1 

SAR_C934:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp SAR_C934
  ; Get and return received data from buffer
lds r17,UDR1

ldi r16, 255      
ldi r17, 4  
de3:            ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc de3      

sbi PORTD,4 ;Switch to transfer

  ; Put data (r16) into buffer, sends the data
ldi r19,0   ;send $00
sts UDR1,r19

ldi r16, 255     
ldi r17, 7      
del3:           ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc del3        

; Set baud rate
ldi r16,0 ; 38400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,25 ; 38400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16
   ; Put data (r16) into buffer, sends the data

ldi r16, 31    
dela3:          ;Delay cycle
sbci r16, 1       
brcc dela3       

ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

  ; Put data (r16) into buffer, sends the data
ldi r19,160   ;send $A0
sts UDR1,r19

ldi r16, 255     
ldi r17, 7   
delay3:           ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc delay3        

cbi PORTD,4 ;Switch to receive
 ; Set baud rate
ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

  ; Flush Recever
ldi r16,(0<<RXEN1)
sts UCSR1B,r16
ldi r16,(1<<RXEN1)|(1<<TXEN1)
sts UCSR1B,r16

rjmp USART_24














USART_24:

ldi r18,3 ; $03

ldi r16, 255      
ldi r17, 255      
d24:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc d24

R_CA04:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp R_CA04
  ; Get and return received data from buffer
lds r17,UDR1

lsl r17
lsl r17
lsl r17
lsl r17
swap r17

cpse r18,r17 ;Skip the next line if $03
rjmp R_CA04



























ldi r18,1 ; $01
cpse r18,r21 ;Skip the next line if $01
rjmp USART_CRun
ldi r22,38  ; $26
ldi r23,164   ; $A4
ldi r25,1   ; $01
rjmp USART_C

USART_CRun:
ldi r18,2 ; $02
cpse r18,r21 ;Skip the next line if $02
rjmp USART_Data
ldi r22,37  ; $25
ldi r23,148   ; $94
ldi r25,1   ; $01
rjmp USART_C

USART_Data:
ldi r18,3 ; $03
cpse r18,r21 ;Skip the next line if $03
rjmp Idle
ldi r22,65  ; $41
ldi r23,150   ; $96
ldi r25,1   ; $01
rjmp USART_C



Idle:

ldi r18,4 ; $04
cpse r18,r21 ;Skip the next line if $04
rjmp USART_Err0
ldi r26,1 ; $01

ldi r18,5 ; $05
cpse r18,r21 ;Skip the next line if $05
rjmp USART_Err0
ldi r26,1 ; $00

USART_Err0:
ldi r18,1 ; $01
cpse r18,r21 ;Skip the next line if $01
rjmp USART_CRun0
rjmp USART_Go

USART_CRun0:
ldi r18,2 ; $02
cpse r18,r21 ;Skip the next line if $02
rjmp USART_Data0
rjmp USART_Go

USART_Data0:
ldi r18,3 ; $03
cpse r18,r21 ;Skip the next line if $03
rjmp Idle
rjmp USART_Go

















































USART_C:

ldi r19,0 ; $00

USAR_CA0:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_CA0
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_CA02:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_CA02
  ; Get and return received data from buffer
lds r18,UDR1 

cpse r19,r17 ;Skip the next line if $00
rjmp USAR_CA0
cpse r19,r18 ;Skip the next line if $00
rjmp USAR_CA0


USAR_CA03:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_CA03
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_CA04:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_CA04
  ; Get and return received data from buffer
lds r17,UDR1

lsl r17
lsl r17
lsl r17
lsl r17
swap r17

cpse r19,r17 ;Skip the next line if $00
rjmp USAR_CA0

ldi r18,1 ; $01
cpse r18,r25 ;Skip the next line if $01
rjmp USART_CR1A0

ldi r16, 255     
ldi r17, 26   
C1A0:             ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C1A0       

sbi PORTD,4 ;Switch to transfer

  ; Put data (r16) into buffer, sends the data
ldi r19,1   ;send $01
sts UDR1,r19

ldi r16, 255     
ldi r17, 60     
C2A0:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C2A0       

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255      
ldi r17, 3      
C3A0:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C3A0     

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

   ; Put data (r16) into buffer, sends the data
ldi r19,176 ;send $B0
sts UDR1,r19

ldi r16, 255      
ldi r17, 60    
C4A0:           ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc C4A0

cbi PORTD,4 ;Switch to receive
   ; Flush Recever
ldi r16,(0<<RXEN1)
sts UCSR1B,r16
ldi r16,(1<<RXEN1)|(1<<TXEN1)
sts UCSR1B,r16


ldi r18,3  ; $03
cpse r18,r21 ;Skip the next line if $03
rjmp USART_CR1A0
rjmp CB1
;----------------------------------------------------------------------
;----------------------------------------------------------------------
USART_CR1A0:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR1A0
  ; Get and return received data from buffer
lds r17,UDR1

USART_CR11A0:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR11A0
  ; Get and return received data from buffer
lds r18,UDR1

ldi r19,0 ;$00

cpse r19,r17 ;Skip the next line if $00
rjmp USART_1or2sA0
rjmp USAR_CB03
USART_1or2sA0:
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

ldi r25,0  ; $00

USART_CR0A0:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR0A0
  ; Get and return received data from buffer
lds r17,UDR1

USART_CR00A0:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR00A0
  ; Get and return received data from buffer
lds r18,UDR1 

cpse r19,r17 ;Skip the next line if $00
rjmp USART_1or0sA0
rjmp USAR_CB03
USART_1or0sA0:
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0
rjmp CB1



















CB1:


USAR_CB1:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_CB1
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_CB02:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_CB02
  ; Get and return received data from buffer
lds r17,UDR1

USAR_CB03:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_CB03
  ; Get and return received data from buffer
lds r17,UDR1

USAR_CB04:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_CB04
  ; Get and return received data from buffer
lds r17,UDR1

ldi r18,1 ; $01
cpse r18,r25 ;Skip the next line if $01
rjmp USART_CR1B1

ldi r16, 255     
ldi r17, 26    
C1B1:             ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C1B1       

sbi PORTD,4 ;Switch to transfer

  ; Put data (r16) into buffer, sends the data
ldi r19,255   ;send $FF
sts UDR1,r19

ldi r16, 255     
ldi r17,  60   
C2B1:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C2B1       

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255     
ldi r17, 3     
C3B1:            ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc C3B1       

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

  ; Put data (r16) into buffer, sends the data
ldi r19,95  ;send $5F
sts UDR1,r19

ldi r16, 255   
ldi r17, 65     
C4B1:           ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C4B1

cbi PORTD,4 ;Switch to receive
   ; Flush Recever
ldi r16,(0<<RXEN1)
sts UCSR1B,r16
ldi r16,(1<<RXEN1)|(1<<TXEN1)
sts UCSR1B,r16


ldi r18,3  ; $03
cpse r18,r21 ;Skip the next line if $03
rjmp USART_CR1B1
rjmp C82
;----------------------------------------------------------------------
;----------------------------------------------------------------------
USART_CR1B1:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR1B1
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR11B1:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR11B1
  ; Get and return received data from buffer
lds r18,UDR1 

ldi r19,0 ;$00

cpse r19,r17 ;Skip the next line if $00
rjmp USART_1or2sB1
rjmp USAR_C823
USART_1or2sB1:
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

USART_CR0B1:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR0B1
  ; Get and return received data from buffer
lds r17,UDR1

USART_CR00B1:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR00B1
  ; Get and return received data from buffer
lds r18,UDR1 

cpse r19,r17 ;Skip the next line if $00
rjmp USART_1or0sB1
rjmp USAR_C823
USART_1or0sB1:
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0
rjmp C82



















C82:


USAR_C82:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C82
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_C822:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C822
  ; Get and return received data from buffer
lds r17,UDR1

USAR_C823:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C823
  ; Get and return received data from buffer
lds r17,UDR1

USAR_C824:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C824
  ; Get and return received data from buffer
lds r17,UDR1

ldi r18,1 ; $01
cpse r18,r25 ;Skip the next line if $01
rjmp USART_CR182

ldi r16, 255     
ldi r17, 26    
C182:             ;Delay cycle
subi r16, 1      
sbci r17, 0       
brcc C182      

sbi PORTD,4 ;Switch to transfer

  ; Put data (r16) into buffer, sends the data
sts UDR1,r22

ldi r16, 255
ldi r17,  60 
C282:             ;Delay cycle
subi r16, 1    
sbci r17, 0    
brcc C282    

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255   
ldi r17, 3    
C382:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C382     

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

  ; Put data (r16) into buffer, sends the data
sts UDR1,r23

ldi r16, 255    
ldi r17, 60
C482:          ;Delay cycle
subi r16, 1     
sbci r17, 0      
brcc C482

cbi PORTD,4 ;Switch to receive
   ; Flush Recever
ldi r16,(0<<RXEN1)
sts UCSR1B,r16
ldi r16,(1<<RXEN1)|(1<<TXEN1)
sts UCSR1B,r16


ldi r18,3  ; $03
cpse r18,r21 ;Skip the next line if $03
rjmp USART_CR182
rjmp C93
;----------------------------------------------------------------------
;----------------------------------------------------------------------
USART_CR182:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR182
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR1182:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR1182
  ; Get and return received data from buffer
lds r18,UDR1

ldi r19,0 ;$00

cpse r19,r17 ;Skip the next line if $00
rjmp USART_1or2s82
rjmp USAR_C933
USART_1or2s82:
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

USART_CR082:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR082
  ; Get and return received data from buffer
lds r17,UDR1

USART_CR0082:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR0082
  ; Get and return received data from buffer
lds r18,UDR1 

cpse r19,r17 ;Skip the next line if $00
rjmp USART_1or0s82
rjmp USAR_C933
USART_1or0s82:
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0
rjmp C93














UART0_CMD:
rjmp UART00_CMD

USART00_Start:
rjmp USART_Start














C93:


USAR_C93:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C93
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_C932:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C932
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_C933:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C933
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_C934:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C934
  ; Get and return received data from buffer
lds r17,UDR1

ldi r18,1 ; $01
cpse r18,r25 ;Skip the next line if $01
rjmp USART_CR193

ldi r16, 255     
ldi r17, 26    
C193:             ;Delay cycle
subi r16, 1      
sbci r17, 0       
brcc C193      

sbi PORTD,4 ;Switch to transfer

  ; Put data (r16) into buffer, sends the data
ldi r19,0  ;send $00
sts UDR1,r19

ldi r16, 255
ldi r17,  60 
C293:             ;Delay cycle
subi r16, 1    
sbci r17, 0    
brcc C293    

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255   
ldi r17, 3    
C393:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C393     

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

  ; Put data (r16) into buffer, sends the data
ldi r19,160   ;send $A0
sts UDR1,r19

ldi r16, 255    
ldi r17, 60    
C493:          ;Delay cycle
subi r16, 1     
sbci r17, 0      
brcc C493

cbi PORTD,4 ;Switch to receive
   ; Flush Recever
ldi r16,(0<<RXEN1)
sts UCSR1B,r16
ldi r16,(1<<RXEN1)|(1<<TXEN1)
sts UCSR1B,r16


ldi r18,3  ; $03
cpse r18,r21 ;Skip the next line if $03
rjmp USART_CR193
rjmp USART_Dt93

USART_Dt93:
ldi r18,65 ; $41
cpse r18,r22 ;Skip the next line if $41
rjmp CE4
rjmp USART0_End
;----------------------------------------------------------------------
;----------------------------------------------------------------------
USART_CR193:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR193
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR1193:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR1193
  ; Get and return received data from buffer
lds r18,UDR1

ldi r19,0 ;$00

cpse r19,r17 ;Skip the next line if $00
rjmp USART_1or2s93
rjmp USART0_End
USART_1or2s93:
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

USART_CR093:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR093
  ; Get and return received data from buffer
lds r17,UDR1

USART_CR0093:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR0093
  ; Get and return received data from buffer
lds r18,UDR1 

cpse r19,r17 ;Skip the next line if $00
rjmp USART_1or0s93
rjmp USAR_CE43
USART_1or0s93:
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0
rjmp CE4



















CE4:


USAR_CE4:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_CE4
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_CE42:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_CE42
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_CE43:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_CE43
  ; Get and return received data from buffer
lds r17,UDR1

USAR_CE44:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_CE44
  ; Get and return received data from buffer
lds r17,UDR1

USAR_CE45:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_CE45
  ; Get and return received data from buffer
lds r17,UDR1

USAR_CE46:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_CE46
  ; Get and return received data from buffer
lds r17,UDR1


ldi r18,1 ; $01
cpse r18,r24 ;Skip the next line if $01
rjmp USART_CR1E4 

ldi r16, 255     
ldi r17, 26    
C1E40:             ;Delay cycle
subi r16, 1     
sbci r17, 0     
brcc C1E40       

sbi PORTD,4 ;Switch to transfer
;----------------------------------------------------------------------
  ; Put data (r16) into buffer, sends the data
ldi r19,1   ;send $01
sts UDR1,r19

ldi r16, 255     
ldi r17, 60     
C2E41:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C2E41       

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255      
ldi r17, 3      
C3E42:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C3E42     

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

   ; Put data (r16) into buffer, sends the data
ldi r19,56 ;send $38
sts UDR1,r19

ldi r16, 255      
ldi r17, 91    
C4E43:           ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc C4E43   
;----------------------------------------------------------------------
  ; Put data (r16) into buffer, sends the data
ldi r19,17   ;send $11
sts UDR1,r19

ldi r16, 255     
ldi r17, 60     
C2E411:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C2E411       

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255      
ldi r17, 3      
C3E422:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C3E422     

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

   ; Put data (r16) into buffer, sends the data
ldi r19,40 ;send $28
sts UDR1,r19

ldi r16, 255      
ldi r17, 91    
C4E433:           ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc C4E433   
;----------------------------------------------------------------------
  ; Put data (r16) into buffer, sends the data
ldi r19,8   ;send $08
sts UDR1,r19

ldi r16, 255     
ldi r17, 60     
C2E4111:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C2E4111       

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255      
ldi r17, 3      
C3E4222:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C3E4222     

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

   ; Put data (r16) into buffer, sends the data
ldi r19,168 ;send $A8
sts UDR1,r19

ldi r16, 255      
ldi r17, 91    
C4E4333:           ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc C4E4333 
;----------------------------------------------------------------------
  ; Put data (r16) into buffer, sends the data
ldi r19,9   ;send $09
sts UDR1,r19

ldi r16, 255     
ldi r17, 60     
C2E41111:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C2E41111       

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255      
ldi r17, 3      
C3E42222:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C3E42222     

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

   ; Put data (r16) into buffer, sends the data
ldi r19,184 ;send $B8
sts UDR1,r19

ldi r16, 255      
ldi r17, 70    
C4E43333:           ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc C4E43333

cbi PORTD,4 ;Switch to receive
   ; Flush Recever
ldi r16,(0<<RXEN1)
sts UCSR1B,r16
ldi r16,(1<<RXEN1)|(1<<TXEN1)
sts UCSR1B,r16

rjmp CF5
;----------------------------------------------------------------------
;----------------------------------------------------------------------
USART_CR1E4:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR1E4
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR11E4:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR11E4
  ; Get and return received data from buffer
lds r18,UDR1 

ldi r19,3  ; $03
cpse r19,r21 ;Skip the next line if $03
rjmp USART_1or2E4

sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

USART_CR2E4:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR2E4
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR22E4:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR22E4
  ; Get and return received data from buffer
lds r18,UDR1 
 
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

USART_CR3E4:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR3E4
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR33E4:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR33E4
  ; Get and return received data from buffer
lds r18,UDR1 
 
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

USART_CR4E4:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR4E4
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR44E4:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR44E4
  ; Get and return received data from buffer
lds r18,UDR1 
 
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

rjmp CF5




USART_1or2E4:

ldi r19,0 ;$00

cpse r19,r17 ;Skip the next line if $00
rjmp USART_1or2sE4
rjmp USART0_End
USART_1or2sE4:
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

USART_CR0E4:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR0E4
  ; Get and return received data from buffer
lds r17,UDR1

USART_CR00E4:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR00E4
  ; Get and return received data from buffer
lds r18,UDR1 

cpse r19,r17 ;Skip the next line if $00
rjmp USART_1or0sE4
rjmp USAR_CF53
USART_1or0sE4:
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0
rjmp CF5














USART_CC:
rjmp USART_C














CF5:

USAR_CF5:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_CF5
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_CF52:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_CF52
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_CF53:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_CF53
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_CF54:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_CF54
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_CF55:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_CF55
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_CF56:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_CF56
  ; Get and return received data from buffer
lds r17,UDR1 


ldi r18,1 ; $01
cpse r18,r24 ;Skip the next line if $01
rjmp USART_CR1F5

ldi r16, 255     
ldi r17, 26    
C1F50:             ;Delay cycle
subi r16, 1     
sbci r17, 0     
brcc C1F50       

sbi PORTD,4 ;Switch to transfer
;----------------------------------------------------------------------
  ; Put data (r16) into buffer, sends the data
ldi r19,13   ;send $0D
sts UDR1,r19

ldi r16, 255     
ldi r17, 60     
C2F51:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C2F51       

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255      
ldi r17, 3      
C3F52:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C3F52     

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

   ; Put data (r16) into buffer, sends the data
ldi r19,248 ;send $F8
sts UDR1,r19

ldi r16, 255      
ldi r17, 91    
C4F53:           ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc C4F53   
;----------------------------------------------------------------------
  ; Put data (r16) into buffer, sends the data
ldi r19,16   ;send $10
sts UDR1,r19

ldi r16, 255     
ldi r17, 60     
C2F511:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C2F511       

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255      
ldi r17, 3      
C3F522:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C3F522     

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

   ; Put data (r16) into buffer, sends the data
ldi r19,56 ;send $38
sts UDR1,r19

ldi r16, 255      
ldi r17, 91    
C4F533:           ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc C4F533   
;----------------------------------------------------------------------
  ; Put data (r16) into buffer, sends the data
ldi r19,15   ;send $0F
sts UDR1,r19

ldi r16, 255     
ldi r17, 60     
C2F5111:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C2F5111       

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255      
ldi r17, 3      
C3F5222:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C3F5222     

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

   ; Put data (r16) into buffer, sends the data
ldi r19,216 ;send $D8
sts UDR1,r19

ldi r16, 255      
ldi r17, 91    
C4F5333:           ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc C4F5333 
;----------------------------------------------------------------------
  ; Put data (r16) into buffer, sends the data
ldi r19,21   ;send $15
sts UDR1,r19

ldi r16, 255     
ldi r17, 60     
C2F51111:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C2F51111       

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255      
ldi r17, 3      
C3F52222:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C3F52222     

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

   ; Put data (r16) into buffer, sends the data
ldi r19,104 ;send $68
sts UDR1,r19

ldi r16, 255      
ldi r17, 70    
C4F53333:           ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc C4F53333

cbi PORTD,4 ;Switch to receive
   ; Flush Recever
ldi r16,(0<<RXEN1)
sts UCSR1B,r16
ldi r16,(1<<RXEN1)|(1<<TXEN1)
sts UCSR1B,r16

rjmp CC6
;----------------------------------------------------------------------
;----------------------------------------------------------------------
USART_CR1F5:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR1F5
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR11F5:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR11F5
  ; Get and return received data from buffer
lds r18,UDR1 

ldi r19,3  ; $03
cpse r19,r21 ;Skip the next line if $03
rjmp USART_1or2F5

sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

USART_CR2F5:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR2F5
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR22F5:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR22F5
  ; Get and return received data from buffer
lds r18,UDR1 
 
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

USART_CR3F5:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR3F5
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR33F5:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR33F5
  ; Get and return received data from buffer
lds r18,UDR1 
 
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

USART_CR4F5:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR4F5
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR44F5:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR44F5
  ; Get and return received data from buffer
lds r18,UDR1 
 
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

rjmp CC6




USART_1or2F5:

ldi r19,0 ;$00

cpse r19,r17 ;Skip the next line if $00
rjmp USART_1or2sF5
rjmp USART0_End
USART_1or2sF5:
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

USART_CR0F5:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR0F5
  ; Get and return received data from buffer
lds r17,UDR1

USART_CR00F5:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR00F5
  ; Get and return received data from buffer
lds r18,UDR1 

cpse r19,r17 ;Skip the next line if $00
rjmp USART_1or0sF5
rjmp USAR_CC63
USART_1or0sF5:
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0
rjmp CC6



















CC6:



USAR_CC6:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_CC6
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_CC62:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_CC62
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_CC63:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_CC63
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_CC64:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_CC64
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_CC65:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_CC65
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_CC66:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_CC66
  ; Get and return received data from buffer
lds r17,UDR1 


ldi r18,1 ; $01
cpse r18,r24 ;Skip the next line if $01
rjmp USART_CR1C6

ldi r16, 255     
ldi r17, 26    
C1C60:             ;Delay cycle
subi r16, 1     
sbci r17, 0     
brcc C1C60       

sbi PORTD,4 ;Switch to transfer
;----------------------------------------------------------------------
  ; Put data (r16) into buffer, sends the data
ldi r19,38   ;send $26
sts UDR1,r19

ldi r16, 255     
ldi r17, 60     
C2C61:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C2C61       

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255      
ldi r17, 3      
C3C62:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C3C62     

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

   ; Put data (r16) into buffer, sends the data
ldi r19,104 ;send $68
sts UDR1,r19

ldi r16, 255      
ldi r17, 91    
C4C63:           ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc C4C63   
;----------------------------------------------------------------------
  ; Put data (r16) into buffer, sends the data
ldi r19,12   ;send $0C
sts UDR1,r19

ldi r16, 255     
ldi r17, 60     
C2C611:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C2C611       

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255      
ldi r17, 3      
C3C622:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C3C622     

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

   ; Put data (r16) into buffer, sends the data
ldi r19,232 ;send $E8
sts UDR1,r19

ldi r16, 255      
ldi r17, 91    
C4C633:           ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc C4C633   
;----------------------------------------------------------------------
  ; Put data (r16) into buffer, sends the data
ldi r19,4   ;send $04
sts UDR1,r19

ldi r16, 255     
ldi r17, 60     
C2C6111:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C2C6111       

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255      
ldi r17, 3      
C3C6222:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C3C6222     

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

   ; Put data (r16) into buffer, sends the data
ldi r19,104 ;send $68
sts UDR1,r19

ldi r16, 255      
ldi r17, 91    
C4C6333:           ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc C4C6333 
;----------------------------------------------------------------------
  ; Put data (r16) into buffer, sends the data
ldi r19,14   ;send $0E
sts UDR1,r19

ldi r16, 255     
ldi r17, 60     
C2C61111:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C2C61111       

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255      
ldi r17, 3      
C3C62222:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C3C62222     

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

   ; Put data (r16) into buffer, sends the data
ldi r19,200 ;send $C8
sts UDR1,r19

ldi r16, 255      
ldi r17, 70    
C4C63333:           ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc C4C63333

cbi PORTD,4 ;Switch to receive
   ; Flush Recever
ldi r16,(0<<RXEN1)
sts UCSR1B,r16
ldi r16,(1<<RXEN1)|(1<<TXEN1)
sts UCSR1B,r16

rjmp CD7
;----------------------------------------------------------------------
;----------------------------------------------------------------------
USART_CR1C6:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR1C6
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR11C6:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR11C6
  ; Get and return received data from buffer
lds r18,UDR1 

ldi r19,3  ; $03
cpse r19,r21 ;Skip the next line if $03
rjmp USART_1or2C6

sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

USART_CR2C6:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR2C6
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR22C6:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR22C6
  ; Get and return received data from buffer
lds r18,UDR1 
 
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

USART_CR3C6:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR3C6
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR33C6:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR33C6
  ; Get and return received data from buffer
lds r18,UDR1 
 
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

USART_CR4C6:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR4C6
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR44C6:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR44C6
  ; Get and return received data from buffer
lds r18,UDR1 
 
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

rjmp CD7





USART_1or2C6:

ldi r19,0 ;$00

cpse r19,r17 ;Skip the next line if $00
rjmp USART_1or2sC6
rjmp USART0_End
USART_1or2sC6:
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

USART_CR0C6:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR0C6
  ; Get and return received data from buffer
lds r17,UDR1

USART_CR00C6:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR00C6
  ; Get and return received data from buffer
lds r18,UDR1 

cpse r19,r17 ;Skip the next line if $00
rjmp USART_1or0sC6
rjmp USAR_CD73
USART_1or0sC6:
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0
rjmp CD7



















CD7:


USAR_CD7:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_CD7
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_CD72:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_CD72
  ; Get and return received data from buffer
lds r17,UDR1  

USAR_CD73:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_CD73
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_CD74:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_CD74
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_CD75:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_CD75
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_CD76:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_CD76
  ; Get and return received data from buffer
lds r17,UDR1 


ldi r18,1 ; $01
cpse r18,r24 ;Skip the next line if $01
rjmp USART_CR1D7

ldi r16, 255     
ldi r17, 26    
C1D70:             ;Delay cycle
subi r16, 1     
sbci r17, 0     
brcc C1D70       

sbi PORTD,4 ;Switch to transfer
;----------------------------------------------------------------------
  ; Put data (r16) into buffer, sends the data
ldi r19,22   ;send $16
sts UDR1,r19

ldi r16, 255     
ldi r17, 60     
C2D71:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C2D71       

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255      
ldi r17, 3      
C3D72:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C3D72     

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

   ; Put data (r16) into buffer, sends the data
ldi r19,88 ;send $58
sts UDR1,r19

ldi r16, 255      
ldi r17, 91    
C4D73:           ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc C4D73   
;----------------------------------------------------------------------
  ; Put data (r16) into buffer, sends the data
ldi r19,27   ;send $1B
sts UDR1,r19

ldi r16, 255     
ldi r17, 60     
C2D711:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C2D711       

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255      
ldi r17, 3      
C3D722:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C3D722     

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

   ; Put data (r16) into buffer, sends the data
ldi r19,136 ;send $88
sts UDR1,r19

ldi r16, 255      
ldi r17, 91    
C4D733:           ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc C4D733   
;----------------------------------------------------------------------
  ; Put data (r16) into buffer, sends the data
ldi r19,26   ;send $1A
sts UDR1,r19

ldi r16, 255     
ldi r17, 60     
C2D7111:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C2D7111       

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255      
ldi r17, 3      
C3D7222:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C3D7222     

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

   ; Put data (r16) into buffer, sends the data
ldi r19,152 ;send $98
sts UDR1,r19

ldi r16, 255      
ldi r17, 91    
C4D7333:           ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc C4D7333 
;----------------------------------------------------------------------
  ; Put data (r16) into buffer, sends the data
ldi r19,32   ;send $20
sts UDR1,r19

ldi r16, 255     
ldi r17, 60     
C2D71111:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C2D71111       

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255      
ldi r17, 3      
C3D72222:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C3D72222     

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

   ; Put data (r16) into buffer, sends the data
ldi r19,8 ;send $08
sts UDR1,r19

ldi r16, 255      
ldi r17, 70    
C4D73333:           ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc C4D73333

cbi PORTD,4 ;Switch to receive
   ; Flush Recever
ldi r16,(0<<RXEN1)
sts UCSR1B,r16
ldi r16,(1<<RXEN1)|(1<<TXEN1)
sts UCSR1B,r16

rjmp C28
;----------------------------------------------------------------------
;----------------------------------------------------------------------
USART_CR1D7:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR1D7
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR11D7:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR11D7
  ; Get and return received data from buffer
lds r18,UDR1 

ldi r19,3  ; $03
cpse r19,r21 ;Skip the next line if $03
rjmp USART_1or2D7

sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

USART_CR2D7:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR2D7
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR22D7:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR22D7
  ; Get and return received data from buffer
lds r18,UDR1 
 
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

USART_CR3D7:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR3D7
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR33D7:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR33D7
  ; Get and return received data from buffer
lds r18,UDR1 
 
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

USART_CR4D7:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR4D7
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR44D7:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR44D7
  ; Get and return received data from buffer
lds r18,UDR1 
 
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

rjmp C28




USART_1or2D7:

ldi r19,0 ;$00

cpse r19,r17 ;Skip the next line if $00
rjmp USART_1or2sD7
rjmp USART0_End
USART_1or2sD7:
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

USART_CR0D7:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR0D7
  ; Get and return received data from buffer
lds r17,UDR1

USART_CR00D7:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR00D7
  ; Get and return received data from buffer
lds r18,UDR1 

cpse r19,r17 ;Skip the next line if $00
rjmp USART_1or0sD7
rjmp USAR_C283
USART_1or0sD7:
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0
rjmp C28



















C28:


USAR_C28:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C28
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_C282:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C282
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_C283:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C283
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_C284:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C284
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_C285:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C285
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_C286:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C286
  ; Get and return received data from buffer
lds r17,UDR1 

ldi r18,3 ; $03
cpse r18,r21 ;Skip the next line if $03
rjmp USART_CR128
rjmp C39
;----------------------------------------------------------------------
;----------------------------------------------------------------------
USART_CR128:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR128
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR1128:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR1128
  ; Get and return received data from buffer
lds r18,UDR1

ldi r19,0 ;$00

cpse r19,r17 ;Skip the next line if $00
rjmp USART_1or2s28
rjmp USART0_End
USART_1or2s28:
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

USART_CR028:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR028
  ; Get and return received data from buffer
lds r17,UDR1

USART_CR0028:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR0028
  ; Get and return received data from buffer
lds r18,UDR1 

cpse r19,r17 ;Skip the next line if $00
rjmp USART_1or0s28
rjmp USAR_C393
USART_1or0s28:
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0
rjmp C39



















C39:


USAR_C39:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C39
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_C392:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C392
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_C393:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C393
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_C394:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C394
  ; Get and return received data from buffer
lds r17,UDR1

USAR_C395:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C395
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_C396:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C396
  ; Get and return received data from buffer
lds r17,UDR1  

ldi r18,3 ; $03
cpse r18,r21 ;Skip the next line if $03
rjmp USART_CR139
rjmp C0A
;----------------------------------------------------------------------
;----------------------------------------------------------------------
USART_CR139:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR139
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR1139:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR1139
  ; Get and return received data from buffer
lds r18,UDR1

ldi r19,0 ;$00

cpse r19,r17 ;Skip the next line if $00
rjmp USART_1or2s39
rjmp USART0_End
USART_1or2s39:
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

USART_CR039:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR039
  ; Get and return received data from buffer
lds r17,UDR1

USART_CR0039:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR0039
  ; Get and return received data from buffer
lds r18,UDR1 

cpse r19,r17 ;Skip the next line if $00
rjmp USART_1or0s39
rjmp USAR_C0A3
USART_1or0s39:
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0
rjmp C0A














UART00_CMD:
rjmp UART000_CMD

USART0_End:
rjmp USART_End

USART000_Start:
rjmp USART00_Start














C0A:


USAR_C0A:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C0A
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_C0A2:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C0A2
  ; Get and return received data from buffer
lds r17,UDR1

USAR_C0A3:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C0A3
  ; Get and return received data from buffer
lds r17,UDR1

USAR_C0A4:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C0A4
  ; Get and return received data from buffer
lds r17,UDR1

USAR_C0A5:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C0A5
  ; Get and return received data from buffer
lds r17,UDR1

USAR_C0A6:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C0A6
  ; Get and return received data from buffer
lds r17,UDR1

ldi r18,3 ; $03
cpse r18,r21 ;Skip the next line if $03
rjmp USART_CR10A
rjmp C1B
;----------------------------------------------------------------------
;----------------------------------------------------------------------
USART_CR10A:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR10A
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR110A:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR110A
  ; Get and return received data from buffer
lds r18,UDR1

ldi r19,0 ;$00

cpse r19,r17 ;Skip the next line if $00
rjmp USART_1or2s0A
rjmp USART_End
USART_1or2s0A:
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

USART_CR00A:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR00A
  ; Get and return received data from buffer
lds r17,UDR1

USART_CR000A:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR000A
  ; Get and return received data from buffer
lds r18,UDR1 

cpse r19,r17 ;Skip the next line if $00
rjmp USART_1or0s0A
rjmp USAR_C1B3
USART_1or0s0A:
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0
rjmp C1B














USART_CCC:
rjmp USART_CC














C1B:


USAR_C1B:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C1B
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_C1B2:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C1B2
  ; Get and return received data from buffer
lds r17,UDR1  

USAR_C1B3:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C1B3
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_C1B4:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C1B4
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_C1B5:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C1B5
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_C1B6:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C1B6
  ; Get and return received data from buffer
lds r17,UDR1 

ldi r18,3 ; $03
cpse r18,r21 ;Skip the next line if $03
rjmp USART_CR11B
rjmp C6C
;----------------------------------------------------------------------
;----------------------------------------------------------------------
USART_CR11B:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR11B
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR111B:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR111B
  ; Get and return received data from buffer
lds r18,UDR1

ldi r19,0 ;$00

cpse r19,r17 ;Skip the next line if $00
rjmp USART_1or2s1B
rjmp USART_End
USART_1or2s1B:
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

USART_CR01B:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR01B
  ; Get and return received data from buffer
lds r17,UDR1

USART_CR001B:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR001B
  ; Get and return received data from buffer
lds r18,UDR1 

cpse r19,r17 ;Skip the next line if $00
rjmp USART_1or0s1B
rjmp USAR_C6C3
USART_1or0s1B:
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0
rjmp C6C



















C6C:


USAR_C6C:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C6C
  ; Get and return received data from buffer
lds r17,UDR1

USAR_C6C2:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C6C2
  ; Get and return received data from buffer
lds r17,UDR1

USAR_C6C3:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C6C3
  ; Get and return received data from buffer
lds r17,UDR1

USAR_C6C4:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C6C4
  ; Get and return received data from buffer
lds r17,UDR1

ldi r18,1 ; $01
cpse r18,r24 ;Skip the next line if $01
rjmp USART_CR16C

ldi r16, 255     
ldi r17, 184    
C16C:             ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C16C       

sbi PORTD,4 ;Switch to transfer
;----------------------------------------------------------------------
  ; Put data (r16) into buffer, sends the data
ldi r19,1 ;send $01
sts UDR1,r19

ldi r16, 255     
ldi r17, 60     
C26C1:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C26C1       

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255      
ldi r17, 3      
C36C2:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C36C2     

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

   ; Put data (r16) into buffer, sends the data
ldi r19,56 ;send $38
sts UDR1,r19

ldi r16, 255      
ldi r17, 91    
C46C3:           ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc C46C3    
;-------------------------------------------------------------------
  ; Put data (r16) into buffer, sends the data
ldi r19,17   ;send $11
sts UDR1,r19

ldi r16, 255     
ldi r17, 60     
C26C11:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C26C11       

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255      
ldi r17, 3      
C36C22:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C36C22     

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

   ; Put data (r16) into buffer, sends the data
ldi r19,40 ;send $28
sts UDR1,r19

ldi r16, 255      
ldi r17, 91    
C46C33:           ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc C46C33
;-------------------------------------------------------------------
  ; Put data (r16) into buffer, sends the data
ldi r19,8   ;send $08
sts UDR1,r19

ldi r16, 255     
ldi r17, 60     
C26C111:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C26C111       

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255      
ldi r17, 3      
C36C222:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C36C222     

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

   ; Put data (r16) into buffer, sends the data
ldi r19,168 ;send $A8
sts UDR1,r19

ldi r16, 255      
ldi r17, 91    
C46C333:           ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc C46C333
;-------------------------------------------------------------------
  ; Put data (r16) into buffer, sends the data
ldi r19,9   ;send $09
sts UDR1,r19

ldi r16, 255     
ldi r17, 60     
C26C1111:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C26C1111       

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255      
ldi r17, 3      
C36C2222:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C36C2222     

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

   ; Put data (r16) into buffer, sends the data
ldi r19,184 ;send $B8
sts UDR1,r19

ldi r16, 255      
ldi r17, 70    
C46C3333:           ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc C46C3333

cbi PORTD,4 ;Switch to receive
   ; Flush Recever
ldi r16,(0<<RXEN1)
sts UCSR1B,r16
ldi r16,(1<<RXEN1)|(1<<TXEN1)
sts UCSR1B,r16

rjmp C7D
;-------------------------------------------------------------------
;-------------------------------------------------------------------
USART_CR16C:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR16C
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR116C:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR116C
  ; Get and return received data from buffer
lds r18,UDR1 

ldi r19,3  ; $03
cpse r19,r21 ;Skip the next line if $03
rjmp USART_1or26C

sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

USART_CR26C:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR26C
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR226C:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR226C
  ; Get and return received data from buffer
lds r18,UDR1 
 
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

USART_CR36C:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR36C
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR336C:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR336C
  ; Get and return received data from buffer
lds r18,UDR1 
 
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

USART_CR46C:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR46C
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR446C:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR446C
  ; Get and return received data from buffer
lds r18,UDR1 
 
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

rjmp C7D




USART_1or26C:

ldi r19,0 ;$00

cpse r19,r17 ;Skip the next line if $00
rjmp USART_1or2s6C
rjmp USART_End
USART_1or2s6C:
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0
rjmp C7D



















C7D:


USAR_C7D:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C7D
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_C7D2:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C7D2
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_C7D3:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C7D3
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_C7D4:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C7D4
  ; Get and return received data from buffer
lds r17,UDR1 


ldi r18,1 ; $01
cpse r18,r24 ;Skip the next line if $01
rjmp USART_CR17D

ldi r16, 255     
ldi r17, 184    
C17D:             ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C17D       

sbi PORTD,4 ;Switch to transfer
;----------------------------------------------------------------------
  ; Put data (r16) into buffer, sends the data
ldi r19,13   ;send $0D
sts UDR1,r19

ldi r16, 255     
ldi r17, 60     
C27D1:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C27D1       

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255      
ldi r17, 3      
C37D2:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C37D2     

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

   ; Put data (r16) into buffer, sends the data
ldi r19,248 ;send $F8
sts UDR1,r19

ldi r16, 255      
ldi r17, 91    
C47D3:           ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc C47D3    
;-------------------------------------------------------------------
  ; Put data (r16) into buffer, sends the data
ldi r19,16   ;send $10
sts UDR1,r19

ldi r16, 255     
ldi r17, 60     
C27D11:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C27D11       

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255      
ldi r17, 3      
C37D22:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C37D22     

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

   ; Put data (r16) into buffer, sends the data
ldi r19,56 ;send $38
sts UDR1,r19

ldi r16, 255      
ldi r17, 91    
C47D33:           ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc C47D33
;-------------------------------------------------------------------
  ; Put data (r16) into buffer, sends the data
ldi r19,15   ;send $0F
sts UDR1,r19

ldi r16, 255     
ldi r17, 60     
C27D111:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C27D111       

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255      
ldi r17, 3      
C37D222:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C37D222     

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

   ; Put data (r16) into buffer, sends the data
ldi r19,216 ;send $D8
sts UDR1,r19

ldi r16, 255      
ldi r17, 91    
C47D333:           ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc C47D333
;-------------------------------------------------------------------
  ; Put data (r16) into buffer, sends the data
ldi r19,21   ;send $15
sts UDR1,r19

ldi r16, 255     
ldi r17, 60     
C27D1111:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C27D1111       

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255      
ldi r17, 3      
C37D2222:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C37D2222     

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

   ; Put data (r16) into buffer, sends the data
ldi r19,104 ;send $68
sts UDR1,r19

ldi r16, 255      
ldi r17, 70    
C47D3333:           ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc C47D3333

cbi PORTD,4 ;Switch to receive
   ; Flush Recever
ldi r16,(0<<RXEN1)
sts UCSR1B,r16
ldi r16,(1<<RXEN1)|(1<<TXEN1)
sts UCSR1B,r16

rjmp C4E
;-------------------------------------------------------------------
;-------------------------------------------------------------------
USART_CR17D:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR17D
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR117D:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR117D
  ; Get and return received data from buffer
lds r18,UDR1 

ldi r19,3  ; $03
cpse r19,r21 ;Skip the next line if $03
rjmp USART_1or27D

sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

USART_CR27D:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR27D
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR227D:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR227D
  ; Get and return received data from buffer
lds r18,UDR1 
 
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

USART_CR37D:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR37D
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR337D:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR337D
  ; Get and return received data from buffer
lds r18,UDR1 
 
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

USART_CR47D:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR47D
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR447D:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR447D
  ; Get and return received data from buffer
lds r18,UDR1 
 
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

rjmp C4E




USART_1or27D:

ldi r19,0 ;$00

cpse r19,r17 ;Skip the next line if $00
rjmp USART_1or2s7D
rjmp USART_End
USART_1or2s7D:
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0
rjmp C4E



















C4E:


USAR_C4E:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C4E
  ; Get and return received data from buffer
lds r17,UDR1

USAR_C4E2:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C4E2
  ; Get and return received data from buffer
lds r17,UDR1

USAR_C4E3:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C4E3
  ; Get and return received data from buffer
lds r17,UDR1

USAR_C4E4:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C4E4
  ; Get and return received data from buffer
lds r17,UDR1 

ldi r18,1 ; $01
cpse r18,r24 ;Skip the next line if $01
rjmp USART_CR14E

ldi r16, 255     
ldi r17, 184    
C14E:             ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C14E       

sbi PORTD,4 ;Switch to transfer
;----------------------------------------------------------------------
  ; Put data (r16) into buffer, sends the data
ldi r19,38   ;send $26
sts UDR1,r19

ldi r16, 255     
ldi r17, 60     
C24E1:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C24E1       

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255      
ldi r17, 3      
C34E2:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C34E2     

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

   ; Put data (r16) into buffer, sends the data
ldi r19,104 ;send $68
sts UDR1,r19

ldi r16, 255      
ldi r17, 91    
C44E3:           ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc C44E3    
;-------------------------------------------------------------------
  ; Put data (r16) into buffer, sends the data
ldi r19,12   ;send $0C
sts UDR1,r19

ldi r16, 255     
ldi r17, 60     
C24E11:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C24E11       

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255      
ldi r17, 3      
C34E22:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C34E22     

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

   ; Put data (r16) into buffer, sends the data
ldi r19,232 ;send $E8
sts UDR1,r19

ldi r16, 255      
ldi r17, 91    
C44E33:           ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc C44E33
;-------------------------------------------------------------------
  ; Put data (r16) into buffer, sends the data
ldi r19,4   ;send $04
sts UDR1,r19

ldi r16, 255     
ldi r17, 60     
C24E111:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C24E111       

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255      
ldi r17, 3      
C34E222:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C34E222     

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

   ; Put data (r16) into buffer, sends the data
ldi r19,104 ;send $68
sts UDR1,r19

ldi r16, 255      
ldi r17, 91    
C44E333:           ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc C44E333
;-------------------------------------------------------------------
  ; Put data (r16) into buffer, sends the data
ldi r19,14   ;send $0E
sts UDR1,r19

ldi r16, 255     
ldi r17, 60     
C24E1111:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C24E1111       

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255      
ldi r17, 3      
C34E2222:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C34E2222     

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

   ; Put data (r16) into buffer, sends the data
ldi r19,200 ;send $C8
sts UDR1,r19

ldi r16, 255      
ldi r17, 70    
C44E3333:           ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc C44E3333

cbi PORTD,4 ;Switch to receive
   ; Flush Recever
ldi r16,(0<<RXEN1)
sts UCSR1B,r16
ldi r16,(1<<RXEN1)|(1<<TXEN1)
sts UCSR1B,r16

rjmp C5F
;-------------------------------------------------------------------
;-------------------------------------------------------------------
USART_CR14E:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR14E
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR114E:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR114E
  ; Get and return received data from buffer
lds r18,UDR1 

ldi r19,3  ; $03
cpse r19,r21 ;Skip the next line if $03
rjmp USART_1or24E

sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

USART_CR24E:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR24E
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR224E:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR224E
  ; Get and return received data from buffer
lds r18,UDR1 
 
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

USART_CR34E:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR34E
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR334E:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR334E
  ; Get and return received data from buffer
lds r18,UDR1 
 
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

USART_CR44E:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR44E
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR444E:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR444E
  ; Get and return received data from buffer
lds r18,UDR1 
 
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

rjmp C5F




USART_1or24E:

ldi r19,0 ;$00

cpse r19,r17 ;Skip the next line if $00
rjmp USART_1or2s4E
rjmp USART_End
USART_1or2s4E:
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0
rjmp USART_End



















C5F:


USAR_C5F:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C5F
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_C5F2:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C5F2
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_C5F3:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C5F3
  ; Get and return received data from buffer
lds r17,UDR1 

USAR_C5F4:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USAR_C5F4
  ; Get and return received data from buffer
lds r17,UDR1


ldi r18,1 ; $01
cpse r18,r24 ;Skip the next line if $01
rjmp USART_CR15F

ldi r16, 255     
ldi r17, 184    
C15F:             ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C15F       

sbi PORTD,4 ;Switch to transfer
;----------------------------------------------------------------------
  ; Put data (r16) into buffer, sends the data
ldi r19,22   ;send $16
sts UDR1,r19

ldi r16, 255     
ldi r17, 60     
C25F1:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C25F1       

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255      
ldi r17, 3      
C35F2:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C35F2     

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

   ; Put data (r16) into buffer, sends the data
ldi r19,88 ;send $58
sts UDR1,r19

ldi r16, 255      
ldi r17, 91    
C45F3:           ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc C45F3    
;-------------------------------------------------------------------
  ; Put data (r16) into buffer, sends the data
ldi r19,27   ;send $1B
sts UDR1,r19

ldi r16, 255     
ldi r17, 60     
C25F11:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C25F11       

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255      
ldi r17, 3      
C35F22:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C35F22     

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

   ; Put data (r16) into buffer, sends the data
ldi r19,136 ;send $88
sts UDR1,r19

ldi r16, 255      
ldi r17, 91    
C45F33:           ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc C45F33
;-------------------------------------------------------------------
  ; Put data (r16) into buffer, sends the data
ldi r19,26   ;send $1A
sts UDR1,r19

ldi r16, 255     
ldi r17, 60     
C25F111:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C25F111       

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255      
ldi r17, 3      
C35F222:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C35F222     

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

   ; Put data (r16) into buffer, sends the data
ldi r19,152 ;send $98
sts UDR1,r19

ldi r16, 255      
ldi r17, 91    
C45F333:           ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc C45F333
;-------------------------------------------------------------------
  ; Put data (r16) into buffer, sends the data
ldi r19,32   ;send $20
sts UDR1,r19

ldi r16, 255     
ldi r17, 60     
C25F1111:            ;Delay cycle
subi r16, 1      
sbci r17, 0      
brcc C25F1111       

; Set baud rate
ldi r16,0 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,51 ; 19200 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

ldi r16, 255      
ldi r17, 3      
C35F2222:            ;Delay cycle
subi r16, 1       
sbci r17, 0      
brcc C35F2222     

ldi r16,1 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1H,r16 
ldi r16,162 ; 2400 for 16 104 000 Hz Asynch Mode:((fosc/16BAUD)-1)
sts UBRR1L,r16

   ; Put data (r16) into buffer, sends the data
ldi r19,8 ;send $08
sts UDR1,r19

ldi r16, 255      
ldi r17, 70    
C45F3333:           ;Delay cycle
subi r16, 1       
sbci r17, 0       
brcc C45F3333

cbi PORTD,4 ;Switch to receive
   ; Flush Recever
ldi r16,(0<<RXEN1)
sts UCSR1B,r16
ldi r16,(1<<RXEN1)|(1<<TXEN1)
sts UCSR1B,r16

rjmp USART_End
;-------------------------------------------------------------------
;-------------------------------------------------------------------
USART_CR15F:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR15F
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR115F:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR115F
  ; Get and return received data from buffer
lds r18,UDR1 

sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

USART_CR25F:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR25F
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR225F:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR225F
  ; Get and return received data from buffer
lds r18,UDR1 
 
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

USART_CR35F:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR35F
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR335F:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR335F
  ; Get and return received data from buffer
lds r18,UDR1 
 
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

USART_CR45F:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR45F
  ; Get and return received data from buffer
lds r17,UDR1 
 
USART_CR445F:
  ; Wait for data to be received
lds r16,UCSR1A
sbrs r16,RXC1 ;Skip the next line if a data has been unread  in UDR
rjmp USART_CR445F
  ; Get and return received data from buffer
lds r18,UDR1 
 
sts 0x2C,r17   ;send usart0 UDR0
sts 0x2C,r18   ;send usart0 UDR0

rjmp USART_End









USART_End:

ldi r24,0  ; $00

ldi r18,3  ; $03
cpse r18,r21 ;Skip the next line if $03
rjmp USART_CCC

USART_En3:
ldi r18,65  ; $41
cpse r18,r22 ;Skip the next line if $41
rjmp USART_CCC
ldi r22,33  ; $21
ldi r23, 246  ; $F6
ldi r24,01  ; $01
rjmp USART_CCC
	
UART000_CMD:  ; Intrrupt Get and return received data from buffer
lds r21,0x2C ;UDR0 
rjmp USART000_Start