/**********************************************************************
* � 2007 Microchip Technology Inc.
*
* FileName:        OCPWMDrv.c
* Dependencies:    Header (.h) files if applicable, see below
* Processor:       dsPIC33FJ256GP506
* Compiler:        MPLAB� C30 v3.00 or higher
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
#include "../h/OCPWMDrv.h"

static OCPWMHandle * thisOCPWM;


void OCPWMInit	(OCPWMHandle * pHandle,int * pBufferInDMA)
{
	/* This function will intialize the DMA		*/
	/* DMA1 is used to write to  from the OC1RS		*/

	

	thisOCPWM = pHandle;
	pHandle->buffer1 	= pBufferInDMA;	/* Assign the ping pong buffers */
	pHandle->buffer2 	=(int *) (pBufferInDMA) +  OCPWM_FRAME_SIZE;
	
	
	DMA1CON = 0x2011;	/* Word transfers								*/
						/* From DMA to OC1RS							*/
						/* Interrupt when all the data has been moved		*/
						/* No NULL writes - Normal Operation				*/
						/* Register Indirect with no post-increment mode	*/
						/* Single shot no  ping pong mode 				*/
			
	
	DMA1REQ= 0x7;	/* Timer 2 Interrupt*/
	
	DMA1STA	= (int)(pHandle->buffer1) - (int)&_DMA_BASE;
		
	DMA1PAD	= (int )&OC1RS;
	DMA1CNT	=  OCPWM_FPWM_FSAMP_RATIO - 1;

	T2CON	= 0;
	TMR2	= 0;
	PR2	= 0;	
}
 
void OCPWMStart	(OCPWMHandle * pHandle)
{
	pHandle-> bufferIndicator= 0;
	pHandle-> currentSampleIndex = 0;
	pHandle-> currentFrameSize = OCPWM_FRAME_SIZE;
	pHandle-> newFrameSize = OCPWM_FRAME_SIZE;
	pHandle-> isWriteBusy 	= 0;
	_DMA1IF 				= 0;
	_DMA1IE 				= 1;
	DMA1CONbits.CHEN 	= 1;					/* Enable the DMA Channel	*/

	PR2				= OCPWM_MAX_PWM_PERIOD;		/* PWM Period			*/
	OC1RS			= ((OCPWM_MAX_PWM_PERIOD)/2);	/* Initial Duty Cycle at 50% 	*/
	OC1R			= ((OCPWM_MAX_PWM_PERIOD)/2);
	OC1CON			= OCPWM_OCCON_WORD;			/* Turn module on		*/
	T2CONbits.TON	= 1;						/* Enable Timer2		*/
	
	
}

void OCPWMStop(OCPWMHandle * pHandle)
{
	T2CONbits.TON	= 0;						/* Enable Timer2		*/
	_DMA1IE 				= 0;
	DMA1CONbits.CHEN 	= 0;					/* Enable the DMA Channel	*/
	
}

void OCPWMWrite	(OCPWMHandle * pHandle,int *data,int size)
{
	int *dest;
	int 	i;

	unsigned int sample;
	unsigned int pwmDutyCycle;

	/* if the buffer indicator bit is 1, then write buffer 1 else use buffer2	*/
	/* Since the DMA ping pongs between these buffer, you must know */
	/* which one to read. The bufferIndicators keep track of this		*/
	
	dest = (pHandle->bufferIndicator) ? pHandle->buffer1 : pHandle->buffer2;
	if (size >OCPWM_FRAME_SIZE)
	{
		 size = OCPWM_FRAME_SIZE;
	}

	for(i = 0;i < size ; i++)
	{
		/* Compute Duty cycle values for every input sample	*/
		sample = data[i] - (OCPWM_LOWEST_INPUT_VALUE);
		pwmDutyCycle = ((sample * OCPWM_MAX_PWM_PERIOD))/OCPWM_INPUT_RANGE;
		if ( pwmDutyCycle > OCPWM_MAX_PWM_PERIOD )
		{
			 pwmDutyCycle = OCPWM_MAX_PWM_PERIOD - 1;
		
		}
		
		if ( pwmDutyCycle <= 0)
		{
			 pwmDutyCycle = 1;	/* Boundary condition	*/
		}
		
		dest[i] = pwmDutyCycle;
	}
	
	pHandle->newFrameSize = size;	/* Update the frame size	*/
	
	__asm__ volatile("disi #0x4");	 /* disable Interrupts */
	pHandle->isWriteBusy = 1;
	__asm__ volatile("disi #0x0"); 	/* enable Interrupts */

}

int OCPWMIsBusy	(OCPWMHandle * pHandle)
{
	return(pHandle->isWriteBusy);

}

void __attribute__((__interrupt__,no_auto_psv)) _DMA1Interrupt(void)
{


	_DMA1IF = 0;
	thisOCPWM->currentSampleIndex++;	
	if (thisOCPWM->currentSampleIndex == thisOCPWM->currentFrameSize)
	{
		/* Completed playback of one frame	*/
		
		thisOCPWM->currentSampleIndex = 0;		/* Reset the sample count	*/
		thisOCPWM->bufferIndicator		^= 1;		/* Flip the indicator bit		*/
		thisOCPWM->isWriteBusy		= 0;			/* New frame is available	*/
		if(thisOCPWM->bufferIndicator == 1)
		{
			DMA1STA = (int)(thisOCPWM->buffer2) - (int)&_DMA_BASE;
		}else
		{
			DMA1STA = (int)(thisOCPWM->buffer1) - (int)&_DMA_BASE;
		}
		thisOCPWM->currentFrameSize = 	thisOCPWM->newFrameSize;

	}
	else
	{
		/*Completed playback of one	 sample	*/
		
		DMA1STA += 2;
		
	}
	DMA1CONbits.CHEN = 1;	

	
}
