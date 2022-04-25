/**********************************************************************
* © 2007 Microchip Technology Inc.
*
* FileName:        SST25VF040BDrv.c
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

#include "..\h\SST25VF040BDrv.h"

/********************************************
 * Function: SST25VF040Write
 * Input:
 * pHandle - Pointer to the initialized SFM DS
 * address - 24 bit destination SFM address 
 * data - pointer to data to write.
 * count - number of bytes to writes
 * Description:
 * This function will write data to the SFM at
 * address specified by address. Function is 
 * blocking. This is wrapper function
 * Return:
 * Number of byte written
 **********************************************/ 

int SST25VF040BWrite(SST25VF040BHandle * pFlashMemoryHandle, 
		long address,char * data, int count)
{
	unsigned long written = 0;
	
	while(written < count)
	{
		written += SST25VF040B_write(pFlashMemoryHandle,
		(address + written),(char *)(data + written), (count - written));
	}
	
	return(count);
}					

/********************************************
 * Function: SST25VF040BRead
 * Input:
 * pHandle - Pointer to the initialized SFM DS
 * address - 24 bit source SFM address 
 * data - pointer to destination array.
 * count - number of bytes to read
 * Description:
 * This function will read data from the SFM from
 * address specified by address. Function is 
 * blocking. This is wrapper function
 * Return:
 * Number of bytes read.
 **********************************************/  
 			
int SST25VF040BRead(SST25VF040BHandle * pFlashMemoryHandle, 
		long address,char * data, int count)
{
	int read = 0;
	
	while(read < count)
	{
		read += SST25VF040B_read(pFlashMemoryHandle,
		(address + read), (char *)(data + read),(count - read));
	}
	
	return(count);
		
}	
