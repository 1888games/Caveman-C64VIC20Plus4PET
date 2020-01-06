
 .var backgroundColourRegisters = Hashtable()
 .eval backgroundColourRegisters.put("C64", $d021)
 .eval backgroundColourRegisters.put("VIC", $900f)
 .eval backgroundColourRegisters.put("264", $ff15)
 .eval backgroundColourRegisters.put("PET", $ffff)

 .var borderColourRegisters = Hashtable()
 .eval borderColourRegisters.put("C64", $d020)	
 .eval borderColourRegisters.put("VIC", $900f)
 .eval borderColourRegisters.put("264", $ff19)
 .eval borderColourRegisters.put("PET", $ffff)

 .var multiColourHorizontalRegisters = Hashtable()
 .eval multiColourHorizontalRegisters.put("C64", $d016)	
 .eval multiColourHorizontalRegisters.put("VIC", $ffff)
 .eval multiColourHorizontalRegisters.put("264", $ff07)
 .eval multiColourHorizontalRegisters.put("PET", $ffff)


 .var extendedColour1Registers = Hashtable()
 .eval extendedColour1Registers .put("C64", $d022)	
 .eval extendedColour1Registers .put("VIC", $900E)
 .eval extendedColour1Registers .put("264", $ff16)
 .eval extendedColour1Registers .put("PET", $ffff)

  .var extendedColour2Registers = Hashtable()
 .eval extendedColour2Registers .put("C64", $d023)	
 .eval extendedColour2Registers .put("VIC", $900f)
 .eval extendedColour2Registers .put("264", $ff17)
 .eval extendedColour2Registers .put("PET", $ffff)

 .var defaultScreenRAM = Hashtable()
 .eval defaultScreenRAM.put("C64", $0400)	
 .eval defaultScreenRAM.put("VIC", $1000)
 .eval defaultScreenRAM.put("264", $0C00)
 .eval defaultScreenRAM.put("PET", $8000)

  .var defaultColorRAM = Hashtable()
 .eval defaultColorRAM.put("C64", $D800)	
 .eval defaultColorRAM.put("VIC", $9400)
 .eval defaultColorRAM.put("264", $0800)
 .eval defaultColorRAM.put("PET", $8000)

 .var rasterLineRegisters = Hashtable()
 .eval rasterLineRegisters.put("C64",$d012)
 .eval rasterLineRegisters.put("264",$FF1D)
 .eval rasterLineRegisters.put("VIC",$9004)
 .eval rasterLineRegisters.put("PET",$9999)

 .label C64_ScreenControl = $d011



// d011
//  Bit 7 (weight 128) is the most significant bit of the VIC's nine-bit raster register (see address 53266).
// Bit 6 controls extended color mode; if set to "1", each individual character on the text screen can have one of four background colors. Is by default set to "0", for a single common background color for all on-screen characters.
// Bit 5 selects either the text screen ("0") or high resolution graphics ("1").
// Bit 4 controls whether the screen area is visible or not: By default this bit is set to "1", rendering the screen area visibly, but by setting it to "0", the entire screen assumes the color of the screen color (as per 53280).
// Bit 3 selects 25 (when set to "1") or 24 (when set to "0") visible character lines on the text screen. Mostly used in conjunction with vertical scrolling; see next item.
// Bit 0–2 is used for vertical pixel-by-pixel scrolling of the text or high resolution graphics: Together these three bits form a binary number, indicating how many pixels to "shift" the entire text screen downwards.




// decect vic screen ram
 // CR2: $9002 - decimal 36866. Usual value decimal 150.
 // A dual function register.
 // The first seven bits fo this register determine the number of columns in
 // the TV display. Normally this will be the expected value of 22.
 // Bit 7 of this register is used to hold the value for line 9 of the address
 // for the video RAM. On an unexpanded VIC 20 as the address of the Video
 // RAM is $1E00 and therefore this bit 7 is set, however when the video RAM is
 // moved to $1000 then bit 7 becomes reset.

 // Note: Bit 7 of this register also indicates where the Colour RAM starts. If
 // this bit is 1, colour memory starts at location 38400. If this bit is 0,
 // colour memory starts at location 37888. Use the following formula:


