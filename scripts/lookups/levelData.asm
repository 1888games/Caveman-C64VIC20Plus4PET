LEVELDATA:{

	NextLevelID: .byte 4

	BirdActive: 	.byte 0, 1, 0, 1, 1, 0, 1, 1, 1, 1
	VolcanoActive:  .byte 0, 0, 1, 1, 1, 1, 0, 1, 1, 1
	Speed:			.byte 40, 38, 36, 34, 33, 32, 31, 30, 29, 28
	MaxLava:		.byte 2, 2, 2, 2, 3, 3, 3, 3, 3, 3
	HatchTime:		.byte 8, 8, 7, 7, 6, 6, 5, 5, 4
	DinoStunTime: 	.byte 9, 9, 9, 9, 8, 8, 7, 7, 7, 6, 6

	Ones: .byte 0
	Tens: .byte 0

	.label MaxLevels = 10

	ScreenPosition: .byte 71


	SetupNextLevel: {
	
		ldx NextLevelID

		ldx #3
		
		lda BirdActive, x
		sta BIRD.IsActive

		lda VolcanoActive, x
		sta VOLCANO.IsActive

		lda Speed, x
		sta MAIN.GameCounter + 2
		sta MAIN.GameCounter + 1
		sta MAIN.GameCounter

		lda MAIN.GameMode
		beq NoIncrease

		lda Speed, x
		sec
		sbc #6
		sta Speed, x

		NoIncrease:

		lda MaxLava, x
		sta LAVA.MaxInstance

		lda DinoStunTime, x
		sta DINO.StunCounter + 1

		lda HatchTime, x
		sta EGG.HatchCounter + 1

		jsr UpdateLevelText

		inx
		cpx #MaxLevels
		beq Wrap

		jmp Finish

		Wrap:

			ldx #ZERO
			

		Finish:
			stx NextLevelID

			rts


	}


	UpdateLevelText: {

		lda Tens

		clc
		adc SCORE.CharacterSetStart

		ldy ScreenPosition
		sta (SCREEN_RAM), y

		lda Ones
		clc
		adc SCORE.CharacterSetStart

		iny
		sta (SCREEN_RAM), y

		lda #ONE
		sta (COLOR_RAM), y
		dey
		sta (COLOR_RAM)+ 25, y

		inc Ones
		lda Ones
		cmp #10
		bne Finish

		lda #ONE
		sta Ones
		inc Tens



		Finish:

		rts


	}



}