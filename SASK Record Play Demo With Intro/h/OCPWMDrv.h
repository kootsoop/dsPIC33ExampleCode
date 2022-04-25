/**********************************************************************
* © 2007 Microchip Technology Inc.
*
* FileName:        OCPWMDRV.h
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

#ifndef __OCPWMDRV_H__
#define __OCPWMDRV_H__
#include <p33Fxxxx.h>



#define OCPWM_FCY					40000000
#define OCPWM_FPWM					64000
#define OCPWM_FSAMP				8000					/* Sampling Frequency	*/
#define OCPWM_FPWM_FSAMP_RATIO 	(OCPWM_FPWM/OCPWM_FSAMP)
#define OCPWM_FRAME_SIZE			128						/* This is the size of each buffer	*/
#define OCPWM_DMA_BUFSIZE 			(2*OCPWM_FRAME_SIZE)	

#define OCPWM_OCCON_WORD			0x0006	
#define OCPWM_HIGHEST_INPUT_VALUE	32767
#define OCPWM_LOWEST_INPUT_VALUE	-32768
#define OCPWM_INPUT_RANGE			(OCPWM_HIGHEST_INPUT_VALUE - (OCPWM_LOWEST_INPUT_VALUE))
#define OCPWM_PWM_FACTOR			(OCPWM_MAX_PWM_PERIOD/OCPWM_INPUT_RANGE)
#define OCPWM_TMRPRESCALE 			1
#define OCPWM_MAX_PWM_PERIOD		(((OCPWM_FCY/OCPWM_FPWM)*OCPWM_TMRPRESCALE) - 1)

typedef struct sOCPWMHandle {

	int * buffer1;					/* Pointer to the Ping Pong buffer 1	*/
	int * buffer2;					/* Pointer to the Ping Pong buffer 2	*/
	volatile int bufferIndicator;		/* Indicates which ping pong buffer is being proceesed	*/
	volatile int isWriteBusy;		/* Is set if both the ping pong buffers are in use	*/
	int currentFrameSize;			/* Size of the frame being played				*/
	int newFrameSize;				/* Size of the next frame to be played			*/
	int currentSampleIndex;		/* Tracks the sample being played right now	*/
	
}OCPWMHandle;

void OCPWMInit	(OCPWMHandle * pHandle,int * pBufferInDMA);
void OCPWMStart	(OCPWMHandle * pHandle);
void OCPWMWrite	(OCPWMHandle * pHandle,int *buffer,int size);
int OCPWMIsBusy	(OCPWMHandle * pHandle);
void OCPWMStop	(OCPWMHandle * pHandle);


#endif