VIDEO: {

	ScreenRowLSB:

	.if (target == "VIC") {	
		.fill 23, <[i * 22]
	}

	else {
		.fill 25, <[i * 40]
	}

	ScreenRowMSB:

	.if (target == "VIC") {	
		.fill 23, >[i * 22]
	}

	else {
		.fill 25, >[i * 40]
	}

	CurrentBorderColour: .byte 0
	CurrentBackgroundColour: .byte 0
	CurrentBorderLuminance: .byte 0
	CurrentBackgroundLuminance: .byte 0
	CurrentScreenRamAddress: .word 0
	CurrentExtendedColour1: .byte 0
	CurrentExtendedColour2: .byte 0



	Initialise: 

		.label Border_Colour = borderColourRegisters.get(target)
		.label Background_Colour = backgroundColourRegisters.get(target)
		.label Extended_Colour_1 = extendedColour1Registers.get(target)
		.label Extended_Colour_2 = extendedColour2Registers.get(target)
		.label MultiColourHorizontal = multiColourHorizontalRegisters.get(target)
		.label RasterLine = rasterLineRegisters.get(target)


		lda #<defaultScreenRAM.get(target)
		sta SCREEN_RAM
		lda #>defaultScreenRAM.get(target)
		sta SCREEN_RAM +1

		lda #<defaultColorRAM.get(target)
		sta COLOR_RAM
		lda #>defaultColorRAM.get(target)
		sta COLOR_RAM +1

		rts


}



.macro TurnOffScreen() {

	.if (target == "C64") {

		lda C64_ScreenControl
		and #%11101111
		sta C64_ScreenControl

	}

}


.macro TurnOnScreen() { 

	.if (target == "C64") {

		lda C64_ScreenControl
		ora #%00010000
		sta C64_ScreenControl

	}




}

.macro SetScreenHeight(rows) {

	.if (target == "C64") {

		lda C64_ScreenControl

		ldy #rows
		cpy #25
		beq Set25

			ora #%00010000
			sta C64_ScreenControl
			jmp Finish
		
		Set25:

			and #%11101111
			sta C64_ScreenControl


		Finish:



	}



}

.macro ClearScreen() {

	ldy #0


	.if (target == "VIC") {
		
		lda #32

		VicLoop: 

		sta (SCREEN_RAM), y
		sta (SCREEN_RAM) + 203, y

		cpy #202
		beq Finish
		iny
		jmp VicLoop

	}

	else {


	Loop: 

		lda #32

		sta (SCREEN_RAM), y
		inc SCREEN_RAM + 1
		sta (SCREEN_RAM), y
		inc SCREEN_RAM + 1
		sta (SCREEN_RAM), y
		inc SCREEN_RAM + 1
		sta (SCREEN_RAM), y

		lda SCREEN_RAM + 1
		sec
		sbc #3
		sta SCREEN_RAM + 1

		lda #0

		sta (COLOR_RAM), y
		inc COLOR_RAM + 1
		sta (COLOR_RAM), y
		inc COLOR_RAM + 1
		sta (COLOR_RAM), y
		inc COLOR_RAM + 1
		sta (COLOR_RAM), y

		lda COLOR_RAM + 1
		sec
		sbc #3
		sta COLOR_RAM + 1


		cpy #255
		beq Finish
		iny
		jmp Loop

	}

	Finish:



}




.macro SetMultiColourMode(value) {

	.if (target == "VIC" || target == "PET") {
		jmp Finish
	}



	.label ShiftedPointer = TEMP1
	lda #value
	asl
	asl
	asl
	asl
	sta ShiftedPointer

	lda VIDEO.MultiColourHorizontal
	and #%11101111
	ora ShiftedPointer
	sta VIDEO.MultiColourHorizontal


		

	Finish:

}


