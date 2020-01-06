LAVA: {


	Falling: 	.byte 0, 0, 0
	Position: 	.byte 0, 0, 0
	Column: 	.byte 0, 0, 0
	EnableFlags: .byte %00000100, %00001000, %01000000

	EnableFlag: .byte %00000100
	DisableFlag: .byte %00000100

	FirstPositionForColumn: .byte 0, 5, 11, 17, 23
	MaxPositionForColumn: .byte 5, 11, 17, 23, 29
	PositionsThatKill: .byte 3, 9, 15, 21, 27

	ColumnAlreadyUsed: .byte 6
	MaxInstance: .byte 2

	.label Colour = RED


	Frames: .byte 80, 81, 82, 83, 84
			.byte 85, 86, 87, 88, 89, 90
			.byte 91, 92, 93, 94, 95, 96
			.byte 97, 98, 99, 100, 101, 102
			.byte 103, 104, 105, 106, 107, 108


	Reset:{	

		.label StoreX = TEMP8

		ldx #0

		Loop:
			stx StoreX
			jsr DeleteLava

			ldx StoreX
			inx
			
			cpx #3
			bne Loop

		lda #ZERO
		sta Falling
		sta Falling + 1
		sta Falling + 2

		rts

	}


	CheckHitCaveman: {

		ldx #ZERO
		.label StoreX = TEMP5
		.label ThisPosition = TEMP6

		Loop:	

			lda Falling, x
			beq EndLoop

			lda Position, x
			sta ThisPosition

			ldy Column, x
			lda PositionsThatKill, y
			
			cmp ThisPosition
			bne EndLoop

			cpy CAVEMAN.Position
			bne EndLoop

			lda #ZERO
			sta Falling, x

			stx StoreX

			jsr CAVEMAN.Died

			jmp Finish

			ldx StoreX

		EndLoop:
			inx
			cpx MaxInstance
			beq Finish
			jmp Loop 

		Finish:

			rts

	}




	DeleteLava: {


		ldy Position, x
		lda Frames, y
		tax
		ldy #ZERO
		jsr CHAR_DRAWING.ColourObject

		rts

	}
	MoveLava: {

		
		.label MaxPositionThisColumn = TEMP6
		.label ThisPosition = TEMP7
		.label ThisColumn = TEMP8
		.label StoreY = TEMP9
		.label StoreX = TEMP10

		stx StoreX

		jsr DeleteLava

	
		ldx StoreX
		lda Position, x
		clc
		adc #01
		sta ThisPosition

		ldy Column, x
		sty ThisColumn
		lda MaxPositionForColumn, y
		sta MaxPositionThisColumn

		ldy ThisPosition
		cpy MaxPositionThisColumn
		bcc StillFalling

		lda #ZERO
		sta Falling, x
		jmp Finish

		StillFalling:

		Finish:

			lda ThisPosition
			ldx StoreX
			sta Position, x

			rts
	}



	SpawnLava:{

	
		jsr RANDOM.Get

		cmp #127
		bcs Finish

		jsr RANDOM.Get
		and #$07

		cmp #5
		bcc DontSubtract

		sec
		sbc #3

		DontSubtract:

			cmp ColumnAlreadyUsed
			beq Finish

		
			sta Column, x
			tay
			lda FirstPositionForColumn, y
			sta Position, x

			lda #ONE
			sta Falling, x


		Finish:

		rts
	}


	Update:{

		lda VOLCANO.IsActive
		beq Finish

		//inc $d020

		ldx #ZERO

		Loop:

			lda Falling, x
			beq NotFalling


			jsr MoveLava
			jmp EndLoop

			NotFalling:

			lda VOLCANO.Position
			cmp #2
			beq CheckSpawn

			jmp EndLoop

			CheckSpawn:

				jsr SpawnLava


		EndLoop:

			jsr DrawLava

			inx
			cpx MaxInstance
			beq Finish
			jmp Loop

		Finish:

			lda #6
			sta ColumnAlreadyUsed

			rts


	}




	DrawLava: {

		
		.label StoreX = TEMP11
		stx StoreX

		lda Falling, x
		beq Finish

		// // get current position ID
		ldy Position, x
		lda Frames, y
		tax
		ldy #ONE
		jsr CHAR_DRAWING.ColourObject
	
		Finish:

		ldx StoreX

		rts


	}






}