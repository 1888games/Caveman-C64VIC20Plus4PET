CAVE:{

	EggsInCave: .byte 0
	EggOnStool: .byte 0

	.label StoolEggPosition = 12
	.label MaxEggs = 8

	CharFrames: .byte 21, 22, 23, 24, 25, 26, 27, 28

	Colour: .byte 1

	Reset:{

		lda #ZERO
		sta EggsInCave
		sta EggOnStool

		 jsr DeleteEggs

		 jsr DrawStoolEgg

		rts
	}





	DeleteEggs: {

		.label EggID = TEMP8

		ldx #ZERO
		ldy #ZERO

		Loop: 

			stx EggID

			lda CharFrames, x
			tax
			ldy #ZERO
			jsr CHAR_DRAWING.ColourObject

			ldx EggID

			cpx #7
			beq Finish
			inx 
			jmp Loop

		Finish:

			rts

	}


	RemoveStoolEgg:{

		lda #ZERO
		sta EggOnStool
		jsr DrawStoolEgg

		rts
	}


	AddEgg: {

		lda EggOnStool
		beq PutEggOnStool

		inc EggsInCave
		jsr SCORE.GotEgg


		jsr DrawCaveEggs
		
		lda EggsInCave
		cmp #MaxEggs
		beq LevelComplete

		jmp Finish

		LevelComplete:

				jsr LevelCompleted
				rts

		PutEggOnStool:

			lda #ONE
			sta EggOnStool
			jsr DrawStoolEgg


		Finish:

		lda #ONE
		sta EGG.LayingEgg

		rts


	}


	IRQCode: {

	//	jsr DrawCaveEggs
		rts
	}



	LevelCompleted: {

		jsr MAIN.NextLevel

		lda #GREEN
		sta $d020

		//inc $d020

		rts
	}

	DrawCaveEggs: {

		ldy EggsInCave
		dey
		lda CharFrames, y
		tax
		ldy #ONE
		jsr CHAR_DRAWING.ColourObject

		rts

	}



	EggStolen: {

		dec EggOnStool
		jsr DrawStoolEgg
		rts

	}


	DrawStoolEgg: {

		ldy EggOnStool
		ldx #StoolEggPosition

		jsr CHAR_DRAWING.ColourObject

		rts


	}


}