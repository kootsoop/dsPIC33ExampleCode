;**********************************************************************
; � 2007 Microchip Technology Inc.
;
; FileName:        G711.s
; Dependencies:    Header (.h) files if applicable, see below
; Processor:       dsPIC33FJ256GP506
; Compiler:        MPLAB� C30 v3.00 or higher
;
;SOFTWARE LICENSE AGREEMENT:
;Except as otherwise expressly provided below, Microchip Technology Inc. 
;(Microchip) licenses this software to you solely for use with Microchip products.
;This software is owned by Microchip and/or its licensors, and is protected under 
;applicable copyright laws.  All rights reserved.
;
;This software and any accompanying information is for suggestion only.  
;It shall not be deemed to modify Microchip�s standard warranty for its products.
;It is your responsibility to ensure that this software meets your requirements.
;
;WARRANTY DISCLAIMER AND LIMIT ON LIABILITY:  SOFTWARE IS PROVIDED AS IS.  
;MICROCHIP AND ITS LICENSORS EXPRESSLY DISCLAIM ANY WARRANTY OF ANY KIND, 
;WHETHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO, THE IMPLIED WARRANTIES 
;OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, OR NON-INFRINGEMENT. 
;IN NO EVENT SHALL MICROCHIP OR ITS LICENSORS BE LIABLE FOR ANY INCIDENTAL, 
;SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA, 
;HARM TO YOUR EQUIPMENT, COST OF PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY 
;OR SERVICES, ANY CLAIMS BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY 
;DEFENSE THEREOF), ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER SIMILAR 
;COSTS.  To the fullest extend allowed by law, Microchip and its licensors 
;liability shall not exceed the amount of fees, if any, that you have paid 
;directly to Microchip to use this software.
;
;THIRD PARTY SOFTWARE:  Notwithstanding anything to the contrary, any third 
;party software accompanying this software including but not limited to ITU 
;software is subject to the terms and conditions of the third party�s license
;agreement such as the General Public License.  To the extent required by third
;party licenses covering such third party software, the terms of such license 
;will apply in lieu of the terms provided herein.  To the extent the terms of 
;such third party licenses prohibit any of the restrictions described herein, 
;such restrictions will not apply to such third party software.  THIRD PARTY 
;SOFTWARE  IS SUBJECT TO THE FOREGOING WARRANTY DISCLAIMER AND LIMIT ON LIABILITY 
;PROVIDED IN THE PARAGRAPH ABOVE
;
;MICROCHIP PROVIDES THIS SOFTWARE (INCLUDING ACCOMPANYING THIRD PARTY SOFTWARE)
;CONDITIONALLY UPON YOUR ACCEPTANCE OF THESE TERMS.
;************************************************************************

	.equ		BIAS,0x84
	.equ		ULAW_MAXLIMIT,32635
	.equ		ALAW_MAXLIMIT,32767
	.equ		__CCITT_ZERO_TRAP,0
	.text
	.global	_G711Ulaw2Lin
	.global	_G711Lin2Ulaw
	.global	_G711Alaw2Lin
	.global _G711Lin2Alaw

	;For all the functions
	;W0 - Contains the 16 bit signed number to Encode
	;W1 - Contains the sign 
	;W2 - Contains the exponent
	;W3 - Scratch Register
	;W4 - Contains the mantissa
	;W5 - Contains the source address
	;W6 - Contains the destination address
	;W7 - Contains the size of the frame

_G711Lin2Ulaw:
	mov		W0,W5			; W5 will have the source address
	mov		W1,W6			; W6 will have the destination address
	mov		W2,W7			; W7 contains the size of the frame
	cp0		W7				; Size should greater than zero
	bra		LE,done			; Else exit
start:	
	mov		[W5++],W0		; Get a value from source destination
	mov		#0x8000,W3		; Use this to get the sign
	and		W0,W3,W1		; W1 - stores the sign of number
							; W0 - contains the number to be encoded.
	lsr		W1,#8,W1		; Make this sign bit the 8th bit.
	btsc	W0,#15			; If W0 is negative then negate it
	neg		W0,W0			; Negate it.

	
	mov		#ULAW_MAXLIMIT,W3	; 
	cp		W0,W3			; If W0 is greater than MAXLIMIT
	bra		NC,NOT_GRT1
	mov		W3,W0			; then set W0 to MAXLIMIT
NOT_GRT1:
	mov		#BIAS,W3		; Add the bias to the to ensure atleast
	add		W0,W3,W0		; the 8th bit is set
	
	ff1l		W0,W2			; Find the first one from the left
	bra		C,send_result		; If no 1 was found, the input value is zero
	mov		#9,W3
	sub		W3,W2,W2		; Exponent for 1 in 9th position is zero
	bra		NN,grter_exp		; If the subtraction was negative this mean
	clr		W2				; the one was after the 9th position
	
grter_exp:					; At this point W2 contains the exponent.

	add		W2,#3,W3		; Shift W0 to the right (exponent + 3) times
	lsr		W0,W3,W4		; The mantissa - almost there
	mov		#0x000F,W3
	and		W4,W3,W4		; W4 has the mantissa
	
;	mov		W1,W5			; The sign bit
	sl		W2,#4,W2
	ior		W4,W2,W4		; exponent and mantissa
	ior		W4,W1,W4		; sign bit
send_result:	
	com		W4,W0
	and		#0x00FF,W0	
	.if		__CCITT_ZERO_TRAP		
	bra		nz, not_zero_result	;CCITT Zero Trap
	mov		#2,W0
	.endif
