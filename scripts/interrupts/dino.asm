DINO:{


	Position: .byte 2
	IsStunned: .byte 0
	ToBeStunned: .byte 0

	StunCounter: .byte 10, 10
	Colour: .byte 3

	CharFrames: .byte 48, 49, 47
	SecondaryFrames: .byte 53, 53, 53

	StunFrames: .byte 54, 55, 79
	DeathTimer:				.byte  99, 3

	.label HitDinoSFXId = 5
	.label ShowStunSFXId = 6
	.label HideStunSFXId = 7

	Reset:{

		jsr DeletePreviousCharacters

		lda #ZERO
		sta IsStunned
		sta ToBeStunned

		lda #ONE
		sta Position

		jsr Update

		rts
	}


	Stun: {

		ldx StunFrames + 2
		ldy #ONE
		jsr CHAR_DRAWING.ColourObject

		lda #ONE
		sta ToBeStunned

		lda StunCounter + 1
		sta StunCounter

		ldy #HitDinoSFXId
		jsr SOUND.StartSong

		rts


	}


	DecideWhetherToMove: {


		jsr RANDOM.Get


		cmp #85
		bcc Left

		cmp #170
		bcc Centre

		lda #2
		jmp Finish

		Centre:

		lda #1
		jmp Finish


		Left:

		lda #0
		jmp Finish
		
		Finish:

		sta Position

		rts
	}

	HideStun:{


		ldx StunFrames
		ldy #ZERO
		jsr CHAR_DRAWING.ColourObject

		ldx StunFrames + 1
		ldy #ZERO
		jsr CHAR_DRAWING.ColourObject

		ldy #HideStunSFXId
		jsr SOUND.StartSong

		rts


	}

	DrawStun: {

		jsr DeletePreviousCharacters

			// Set to stun position and draw stars

		ldx StunFrames
		ldy #ONE
		jsr CHAR_DRAWING.ColourObject

		ldx StunFrames + 1
		ldy #ONE
		jsr CHAR_DRAWING.ColourObject

		lda StunCounter
		cmp #4
		bcs NoSound

		ldy #ShowStunSFXId
		jsr SOUND.StartSong

		NoSound:

		rts


	}



	DeathUpdate:{

		lda DeathTimer + 1
		cmp DeathTimer
		bcc Finish

		dec DeathTimer
		beq NextLife

		//jsr SOUND.SFX_EXPLODE

		jmp Finish

		NextLife:
			jsr MAIN.NextLife

		Finish:

		rts



	}

	Update: {

		lda ToBeStunned
		beq NotStunning

		// Now Set Stun positi
		dec ToBeStunned
		jsr DeletePreviousCharacters
		jsr SCORE.HitDino

		ldx Position
		lda StunFrames + 2
		tax
		ldy #ONE
		jsr CHAR_DRAWING.ColourObject

		lda #ONE
		sta IsStunned

		jmp Draw

		NotStunning:

			lda IsStunned
			beq NotStunned

			//jsr DrawStun
			jsr HandleStun

			lda #2
			sta Position

			jmp Draw

		NotStunned:

			jsr DeletePreviousCharacters
			jsr DecideWhetherToMove

		Draw:

			jsr DrawHead

		//jsr DrawExtraSprite

		Finish:	

			rts



	}

	DeletePreviousCharacters:{

		ldy Position
		ldx CharFrames, y
		ldy #ZERO
		jsr CHAR_DRAWING.ColourObject

		inx
		inx
		inx
		ldy #ZERO
		jsr CHAR_DRAWING.ColourObject

		ldy Position
		ldx SecondaryFrames, y
		ldy #ZERO
		jsr CHAR_DRAWING.ColourObject

		ldx StunFrames + 2
		 ldy #ZERO
		 jsr CHAR_DRAWING.ColourObject

		ldx StunFrames
		ldy #ZERO
		jsr CHAR_DRAWING.ColourObject

		ldx StunFrames + 1
		ldy #ZERO
		jsr CHAR_DRAWING.ColourObject



		rts
	}


	

	DrawHead: {	


		ldx Position
		
		Complete:
			lda CharFrames, x
			tax 
			ldy #ONE
			jsr CHAR_DRAWING.ColourObject

			inx
			inx
			inx
			jsr CHAR_DRAWING.ColourObject

			ldx Position
			beq DrawFire
			jmp Finish

			DrawFire:

				lda SecondaryFrames, x
				tax
				ldy #ONE
				jsr CHAR_DRAWING.ColourObject

			Finish:

			rts


	}




	HandleStun:{

		dec StunCounter
		bne CheckFlash

		lda #ZERO
		sta IsStunned

		CheckFlash:

			lda StunCounter
			cmp #3
			beq Hide

			cmp #1
			beq Hide

			jsr DrawStun
			jmp Finish
		
			Hide:	
				jsr HideStun
				jmp Finish

		
			Finish:

			rts


	}

}