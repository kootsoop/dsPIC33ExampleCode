#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-default.mk)" "nbproject/Makefile-local-default.mk"
include nbproject/Makefile-local-default.mk
endif
endif

# Environment
MKDIR=mkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=elf
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/SASK_Intro_Speech_Prog.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/SASK_Intro_Speech_Prog.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

ifeq ($(COMPARE_BUILD), true)
COMPARISON_BUILD=-mafrlcsj
else
COMPARISON_BUILD=
endif

ifdef SUB_IMAGE_ADDRESS
SUB_IMAGE_ADDRESS_COMMAND=--image-address $(SUB_IMAGE_ADDRESS)
else
SUB_IMAGE_ADDRESS_COMMAND=
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=../src/main.c ../src/sask.c ../src/Segment.s ../src/PgmMemory.s ../src/SST25VF040BDrv.s ../src/SFMDrv.c ../src/AT25F4096Drv.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/_ext/1360937237/main.o ${OBJECTDIR}/_ext/1360937237/sask.o ${OBJECTDIR}/_ext/1360937237/Segment.o ${OBJECTDIR}/_ext/1360937237/PgmMemory.o ${OBJECTDIR}/_ext/1360937237/SST25VF040BDrv.o ${OBJECTDIR}/_ext/1360937237/SFMDrv.o ${OBJECTDIR}/_ext/1360937237/AT25F4096Drv.o
POSSIBLE_DEPFILES=${OBJECTDIR}/_ext/1360937237/main.o.d ${OBJECTDIR}/_ext/1360937237/sask.o.d ${OBJECTDIR}/_ext/1360937237/Segment.o.d ${OBJECTDIR}/_ext/1360937237/PgmMemory.o.d ${OBJECTDIR}/_ext/1360937237/SST25VF040BDrv.o.d ${OBJECTDIR}/_ext/1360937237/SFMDrv.o.d ${OBJECTDIR}/_ext/1360937237/AT25F4096Drv.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/_ext/1360937237/main.o ${OBJECTDIR}/_ext/1360937237/sask.o ${OBJECTDIR}/_ext/1360937237/Segment.o ${OBJECTDIR}/_ext/1360937237/PgmMemory.o ${OBJECTDIR}/_ext/1360937237/SST25VF040BDrv.o ${OBJECTDIR}/_ext/1360937237/SFMDrv.o ${OBJECTDIR}/_ext/1360937237/AT25F4096Drv.o

# Source Files
SOURCEFILES=../src/main.c ../src/sask.c ../src/Segment.s ../src/PgmMemory.s ../src/SST25VF040BDrv.s ../src/SFMDrv.c ../src/AT25F4096Drv.c



CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/SASK_Intro_Speech_Prog.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=33FJ256GP506
MP_LINKER_FILE_OPTION=,--script=p33FJ256GP506.gld
# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/1360937237/main.o: ../src/main.c  .generated_files/flags/default/5d72c6f71c983c87bf440067fd3cf130bccef3e4 .generated_files/flags/default/4c05857b171e28a8b2b779e9359b91eac0053885
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/main.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/main.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/main.c  -o ${OBJECTDIR}/_ext/1360937237/main.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/main.o.d"      -g -D__DEBUG     -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -mlarge-data -O0 -I"../h" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360937237/sask.o: ../src/sask.c  .generated_files/flags/default/3f4ec93a21b2aee1e8b7ea3b28c99c8f1e867958 .generated_files/flags/default/4c05857b171e28a8b2b779e9359b91eac0053885
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/sask.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/sask.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/sask.c  -o ${OBJECTDIR}/_ext/1360937237/sask.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/sask.o.d"      -g -D__DEBUG     -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -mlarge-data -O0 -I"../h" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360937237/SFMDrv.o: ../src/SFMDrv.c  .generated_files/flags/default/388ed7d052cf38bfb82dc64af418ed4bba50d7ce .generated_files/flags/default/4c05857b171e28a8b2b779e9359b91eac0053885
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/SFMDrv.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/SFMDrv.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/SFMDrv.c  -o ${OBJECTDIR}/_ext/1360937237/SFMDrv.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/SFMDrv.o.d"      -g -D__DEBUG     -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -mlarge-data -O0 -I"../h" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360937237/AT25F4096Drv.o: ../src/AT25F4096Drv.c  .generated_files/flags/default/40081b10c6e3596c124d1d471b56995b234b1a21 .generated_files/flags/default/4c05857b171e28a8b2b779e9359b91eac0053885
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/AT25F4096Drv.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/AT25F4096Drv.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/AT25F4096Drv.c  -o ${OBJECTDIR}/_ext/1360937237/AT25F4096Drv.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/AT25F4096Drv.o.d"      -g -D__DEBUG     -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -mlarge-data -O0 -I"../h" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
else
${OBJECTDIR}/_ext/1360937237/main.o: ../src/main.c  .generated_files/flags/default/236707112a61ff702d416c2d894056ac956299e7 .generated_files/flags/default/4c05857b171e28a8b2b779e9359b91eac0053885
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/main.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/main.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/main.c  -o ${OBJECTDIR}/_ext/1360937237/main.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/main.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -mlarge-data -O0 -I"../h" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360937237/sask.o: ../src/sask.c  .generated_files/flags/default/e03cd3bab2e6a3a0d52d64396bc1f49147d0806d .generated_files/flags/default/4c05857b171e28a8b2b779e9359b91eac0053885
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/sask.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/sask.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/sask.c  -o ${OBJECTDIR}/_ext/1360937237/sask.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/sask.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -mlarge-data -O0 -I"../h" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360937237/SFMDrv.o: ../src/SFMDrv.c  .generated_files/flags/default/a3923cb5ff4354a921365a135e74a2680ac53f8e .generated_files/flags/default/4c05857b171e28a8b2b779e9359b91eac0053885
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/SFMDrv.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/SFMDrv.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/SFMDrv.c  -o ${OBJECTDIR}/_ext/1360937237/SFMDrv.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/SFMDrv.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -mlarge-data -O0 -I"../h" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360937237/AT25F4096Drv.o: ../src/AT25F4096Drv.c  .generated_files/flags/default/58a22a068b3811685a43083b0746ad64865264e8 .generated_files/flags/default/4c05857b171e28a8b2b779e9359b91eac0053885
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/AT25F4096Drv.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/AT25F4096Drv.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/AT25F4096Drv.c  -o ${OBJECTDIR}/_ext/1360937237/AT25F4096Drv.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/AT25F4096Drv.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mlarge-code -mlarge-data -O0 -I"../h" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/1360937237/Segment.o: ../src/Segment.s  .generated_files/flags/default/2065c26bdb7dcf23048e90ccb30280a3a7771188 .generated_files/flags/default/4c05857b171e28a8b2b779e9359b91eac0053885
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/Segment.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/Segment.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../src/Segment.s  -o ${OBJECTDIR}/_ext/1360937237/Segment.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  -I".." -I"." -Wa,-MD,"${OBJECTDIR}/_ext/1360937237/Segment.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax,-g$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360937237/PgmMemory.o: ../src/PgmMemory.s  .generated_files/flags/default/6b67997271a0bf3238d51b0bf2280f869080199 .generated_files/flags/default/4c05857b171e28a8b2b779e9359b91eac0053885
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/PgmMemory.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/PgmMemory.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../src/PgmMemory.s  -o ${OBJECTDIR}/_ext/1360937237/PgmMemory.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  -I".." -I"." -Wa,-MD,"${OBJECTDIR}/_ext/1360937237/PgmMemory.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax,-g$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360937237/SST25VF040BDrv.o: ../src/SST25VF040BDrv.s  .generated_files/flags/default/1150c6c73d58c102e0dc7720e962c49d9d7bdf33 .generated_files/flags/default/4c05857b171e28a8b2b779e9359b91eac0053885
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/SST25VF040BDrv.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/SST25VF040BDrv.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../src/SST25VF040BDrv.s  -o ${OBJECTDIR}/_ext/1360937237/SST25VF040BDrv.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  -I".." -I"." -Wa,-MD,"${OBJECTDIR}/_ext/1360937237/SST25VF040BDrv.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax,-g$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
else
${OBJECTDIR}/_ext/1360937237/Segment.o: ../src/Segment.s  .generated_files/flags/default/b0c6c7adbacb416f4ca20ff4277195bc1f6b2a92 .generated_files/flags/default/4c05857b171e28a8b2b779e9359b91eac0053885
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/Segment.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/Segment.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../src/Segment.s  -o ${OBJECTDIR}/_ext/1360937237/Segment.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  -I".." -I"." -Wa,-MD,"${OBJECTDIR}/_ext/1360937237/Segment.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax,-g$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360937237/PgmMemory.o: ../src/PgmMemory.s  .generated_files/flags/default/696eb1765b6fd2c8a7d21946c20b33907f2652e2 .generated_files/flags/default/4c05857b171e28a8b2b779e9359b91eac0053885
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/PgmMemory.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/PgmMemory.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../src/PgmMemory.s  -o ${OBJECTDIR}/_ext/1360937237/PgmMemory.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  -I".." -I"." -Wa,-MD,"${OBJECTDIR}/_ext/1360937237/PgmMemory.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax,-g$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360937237/SST25VF040BDrv.o: ../src/SST25VF040BDrv.s  .generated_files/flags/default/d73bbe7e258e2a4f75415218dc9ec84b90217be1 .generated_files/flags/default/4c05857b171e28a8b2b779e9359b91eac0053885
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/SST25VF040BDrv.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/SST25VF040BDrv.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../src/SST25VF040BDrv.s  -o ${OBJECTDIR}/_ext/1360937237/SST25VF040BDrv.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  -I".." -I"." -Wa,-MD,"${OBJECTDIR}/_ext/1360937237/SST25VF040BDrv.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax,-g$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemblePreproc
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/SASK_Intro_Speech_Prog.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -o dist/${CND_CONF}/${IMAGE_TYPE}/SASK_Intro_Speech_Prog.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}      -mcpu=$(MP_PROCESSOR_OPTION)        -D__DEBUG=__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)      -Wl,,,--defsym=__MPLAB_BUILD=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,-D__DEBUG=__DEBUG,,$(MP_LINKER_FILE_OPTION),--stack=16,--check-sections,--data-init,--pack-data,--handles,--isr,--no-gc-sections,--fill-upper=0,--stackguard=16,--library-path="..",--library-path=".",--no-force-link,--smart-io,-Map="${DISTDIR}/SASK_Intro_Speech_Prog.X.${IMAGE_TYPE}.map",--report-mem,--memorysummary,dist/${CND_CONF}/${IMAGE_TYPE}/memoryfile.xml$(MP_EXTRA_LD_POST)  -mdfp="${DFP_DIR}/xc16" 
	