not_zero_result:

	mov.b	W0,[W6++]		; Store result at destination
	dec		W7,W7			; decrement count
	bra		NZ,	start			; if count not zero then continue
done:
	return

;Code for the Ulaw expander

_G711Ulaw2Lin:
		
	mov		W0,W5			; W5 will have the source address
	mov		W1,W6			; W6 will have the destination address
	mov		W2,W7			; W7 contains the size of the frame
	cp0		W7				; Size should greater than zero
	bra		LE,exp_done		; Else exit
exp_start:

	mov.b	[W5++],W0		; get a byte from the source
	com		W0,W0			; Complement.
	
	mov		#0x0080,W3		; Use this to get the sign
	and		W0,W3,W1		; W1 - stores the sign of number

	mov		#0x0070,W3		; Mask for the exponent
	and		W0,W3,W2		; Get the exponent into W2
	lsr		W2,#4,W2		; Make it the lowest nibble
	inc2		W2,W2			; Add 2 to it
	
	mov		#0x000F,W3
	and		W0,W3,W4		; Get the mantissa into W4
	
	ior		W4,#0x10,W4		; Set the fifth bit of the mantissa
	sl		W4,W4			; Shift mantissa left by 1
	inc		W4,W4			; and then Add 1 to it
	sl		W4,W2,W4		; Shift mantissa left by (exponent + 2) 

	mov		#BIAS,W3
	sub		W4,W3,W4		; Subtract the bias from mantissa
	
	btsc	W1,#7			; if the sign bit is clear then dont negate
	neg		W4,W4			; 
	
	mov		W4,[W6++]
	dec		W7,W7			; decrement count
	bra		NZ,	exp_start		; if count not zero then continue	
	
exp_done:
	return


_G711Lin2Alaw:

	mov		W0,W5			; W5 will have the source address
	mov		W1,W6			; W6 will have the destination address
	mov		W2,W7			; W7 contains the size of the frame
	cp0		W7				; Size should greater than zero
	bra		LE,alaw_done		; Else exit

alaw_start:	
	mov		[W5++],W0		; Get a value from source destination
	cp0		W0				; is the value 0
	bra 		nz,alaw_nonzero
	mov		#0x0055,W0		;
	bra		alaw_store
alaw_nonzero:
	mov		#0x8000,W3		; Use this to get the sign
	and		W0,W3,W1		; W1 - stores the sign of number
							; W0 - contains the number to be encoded.
	lsr		W1,#8,W1		; Make this sign bit the 8th bit.
	btsc 	W0,#15			; If W0 is negative then negate it
	neg		W0,W0			; Negate it.

	mov		#ALAW_MAXLIMIT,W3	; 
	cp		W0,W3			; If W0 is greater than MAXLIMIT
	bra		NC,NOT_GRT2
	mov		W3,W0			; then set W0 to MAXLIMIT	

NOT_GRT2:

	ff1l		W0,W2			; Find the first one from the left
	bra		C,zero_exponent	; no 1 was found

	cp		W2,#9			; Was a exponent found.
	bra		GE, zero_exponent  ;
	mov		#9,W3
	sub		W3,W2,W2		; Exponent for 1 in 9th position is zero
	add		W2,#3,W3
	bra		alaw_mantissa	;
zero_exponent:
	clr		W2				; Exponent is zero
	mov		#4,W3
alaw_mantissa:
	lsr		W0,W3,W4		; The mantissa - almost there
	mov		#0x000F,W3
	and		W4,W3,W4		; W4 has the mantissa
	
	sl		W2,#4,W2
	ior		W4,W2,W4		; exponent and mantissa
	ior		W4,W1,W4		; sign bit

	mov		#0xD5,W3
	xor.b	W4,W3,W0
alaw_store:	
	mov.b	W0,[W6++]		; Store result at destination
	dec		W7,W7			; decrement count
	bra		NZ,	alaw_start	; if count not zero then continue
	
alaw_done:

	return
	
_G711Alaw2Lin:
	
	mov		W0,W5			; W5 will have the source address
	mov		W1,W6			; W6 will have the destination address
	mov		W2,W7			; W7 contains the size of the frame
	cp0		W7				; Size should greater than zero
	bra		LE,alaw2lin_done	; Else exit

alaw2lin_again:
	clr		W0	
	mov.b	[W5++],W0		; Get a Linear Value 
	mov		#0xD5,W3		; Alternate complement bit 6-0
	xor.b	W3,W0,W0		; Result in W0
	
	mov		#0x80,W3
	and		W0,W3,W1		; Get the sign in W1
	mov		#0x70,W3
	and		W0,W3,W2		; Get the exponent
	lsr		W2,#4,W2		; make the exponent the lower nibble.

	and		W0,#0xF,W4		; Get the mantissa
	sl		W4,#4,W4		; Shift mantissa left by 4
	add		W4,#8,W0		; This puts mantissa in the middle range

	cp0		W2
	bra		z,alaw2lin_noexp
	mov		#0x100,W3		; If there is a exponent, then there is 
	add		W0,W3,W0		; atleast a 1 at position 9

alaw2lin_noexp:

	cp		W2,#1			; If exponent is greater than 1
	bra		le,alaw2lin_noshift	; then shift left the mantissa exp-1 time
	dec		W2,W2
	sl		W0,W2,W0		

alaw2lin_noshift:

	btsc	W1,#7			; Check the sign bit and if 1 then negate
	neg		W0,W0

	mov		W0,[W6++]		; Store result at destination
	dec		W7,W7			; decrement count
	bra		NZ,alaw2lin_again	; if count not zero then continue

alaw2lin_done:

	return
