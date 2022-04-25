/**********************************************************************
* © 2008 Microchip Technology Inc.
*
* FileName:        PgmMemory.s
* Dependencies:    Header (.h) files if applicable, see below
* Processor:       dsPIC33Fxxxx
* Compiler:        MPLAB® C30 v3.00 or higher
*
* SOFTWARE LICENSE AGREEMENT:
* Microchip Technology Incorporated ("Microchip") retains all ownership and 
* intellectual property rights in the code accompanying this message and in all 
* derivatives hereto.  You may use this code, and any derivatives created by 
* any person or entity by or on your behalf, exclusively with Microchip's
* proprietary products.  Your acceptance and/or use of this code constitutes 
* agreement to the terms and conditions of this notice.
*
* CODE ACCOMPANYING THIS MESSAGE IS SUPPLIED BY MICROCHIP "AS IS".  NO 
* WARRANTIES, WHETHER EXPRESS, IMPLIED OR STATUTORY, INCLUDING, BUT NOT LIMITED 
* TO, IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A 
* PARTICULAR PURPOSE APPLY TO THIS CODE, ITS INTERACTION WITH MICROCHIP'S 
* PRODUCTS, COMBINATION WITH ANY OTHER PRODUCTS, OR USE IN ANY APPLICATION. 
*
* YOU ACKNOWLEDGE AND AGREE THAT, IN NO EVENT, SHALL MICROCHIP BE LIABLE, WHETHER 
* IN CONTRACT, WARRANTY, TORT (INCLUDING NEGLIGENCE OR BREACH OF STATUTORY DUTY), 
* STRICT LIABILITY, INDEMNITY, CONTRIBUTION, OR OTHERWISE, FOR ANY INDIRECT, SPECIAL, 
* PUNITIVE, EXEMPLARY, INCIDENTAL OR CONSEQUENTIAL LOSS, DAMAGE, FOR COST OR EXPENSE OF 
* ANY KIND WHATSOEVER RELATED TO THE CODE, HOWSOEVER CAUSED, EVEN IF MICROCHIP HAS BEEN 
* ADVISED OF THE POSSIBILITY OR THE DAMAGES ARE FORESEEABLE.  TO THE FULLEST EXTENT 
* ALLOWABLE BY LAW, MICROCHIP'S TOTAL LIABILITY ON ALL CLAIMS IN ANY WAY RELATED TO 
* THIS CODE, SHALL NOT EXCEED THE PRICE YOU PAID DIRECTLY TO MICROCHIP SPECIFICALLY TO 
* HAVE THIS CODE DEVELOPED.
*
* You agree that you are solely responsible for testing the code and 
* determining its suitability.  Microchip has no obligation to modify, test, 
* certify, or support the code.
************************************************************************/


	.ifdef __dsPIC30F
	.include "p30Fxxxx.inc"
	.endif
		
	.ifdef __dsPIC33F
	.include "p33Fxxxx.inc"
	.endif
	
	.equ	ADDRESSLOW, 0
	.equ	ADDRESSHIGH, 2
	.equ	BYTEINDICATOR, 4	
	
	.global _PGMemoryOpen
	.global _PGMemoryRead
	
_PGMemoryOpen:
	
	;W0 - pointer to the handle
	;W2,W3 - long pointer to program memory
	
	mov   W0,W4
	mov.w W2, [W0++]	; Assign the lo high adress
	mov.w W3, [W0++]	; Assign the upper address
	clr [W0]		; Clear the byte Indicator
	mov W4, W0		; Pass back the pointer to the handle
	return
	
_PGMemoryRead:

	
	;W0 - points to the handle
	;W1 - destination address
	;W2 - bytes to read
	;W0 - will contain the bytes read on return	
	
	;Sratch
	;W3 - data being read
	;W4 - points to handle
	;W5 - pointer to byte indicator
	;W6 - pointer to higher program memory address
	;W7 - points to lower program memory address

	push 	TBLPAG
	mov 	W0,W4				; W4 point to the  handle
	clr		W0
	mov 	[W4 + ADDRESSHIGH],W6		; Load the TBLPAG register
	mov		W6, TBLPAG
	mov		[W4 + ADDRESSLOW], W7		; Get the lower address in W7
	mov		[W4 + BYTEINDICATOR], W5	; Get the Byte Indicator in W5

read_more:

	cp0		W5				; If byte indicator is 0
	bra		nz, higher_byte			; Yes then read lower byte
	tblrdl	[W7], W3			; Read the lower word in W3
	mov.b	W3,[W1++]			; Transfer to destination	
	inc		W5,W5			; Increment the byte Indicator
	bra		dec_byte_cnt

higher_byte:

	sub		W5,#1,[W15]			; Is it the higher byte
	bra		gt, upper_byte			; No then it must be uppper
	tblrdl	[W7], W3			; Read the lower word in W3
	swap	W3				; Swap bytes 
	mov.b	W3,[W1++]			
	inc		W5,W5

	bra		dec_byte_cnt

upper_byte:

	tblrdh	[W7],W3				; read the upper byte
	mov.b	W3,[W1++]			; store it in destination
	inc2		W7,W7			; Increment it
	clr		W5				; clear byte indicator
	cp0		W7				; Check for rollover
	bra		nz, no_roll_over		; 
	inc		W6,W6				; upper address
	mov		W6, TBLPAG	

dec_byte_cnt:
no_roll_over:
	dec 		W2,W2				;decrement bytes to read count
	inc		W0,W0				; increment bytes read count
	cp0		W2				; have n bytes been read?
	bra		nz,read_more
 	mov		W6,[W4 + ADDRESSHIGH]
	mov		W7,[W4 + ADDRESSLOW]
	mov 	W5,[W4 + BYTEINDICATOR]
	pop 	TBLPAG
	return
	

