/**********************************************************************
* © 2007 Microchip Technology Inc.
*
* FileName:        main.c
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

/* This program will program the Introductory speech segment into the
 * serial flash memory. The program starts and the green led will glow.
 * Pressing switch S1 will cause the program and verify operation to 
 * start. The yellow led will glow when this programming takes palce.
 * If the verify fails then red led will glow. If the verify is success
 * then green led will glow */


#include <p33FJ256GP506.h>
#include "../h/sask.h"
#include "../h/SFMDrv.h"
#include "../h/PgmMemory.h"

_FGS(GWRP_OFF & GCP_OFF);
_FOSCSEL(FNOSC_FRC);
_FOSC(FCKSM_CSECMD & OSCIOFNC_ON & POSCMD_NONE);
_FWDT(FWDTEN_OFF);

/* SPEECH_SEGMENT_SIZE - Number of elements in the program memory speech
 * segment array.
 * FLASH_START_WRITE_ADDRESS - Address in Serial Flash Memory where the speech
 * segment will be stored.
 * */

#define SPEECH_SEGMENT_SIZE   		98049L	
#define FLASH_START_WRITE_ADDRESS	0x0		

/* Serial Flash Driver Buffer	*/
char flashMemoryBuffer[SFMDRV_BUFFER_SIZE];

/* Program Memory Reader */
ProgramMemory PGMReader;

/* This is a pointer to the speech segment in the
 * program memory. Note how it is declared as a 
 * void function. The pointer to this function is 
 * the start address of the speech segment.
 * */

extern 	 void 	SpeechSegment();

int main (void)
{

	/* flashWriteAddress - Tracks the current flash write address
	 * flashReadAddress - Tracks the current flash read address 
	 * PGMReaderHandle - Handle to the Program Memory Reader 
	 * bytesRead - tracks the number of bytes processed.
	 * dataByte - byte read from program flash
	 * verifyByte - byte read from serial flash
	 * */

	unsigned long	flashWriteAddress;		
	unsigned long	flashReadAddress;		
	unsigned long	bytesRead;
	char			dataByte;
	char			verifyByte;
	ProgramMemory * PGMReaderHandle;


	/* Configure Oscillator to operate the device at 40MHz.
	 * Fosc= Fin*M/(N1*N2), Fcy=Fosc/2
	 * Fosc= 7.37M*43/(2*2) = approx 80Mhz for 7.37M input clock 
	 * */

	PLLFBD=41;				/* M=43	*/
	CLKDIVbits.PLLPOST=0;	/* N1=2	*/
	CLKDIVbits.PLLPRE=0;	/* N2=2	*/
	OSCTUN=0;			

	/*	Initiate Clock Switch to FRC with PLL (NOSC=0b001)
	 *	and wait for clock switch to occur.
	 *	*/
	
	__builtin_write_OSCCONH(0x01);		
	__builtin_write_OSCCONL(0x01);
	while (OSCCONbits.COSC != 0b01);	
	while(!OSCCONbits.LOCK);

	/* Initialize the board, start 
	 * the serial flash memory driver and
	 * initialize the Program Memory Reader	
	 * */
	
	SASKInit();
	SFMInit(flashMemoryBuffer);
	PGMReaderHandle = PGMemoryOpen(&PGMReader,(long)SpeechSegment);

	/* Intialize the flash start address. Turn
	 * on the Green LED and then wait for the 
	 * S1 to be pressed. Pressing S1 will cause
	 * the programming to start. 
	 * */

	GREEN_LED = SASK_LED_ON;
	while(CheckSwitchS1() == 0);

	/* Turn on Yellow LED, turn off Green LED.
	 * Unprotect the flash.
	 * Erase the flash. Read the program memory
	 * and then program the serial flash memory
	 * */	

	GREEN_LED = SASK_LED_OFF;
	YELLOW_LED = SASK_LED_ON;
	SFMChipErase();


	/* Read the dsPIC33F program flash and program 
	 * serial flash. Read and write one byte at a time.  
	 * */
	
	flashWriteAddress = FLASH_START_WRITE_ADDRESS;
	bytesRead = 0;
	while (bytesRead <= SPEECH_SEGMENT_SIZE)
	{
		bytesRead += PGMemoryRead(PGMReaderHandle,&dataByte,1);
		flashWriteAddress += SFMWrite(flashWriteAddress,&dataByte,1);
	}
	
	/* Programming is complete at this point. Now
	 * verify the programming operation. Re-open the
	 * PGMReader. This will reset the stream pointer
	 * to the start of the stream. Each byte from the
	 * serial flash memory is compared with the speech
	 * segment in the program memory. If the verify 
	 * fails, the Red LED is turned on and code will
	 * wait in an endless while loop. 
	 * */

	flashReadAddress = FLASH_START_WRITE_ADDRESS;
	PGMReaderHandle = PGMemoryOpen(&PGMReader,(long)SpeechSegment);
	bytesRead = 0;

	while (bytesRead <= SPEECH_SEGMENT_SIZE)
	{
		bytesRead += PGMemoryRead(PGMReaderHandle,&dataByte,1);
		flashReadAddress += SFMRead(flashReadAddress,&verifyByte,1);
		if(verifyByte != dataByte)
		{
			RED_LED = SASK_LED_ON;
			YELLOW_LED = SASK_LED_OFF;
			while(1);
		}
	}

	/* At this point the program and verify operation
	 * was successful. Switch on the Green LED and then
	 * wait in an endless loop.
	 * */

	YELLOW_LED = SASK_LED_OFF;
	GREEN_LED = SASK_LED_ON;
	while(1);


}
			
		
	

		



