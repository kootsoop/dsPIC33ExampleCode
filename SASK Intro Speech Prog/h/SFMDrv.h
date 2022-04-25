/**********************************************************************
* © 2007 Microchip Technology Inc.
*
* FileName:        SFMDrv.h
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

#ifndef _SFMDRV_H_
#define _SFMDRV_H_

#include "../h/AT25F4096Drv.h"
#include "../h/SST25VF040BDrv.h"

#define ATSFM 0
#define SSTSFM 1
#define SFM_LAST_ADDRESS 0x7FFFF

#if(AT25F4096DRV_BUFFER_SIZE >  SST25VF040BDRV_BUFFER_SIZE)
	#define SFMDRV_BUFFER_SIZE AT25F4096DRV_BUFFER_SIZE
#else
	#define SFMDRV_BUFFER_SIZE SST25VF040BDRV_BUFFER_SIZE
#endif

/***********************************************
 * Function - SFMInit
 * Arguments: char type array to be used by the 
 * driver for internal buffer.
 * Description: This function will intialize the 
 * SFM driver structure and the SPI module. It will
 * detect the SFM being used and will internally 
 * register the SFM type being used on the board
 * Return Value - None
 * *********************************************/

void SFMInit(char * flashMemoryBuffer);


/***********************************************
 * Function - SFMChipErase
 * Arguments: None
 * Description: This function will erase the SFM.
 * The function is blocking and will return when 
 * chip erase is complete
 * Return Value - None
 * *********************************************/

void SFMChipErase(void);


/***********************************************
 * Function - SFMBlockErase
 * Arguments: 
 * address - address of block to delete
 * Description: This function will delete a 64K 
 * SFM block.
 * Return Value - none.
 * *********************************************/

void SFMBlockErase(long address);


/***********************************************
 * Function - SFMWrite
 * Arguments:
 * address - SFM destination address 
 * data - byte pointer to source data
 * count - number of bytes to write
 * Description: This function will write count
 * bytes from the data array to the SFM destination
 * address. Function is blocking.
 * Return Value - Number of bytes written
 * *********************************************/

int SFMWrite(long address, char * data, int count);


/***********************************************
 * Function - SFMRead
 * Arguments:
 * address - SFM source addres
 * data - byte pointer to destination buffer
 * count - number of bytes to read
 * Description: This function will read count
 * bytes of data from the SFM address and store
 * it in data buffer
 * Return Value - number of bytes read
 * *********************************************/

int SFMRead(long address, char * data, int count);

#endif