.macro WaitForRasterLine(line) {


	.label RasterTarget = TEMP1

	ldx line
	stx RasterTarget

	.if (target == "PET") {

			ldx #ZERO
			ldy #ZERO

		xLoop:

			inx
			cpx #240
			beq EndxLoop

			jmp xLoop

			EndxLoop:

			ldx #ZERO
			iny	
			cpy #9

			beq Finish
			jmp xLoop
	}

	Loop: 


	
		lda VIDEO.RasterLine
		cmp RasterTarget
		bne Loop

	Finish:

		.break

}


.macro SetBorderColour(colour, luminance) {

	.if (target == "PET") {
		jmp Finish
	}
	

	lda #colour
	sta VIDEO.CurrentBorderColour
	sta TEMP2

	.if (target == "VIC") {
		jsr AdjustBorderForVIC
	}

	.if (target == "264") {

		lda #luminance
		jsr AddLuminance
	
	}


	sta VIDEO.Border_Colour

	Finish:


}


.macro SetExtendedColour1(colour, luminance) {

	.if (target == "PET") {
		jmp Finish
	}


	lda #colour

	.if (target == "VIC") {
		asl
		asl
		asl
		asl
		ora #%00001111
	}


	sta VIDEO.CurrentExtendedColour1
	sta TEMP2




	.if (target == "264") {

		lda #luminance
		jsr AddLuminance
	}
	
	
	sta VIDEO.Extended_Colour_1

	Finish:


}


.macro SetExtendedColour2(colour, luminance) {

	.if (target == "PET" || target == "VIC") {
		jmp Finish
	}

	lda #colour
	sta VIDEO.CurrentExtendedColour2
	sta TEMP2

	lda #luminance
	sta VIDEO.CurrentBackgroundLuminance
	


	.if (target == "264") {

		lda #luminance
		jsr AddLuminance
	}
	else {
		lda TEMP2
	}
	
	sta VIDEO.Extended_Colour_2

	Finish:


}

.macro MoveBorderColour(amount) {

	.if (target == "PET") {
		jmp Finish
	}
	
	lda VIDEO.CurrentBorderColour
	clc
	adc #amount
	sta VIDEO.CurrentBorderColour

	.if (target == "VIC") {

		jsr AdjustBorderForVIC

	}

	sta VIDEO.Border_Colour

	Finish:

}


.macro MoveBackgroundColour(amount) {

	.if (target == "PET") {
		jmp Finish
	}
	
	lda VIDEO.CurrentBackgroundColour
	clc
	adc #amount
	sta VIDEO.CurrentBackgroundColour

	.if (target == "VIC") {


		jsr AdjustBackgroundForVIC

	}

	sta VIDEO.Background_Colour

	Finish:

}






.macro SetBackgroundColour(colour, luminance) {

	.if (target == "PET") {
		jmp Finish
	}

	lda #luminance
	sta VIDEO.CurrentBackgroundLuminance

	lda #colour
	sta VIDEO.CurrentBackgroundColour
	sta TEMP2

	.if (target == "VIC") {

		jsr AdjustBackgroundForVIC

	}

	.if (target == "264") {

		lda #luminance
		jsr AddLuminance
	}

	sta VIDEO.Background_Colour

	Finish:

}



AddLuminance: {

	.label ShiftedLuminance = TEMP1
	.label ColourValue = TEMP2

	asl
	asl
	asl
	asl
	sta ShiftedLuminance

	lda ColourValue
	and #%00001111
	ora ShiftedLuminance


	rts
}

AdjustBorderForVIC:{

		.label adjustedColour = TEMP1
		and #%00000111
		sta adjustedColour

		lda VIDEO.Background_Colour
		and #%11111000
		ora adjustedColour


	rts
}


AdjustBackgroundForVIC: {

		asl
		asl
		asl
		asl

		.label adjustedColour = TEMP1
		sta adjustedColour

		lda VIDEO.Background_Colour
		and #%00001111
		ora adjustedColour

		rts

}

