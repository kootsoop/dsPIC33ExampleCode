/**********************************************************************
* © 2007 Microchip Technology Inc.
*
* FileName:        memory.s
* Dependencies:    Header (.h) files if applicable, see below
* Processor:       dsPIC33FJ256GP506
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

.global	_ReadProgramMemory
.global 	_ReadProgramMemoryWord

	;W1 - Contains bits 23-16 of program address 
	;W0 - Contains bits 15-0  of program address 
	;W2 - Contains the destination data address
	;W3 - Contains the number of bytes to transfer
	;W4 - Scratch register

.text
_ReadProgramMemory:

	push 		TBLPAG
once_again:
	mov			W1,TBLPAG			; The upper 8 bits of program address
	tblrdl		[W0],W4				; The lower 16 bits are already in W0
	mov.b		W4,[W2++]			; Store the lowest byte
	swap		W4					;
	mov.b		W4,[W2++]			;Store the higher byte
	tblrdh		[W0++],W4			; Read the upper byte
	mov.b		W4,[W2++]		; Store the upper byter
	cp0			W0					; Check if a page boundary has been crossed
	bra			nz, same_page		; No then proceed as normal	
	inc			W1,W1				; else increment the psv pag
same_page:
	dec2		W3,W3				; decrement count by 2 
	dec			W3,W3
	bra			nz, once_again		; continue till count is zero
	pop			TBLPAG
	return

_ReadProgramMemoryWord:

	push	TBLPAG
	mov		W1,TBLPAG
	tblrdl	[W0],W4
	mov.b	W4,[W2++]
	swap	W4
	mov.b	W4,[W2++]
	tblrdh	[W0],W4
	mov	W4,[W2]
	pop	TBLPAG
	return
	.end
	
	
	
	

	
	
