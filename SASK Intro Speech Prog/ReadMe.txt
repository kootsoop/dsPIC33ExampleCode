
		Readme File for Code Example:
              MPLAB Starter kit for dsPIC DSC
			Flash Fill Utility
             ----------------------------------------

This file contains the following sections:
1. Code Example Description
2. Folder Contents
3. Suggested Development Resources
4. Revision History


1. Code Example Description:
----------------------------
This code will run on the MPLAB Starter Kit for dsPIC DSC. It programs the
introductory speech greeting into the serial flash device.

Refer to the MPLAB Starter Kit for dsPIC DSC User Guide for more details on the
starter Kit. 

Open the MPLAB workspace, compile the code, program the dsPIC and execute.

1. The GREEN LED will glow. Press switch S1. 
2. The YELLOW LED will turn on.The introductory speech message will be 
programmed and verified. 
3. If the program and verify operation fails, the RED LED will turn ON
If the operation passes, then GREEN LED will turn ON.

Speech data is stored in "Segment.s". To change the speech file, 
1. Add the new speech file to the project.
2. Ensure that the speech segment address label name is SpeechSegment.
3. Set SPEECH_SEGMENT_SIZE in main.c to be the number of data elements in the
speech segment. 
4. Set FLASH_START_WRITE_ADDRESS to a value from where the writing should start


2. Folder Contents:
-------------------
This project folder contains the following sub-folders:

a. h
        This folder contains include files for the code example.


b. src
        This folder contains all the C and Assembler source files (*.c,
        *.s) used in demonstrating the described example. The folder also 
	contains the speech segment (Segment.s). 

3. Required Development Resources:
-----------------------------------
        a. MPLAB Starter Kit for dsPIC DSC.


4. Revision History :
---------------------
        11/20/2008 - Initial Release of the Code Example
		01/08/2009 - Second release of code example. Added support
					for SST25VF040B flash device. Added switch function
					to start the programming.
