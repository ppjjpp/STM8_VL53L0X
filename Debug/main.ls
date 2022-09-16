   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.6 - 16 Dec 2021
   3                     ; Generator (Limited) V4.5.4 - 16 Dec 2021
  80                     ; 6 u8 I2C_ByteRead(uint8_t I2C_Slave_Address, uint8_t ReadAddr)
  80                     ; 7 {
  82                     	switch	.text
  83  0000               _I2C_ByteRead:
  85  0000 89            	pushw	x
  86  0001 89            	pushw	x
  87       00000002      OFST:	set	2
  90  0002               L14:
  91                     ; 9   while(I2C_GetFlagStatus(I2C_FLAG_BUSBUSY));
  93  0002 ae0302        	ldw	x,#770
  94  0005 cd0000        	call	_I2C_GetFlagStatus
  96  0008 4d            	tnz	a
  97  0009 26f7          	jrne	L14
  98                     ; 10   I2C_GenerateSTART(ENABLE);
 100  000b a601          	ld	a,#1
 101  000d cd0000        	call	_I2C_GenerateSTART
 104  0010               L74:
 105                     ; 11   while(!I2C_CheckEvent(I2C_EVENT_MASTER_MODE_SELECT));
 107  0010 ae0301        	ldw	x,#769
 108  0013 cd0000        	call	_I2C_CheckEvent
 110  0016 4d            	tnz	a
 111  0017 27f7          	jreq	L74
 112                     ; 12   I2C_Send7bitAddress(I2C_Slave_Address, I2C_DIRECTION_TX);
 114  0019 7b03          	ld	a,(OFST+1,sp)
 115  001b 5f            	clrw	x
 116  001c 95            	ld	xh,a
 117  001d cd0000        	call	_I2C_Send7bitAddress
 120  0020               L55:
 121                     ; 13   while(!I2C_CheckEvent(I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED));
 123  0020 ae0782        	ldw	x,#1922
 124  0023 cd0000        	call	_I2C_CheckEvent
 126  0026 4d            	tnz	a
 127  0027 27f7          	jreq	L55
 128                     ; 14   I2C_SendData((u8)(ReadAddr));
 130  0029 7b04          	ld	a,(OFST+2,sp)
 131  002b cd0000        	call	_I2C_SendData
 134  002e               L36:
 135                     ; 15 	while(!I2C_CheckEvent(I2C_EVENT_MASTER_BYTE_TRANSMITTED));
 137  002e ae0784        	ldw	x,#1924
 138  0031 cd0000        	call	_I2C_CheckEvent
 140  0034 4d            	tnz	a
 141  0035 27f7          	jreq	L36
 142                     ; 16 	I2C_GenerateSTART(ENABLE);
 144  0037 a601          	ld	a,#1
 145  0039 cd0000        	call	_I2C_GenerateSTART
 148  003c               L17:
 149                     ; 17 	while(!I2C_CheckEvent(I2C_EVENT_MASTER_MODE_SELECT));
 151  003c ae0301        	ldw	x,#769
 152  003f cd0000        	call	_I2C_CheckEvent
 154  0042 4d            	tnz	a
 155  0043 27f7          	jreq	L17
 156                     ; 18 	I2C_Send7bitAddress(I2C_Slave_Address, I2C_DIRECTION_RX);
 158  0045 7b03          	ld	a,(OFST+1,sp)
 159  0047 ae0001        	ldw	x,#1
 160  004a 95            	ld	xh,a
 161  004b cd0000        	call	_I2C_Send7bitAddress
 164  004e               L77:
 165                     ; 19 	while(!I2C_CheckEvent(I2C_EVENT_MASTER_RECEIVER_MODE_SELECTED));
 167  004e ae0302        	ldw	x,#770
 168  0051 cd0000        	call	_I2C_CheckEvent
 170  0054 4d            	tnz	a
 171  0055 27f7          	jreq	L77
 173  0057               L501:
 174                     ; 20 	while(!I2C_CheckEvent(I2C_EVENT_MASTER_BYTE_RECEIVED));
 176  0057 ae0340        	ldw	x,#832
 177  005a cd0000        	call	_I2C_CheckEvent
 179  005d 4d            	tnz	a
 180  005e 27f7          	jreq	L501
 181                     ; 21 	pBuffer = I2C_ReceiveData();
 183  0060 cd0000        	call	_I2C_ReceiveData
 185  0063 5f            	clrw	x
 186  0064 97            	ld	xl,a
 187  0065 1f01          	ldw	(OFST-1,sp),x
 189                     ; 22 	I2C_AcknowledgeConfig(I2C_ACK_NONE);
 191  0067 4f            	clr	a
 192  0068 cd0000        	call	_I2C_AcknowledgeConfig
 194                     ; 23 	I2C_GenerateSTOP(ENABLE);
 196  006b a601          	ld	a,#1
 197  006d cd0000        	call	_I2C_GenerateSTOP
 199                     ; 24 	return pBuffer;
 201  0070 7b02          	ld	a,(OFST+0,sp)
 204  0072 5b04          	addw	sp,#4
 205  0074 81            	ret
 253                     ; 28 void I2C_ByteWrite (u8 I2C_Slave_Address, u8 iData)
 253                     ; 29 {
 254                     	switch	.text
 255  0075               _I2C_ByteWrite:
 257  0075 89            	pushw	x
 258       00000000      OFST:	set	0
 261                     ; 30 	I2C_GenerateSTART(ENABLE);
 263  0076 a601          	ld	a,#1
 264  0078 cd0000        	call	_I2C_GenerateSTART
 267  007b               L531:
 268                     ; 31   while(!I2C_CheckEvent(I2C_EVENT_MASTER_MODE_SELECT));
 270  007b ae0301        	ldw	x,#769
 271  007e cd0000        	call	_I2C_CheckEvent
 273  0081 4d            	tnz	a
 274  0082 27f7          	jreq	L531
 275                     ; 32   I2C_Send7bitAddress(I2C_Slave_Address, I2C_DIRECTION_TX);
 277  0084 7b01          	ld	a,(OFST+1,sp)
 278  0086 5f            	clrw	x
 279  0087 95            	ld	xh,a
 280  0088 cd0000        	call	_I2C_Send7bitAddress
 283  008b 2005          	jra	L341
 284  008d               L141:
 285                     ; 34   I2C_SendData(iData);
 287  008d 7b02          	ld	a,(OFST+2,sp)
 288  008f cd0000        	call	_I2C_SendData
 290  0092               L341:
 291                     ; 33   while(!I2C_CheckEvent(I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED))
 293  0092 ae0782        	ldw	x,#1922
 294  0095 cd0000        	call	_I2C_CheckEvent
 296  0098 4d            	tnz	a
 297  0099 27f2          	jreq	L141
 299  009b               L151:
 300                     ; 35   while(!I2C_CheckEvent(I2C_EVENT_MASTER_BYTE_TRANSMITTED));
 302  009b ae0784        	ldw	x,#1924
 303  009e cd0000        	call	_I2C_CheckEvent
 305  00a1 4d            	tnz	a
 306  00a2 27f7          	jreq	L151
 307                     ; 36   I2C_GenerateSTOP(ENABLE);
 309  00a4 a601          	ld	a,#1
 310  00a6 cd0000        	call	_I2C_GenerateSTOP
 312                     ; 37 }
 315  00a9 85            	popw	x
 316  00aa 81            	ret
 356                     ; 6 void Init_VL53L0X()
 356                     ; 7 {
 357                     	switch	.text
 358  00ab               _Init_VL53L0X:
 362                     ; 8 }
 365  00ab 81            	ret
 388                     ; 10 void MeasureSingleMode()
 388                     ; 11 {
 389                     	switch	.text
 390  00ac               _MeasureSingleMode:
 394                     ; 12 }
 397  00ac 81            	ret
 420                     ; 14 void MeasureContinuous()
 420                     ; 15 {
 421                     	switch	.text
 422  00ad               _MeasureContinuous:
 426                     ; 17 }
 429  00ad 81            	ret
 480                     ; 12 static void delay(uint32_t t) {
 481                     	switch	.text
 482  00ae               L312_delay:
 484       00000000      OFST:	set	0
 487  00ae               L342:
 488                     ; 13     while(--t);
 490  00ae 96            	ldw	x,sp
 491  00af 1c0003        	addw	x,#OFST+3
 492  00b2 a601          	ld	a,#1
 493  00b4 cd0000        	call	c_lgsbc
 495  00b7 96            	ldw	x,sp
 496  00b8 1c0003        	addw	x,#OFST+3
 497  00bb cd0000        	call	c_lzmp
 499  00be 26ee          	jrne	L342
 500                     ; 14 }
 503  00c0 81            	ret
 535                     .const:	section	.text
 536  0000               L22:
 537  0000 000f4240      	dc.l	1000000
 538                     ; 17 void main(void)
 538                     ; 18 {
 539                     	switch	.text
 540  00c1               _main:
 544                     ; 19 	GPIO_DeInit(GPIOD);
 546  00c1 ae500f        	ldw	x,#20495
 547  00c4 cd0000        	call	_GPIO_DeInit
 549                     ; 20 	GPIO_Init(LED_GPIO_PORT,LED_GPIO_PIN,GPIO_MODE_OUT_PP_LOW_SLOW);
 551  00c7 4bc0          	push	#192
 552  00c9 4b08          	push	#8
 553  00cb ae500f        	ldw	x,#20495
 554  00ce cd0000        	call	_GPIO_Init
 556  00d1 85            	popw	x
 557                     ; 21 	I2C_DeInit();
 559  00d2 cd0000        	call	_I2C_DeInit
 561                     ; 23 	I2C_Init(I2C_SPEED, VL53L0X_ADDRESS, I2C_DUTYCYCLE_2, I2C_ACK_CURR, I2C_ADDMODE_7BIT, (CLK_GetClockFreq() / 1000000));
 563  00d5 cd0000        	call	_CLK_GetClockFreq
 565  00d8 ae0000        	ldw	x,#L22
 566  00db cd0000        	call	c_ludv
 568  00de b603          	ld	a,c_lreg+3
 569  00e0 88            	push	a
 570  00e1 4b00          	push	#0
 571  00e3 4b01          	push	#1
 572  00e5 4b00          	push	#0
 573  00e7 ae0052        	ldw	x,#82
 574  00ea 89            	pushw	x
 575  00eb ae93e0        	ldw	x,#37856
 576  00ee 89            	pushw	x
 577  00ef ae0004        	ldw	x,#4
 578  00f2 89            	pushw	x
 579  00f3 cd0000        	call	_I2C_Init
 581  00f6 5b0a          	addw	sp,#10
 582  00f8               L752:
 583                     ; 27 		if (pResult = I2C_ByteRead(VL53L0X_ADDRESS, VL53L0X_EXPECTED_DEVICE_ID_ADRESS) == VL53L0X_EXPECTED_DEVICE_ID)
 585  00f8 ae52c0        	ldw	x,#21184
 586  00fb cd0000        	call	_I2C_ByteRead
 588  00fe a1ee          	cp	a,#238
 589  0100 2605          	jrne	L42
 590  0102 ae0001        	ldw	x,#1
 591  0105 2001          	jra	L62
 592  0107               L42:
 593  0107 5f            	clrw	x
 594  0108               L62:
 595  0108 bf00          	ldw	_pResult,x
 596  010a be00          	ldw	x,_pResult
 597  010c 2709          	jreq	L362
 598                     ; 29 			GPIO_WriteHigh(LED_GPIO_PORT, LED_GPIO_PIN);
 600  010e 4b08          	push	#8
 601  0110 ae500f        	ldw	x,#20495
 602  0113 cd0000        	call	_GPIO_WriteHigh
 604  0116 84            	pop	a
 605  0117               L362:
 606                     ; 31 	delay(10000);
 608  0117 ae2710        	ldw	x,#10000
 609  011a 89            	pushw	x
 610  011b ae0000        	ldw	x,#0
 611  011e 89            	pushw	x
 612  011f ad8d          	call	L312_delay
 614  0121 5b04          	addw	sp,#4
 616  0123 20d3          	jra	L752
 651                     ; 44 void assert_failed(uint8_t* file, uint32_t line)
 651                     ; 45 {
 652                     	switch	.text
 653  0125               _assert_failed:
 657  0125               L303:
 658  0125 20fe          	jra	L303
 682                     	xdef	_main
 683                     	switch	.ubsct
 684  0000               _pResult:
 685  0000 0000          	ds.b	2
 686                     	xdef	_pResult
 687                     	xdef	_MeasureContinuous
 688                     	xdef	_MeasureSingleMode
 689                     	xdef	_Init_VL53L0X
 690                     	xdef	_I2C_ByteWrite
 691                     	xdef	_I2C_ByteRead
 692                     	xref	_GPIO_WriteHigh
 693                     	xref	_GPIO_Init
 694                     	xref	_GPIO_DeInit
 695                     	xdef	_assert_failed
 696                     	xref	_I2C_GetFlagStatus
 697                     	xref	_I2C_CheckEvent
 698                     	xref	_I2C_SendData
 699                     	xref	_I2C_Send7bitAddress
 700                     	xref	_I2C_ReceiveData
 701                     	xref	_I2C_AcknowledgeConfig
 702                     	xref	_I2C_GenerateSTOP
 703                     	xref	_I2C_GenerateSTART
 704                     	xref	_I2C_Init
 705                     	xref	_I2C_DeInit
 706                     	xref	_CLK_GetClockFreq
 707                     	xref.b	c_lreg
 708                     	xref.b	c_x
 728                     	xref	c_ludv
 729                     	xref	c_lzmp
 730                     	xref	c_lgsbc
 731                     	end
