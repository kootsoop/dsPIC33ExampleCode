/**********************************************************************
* � 2007 Microchip Technology Inc.
*
* FileName:        ADCChannelDrv.c
* Dependencies:    Header (.h) files if applicable, see below
* Processor:       dsPIC33Fxxxx
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
***************************************************************************/


#include "../h/ADCChannelDrv.h"

static ADCChannelHandle * thisADCChannel;

void ADCChannelInit	(ADCChannelHandle * pHandle,int * pBufferInDMA)
{
	/* This function will intialize the DMA		*/
	/* DMA0 is used to read from the ADC		*/
	

	thisADCChannel = pHandle;
	pHandle->buffer1 	= pBufferInDMA;	/* Assign the ping pong buffers for the ADC DMA*/
	pHandle->buffer2 	= (int *)((int)pBufferInDMA + ADC_BUFFER_SIZE);

	
	DMA0CONbits.SIZE		= 0;		/* Word transfers							*/
	DMA0CONbits.DIR		= 0;		/* From ADC1BUF to DMA					*/
	DMA0CONbits.HALF 	= 0;		/* Interrupt when all the data has been moved	*/
	DMA0CONbits.NULLW 	= 0;		/* No NULL writes - Normal Operation			*/
	DMA0CONbits.AMODE 	= 0;		/* Register Indirect with post-increment mode	*/
	DMA0CONbits.MODE 	= 2;		/* Continuous  ping pong mode enabled		*/
	
	DMA0REQbits.FORCE 	= 0;		/* Automatic transfer				*/
	DMA0REQbits.IRQSEL	= 0xD;	/* ADC conversion complete			*/
	
	DMA0STA	= (int)(pHandle->buffer1) - (int)&_DMA_BASE;
	DMA0STB 	= (int)(pHandle->buffer2) - (int)&_DMA_BASE;
	
	
	DMA0PAD	= (int )&ADC1BUF0;
	DMA0CNT	= ADC_BUFFER_SIZE - 1;

	AD1CON1 	= ADCON1VAL;    /* Load the ADC registers with  value 	*/                            
	AD1CON2 	= ADCON2VAL;    /* specified in 12bitADCDriver.h	*/ 
	AD1CON3 	= ADCON3VAL;                              
	AD1CHS0 	= ADCHSVAL;                              
	AD1PCFGLbits.PCFG0 = 0;
	AD1CSSL 	= ADCSSLVAL;

	TMR3 		= 0;
	PR3		= (ADC_CHANNEL_FCY/ADC_FSAMP) - 1;

}

void ADCChannelStart	(ADCChannelHandle * pHandle)
{
	pHandle->bufferIndicator 	= 0;
	pHandle->isReadBusy 		= 1;
	_DMA0IF = 0;
	_DMA0IE = 1;
	DMA0CONbits.CHEN = 1;		/* Enable the DMA Channel	*/
	AD1CON1bits.ADON = 1;		/* Enable ADC module		*/
	T3CONbits.TON 	 = 1;		/* Enable Timer 3 	    		*/

}

void ADCChannelStop(ADCChannelHandle * pHandle)
{
	_DMA0IE = 0;					/* Disable the DMA interrupt	*/
	DMA0CONbits.CHEN = 0;		/* Disable the DMA Channel	*/
	AD1CON1bits.ADON = 0;		/* Disable ADC module		*/
	T3CONbits.TON 	 = 0;		/* Disable Timer 3 	    		*/
}	

void ADCChannelRead	(ADCChannelHandle * pHandle,int *data,int size)
{
	int	*source;
	int 	i;


	/* if the buffer indicator bit is 1, then use buffer 1 else use buffer2	*/
	/* Since the DMA ping pongs between these buffer, you must know */
	/* which one to read. The bufferIndicators keep track of this		*/
	
	
	source = (pHandle->bufferIndicator) ? pHandle->buffer1 : pHandle->buffer2;
	if (size > ADC_BUFFER_SIZE) size = ADC_BUFFER_SIZE;
	

	
	for(i = 0;i < size;i++)
	{
		data[i] = source[i];
	}
	__asm__ volatile("disi #0x4"); /* disable interrupts */
	pHandle->isReadBusy = 1;
	__asm__ volatile("disi #0x0"); /* enable interrupts */

}

int ADCChannelIsBusy	(ADCChannelHandle * pHandle)
{
	return(pHandle->isReadBusy);
}

void __attribute__((__interrupt__,no_auto_psv)) _DMA0Interrupt(void)
{
 
	_DMA0IF = 0;
	thisADCChannel->bufferIndicator  	^= 1;		/* Flip the indicator bit		*/
	thisADCChannel->isReadBusy		= 0;			/* New frame is available	*/
}
