CAVEMAN:{


	Frames: .byte 56, 75, 30, 29, 40, 41

	Position: .byte 0
	DisableControl: .byte 0
	CarryingEgg: .byte 0

	.label ObjectType = 6
	.label MaxPosition = 5

	Colour: .byte 10
	Cooldown: .byte 5

	.label AddForMan = 35
	.label AddForBody = 21
	.label AddForEgg = 12
	.label MoveLeftSFXId = 1
	.label MoveRightSFXId = 2
	.label StealEggSFXId = 3
	.label PutEggSFXId = 4
	.label GetAxeSFXId = 13



	Reset:{

		jsr DeletePriorCharacter

		lda #ZERO
		sta CarryingEgg

		lda #ONE
		sta Position
		rts
	}

	Draw: {

		

		lda MAIN.GameOver
		bne Finish

		
		lda Position
		clc
		adc #AddForMan
		tax
		ldy #ONE
		jsr CHAR_DRAWING.ColourObject


		txa
		clc
		adc #AddForBody
		tax
		ldy #ONE
		jsr CHAR_DRAWING.ColourObject
		jsr DrawEgg


	 	Finish:

		rts


	}




	DrawEgg: {

		lda CarryingEgg
		beq NoEgg

		lda Position
		beq NoEgg

		//cmp #5
		//beq NoEgg

		lda Position
		clc
		adc #AddForEgg
		tax
		ldy #ONE
		jsr CHAR_DRAWING.ColourObject

		NoEgg:
			rts



	}


	DeletePriorCharacter:{

		lda Position
		clc
		adc #AddForMan
		tax
		ldy #ZERO
		jsr CHAR_DRAWING.ColourObject

		txa
		clc
		adc #AddForBody
		tax
		ldy #ZERO
		jsr CHAR_DRAWING.ColourObject

		lda Position
		beq DontDeleteEgg

		lda Position
		clc
		adc #AddForEgg
		tax
		ldy #ZERO
		jsr CHAR_DRAWING.ColourObject

		DontDeleteEgg:

		rts
	}





	Died: {

		jsr LIVES.LoseLife

		lda #ZERO
		sta MAIN.GameIsActive

		lda DINO.DeathTimer + 1
		sta DINO.DeathTimer


		//jsr SOUND.SFX_EXPLODE

		SetBorderColour(2, 5)

		// SETBACKGROUNDRED
		
		rts

	}

	CheckKilledByDino:{

		lda Position
		cmp #MaxPosition
		bne NotKilled

		lda DINO.Position
		bne NotKilled

		jsr Died

		NotKilled:


		rts
	}


	
	Control: {


		lda Cooldown
		beq Enabled

		dec Cooldown

		Enabled:

		lda Position
		cmp #MaxPosition
		bne NoEggCheck

		jsr CheckEggPickedUp
		jsr CheckKilledByDino

		NoEggCheck:

		lda DisableControl
		beq CheckJoystick

		rts

		CheckJoystick:


		ldy #2
		jsr INPUT.ReadJoystick

		lda INPUT.FIRE_UP_THIS_FRAME, y
		bne HandleFire2

		HandleRight: {

			lda INPUT.JOY_RIGHT_NOW, y
			beq HandleLeft


			lda INPUT.JOY_RIGHT_LAST, y
			cmp #ONE
			beq Complete

			lda #ONE
			sta INPUT.JOY_RIGHT_LAST, y

			lda Position
			cmp #MaxPosition
			beq Complete
		
			jsr DeletePriorCharacter

			.label EggStolen = TEMP7

			lda EGG.EggStolen
			sta EggStolen
	
			inc Position
			jsr CheckEggPickedUp


			lda EggStolen
			cmp EGG.EggStolen
			beq NoEgg

			jmp Complete


			NoEgg:

			ldy #MoveRightSFXId
			jsr SOUND.StartSong
		//	jsr SOUND.SFX_HIGH
			jmp Complete

		}

		Complete: {
			rts
		}

		HandleFire2: {


			jmp HandleFire
		}

		HandleLeft:{	

			lda INPUT.JOY_LEFT_NOW, y
			beq HandleDown

			// can't move left if in column 0
			lda Position
			beq Complete

			lda INPUT.JOY_LEFT_LAST, y
			cmp #ONE
			beq Complete

			lda #ONE
			sta INPUT.JOY_LEFT_LAST, y
			jmp MoveLeft

			MoveLeft:

				.label EggsBefore = TEMP4

				lda #ZERO
				sta INPUT.FIRE_UP_THIS_FRAME, y

				jsr DeletePriorCharacter
				dec Position

				lda CAVE.EggsInCave
				sta EggsBefore

				jsr CheckEggDelivered
				jsr CheckAxePickedUp

				lda EggsBefore
				cmp CAVE.EggsInCave
				beq Low

				ldy #PutEggSFXId
				jsr SOUND.StartSong
				jmp Complete2

				Low:
					ldy #MoveLeftSFXId
					jsr SOUND.StartSong
					jmp Complete2
		}

		Complete2:
			jmp Complete

		ExitViaFire:
			rts

		HandleFire:{

			jsr AXE.ThrowAxe
			jmp ExitViaFire

		}

		HandleDown:{

			lda INPUT.JOY_DOWN_NOW, y
			beq HandleUp

			lda INPUT.JOY_DOWN_LAST, y
			cmp #ONE
			beq Complete2

			lda #ONE
			sta INPUT.JOY_DOWN_LAST, y

			jmp Complete
		}


		HandleUp:{

			lda INPUT.JOY_UP_NOW, y
			beq Complete2

			lda INPUT.JOY_UP_LAST, y
			cmp #ONE
			beq Complete2

			lda #ONE
			sta INPUT.JOY_UP_LAST, y

			jmp Complete2
		}
	}

	CheckEggPickedUp:{

		lda Position
		cmp #MaxPosition
		bne NoPickup


		lda EGG.EggStolen
		bne NoPickup

		lda EGG.Position
		bne NoPickup

		jsr EGG.StealEgg

		ldy #StealEggSFXId
		jsr SOUND.StartSong



		NoPickup:

			rts

	}

	CheckAxePickedUp: {

		lda MAIN.GameMode
		beq NoPickup

		lda Position
		bne NoPickup

		lda AXE.IsCarrying
		bne NoPickup

		lda AXE.BeingFired
		bne NoPickup

		lda #ONE
		sta AXE.IsCarrying

		ldy #GetAxeSFXId
		jsr SOUND.StartSong

		NoPickup:
		rts


	}

	CheckEggDelivered: {

		lda Position
		bne NoDelivery

		lda CarryingEgg
		beq NoDelivery

		jsr CAVE.AddEgg
		dec CarryingEgg

		NoDelivery:
			rts


	}
}