else
dist/${CND_CONF}/${IMAGE_TYPE}/SASK_Intro_Speech_Prog.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -o dist/${CND_CONF}/${IMAGE_TYPE}/SASK_Intro_Speech_Prog.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}      -mcpu=$(MP_PROCESSOR_OPTION)        -omf=elf -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -Wl,,,--defsym=__MPLAB_BUILD=1,$(MP_LINKER_FILE_OPTION),--stack=16,--check-sections,--data-init,--pack-data,--handles,--isr,--no-gc-sections,--fill-upper=0,--stackguard=16,--library-path="..",--library-path=".",--no-force-link,--smart-io,-Map="${DISTDIR}/SASK_Intro_Speech_Prog.X.${IMAGE_TYPE}.map",--report-mem,--memorysummary,dist/${CND_CONF}/${IMAGE_TYPE}/memoryfile.xml$(MP_EXTRA_LD_POST)  -mdfp="${DFP_DIR}/xc16" 
	${MP_CC_DIR}/xc16-bin2hex dist/${CND_CONF}/${IMAGE_TYPE}/SASK_Intro_Speech_Prog.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} -a  -omf=elf   -mdfp="${DFP_DIR}/xc16" 
	
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r build/default
	${RM} -r dist/default

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell "${PATH_TO_IDE_BIN}"mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
