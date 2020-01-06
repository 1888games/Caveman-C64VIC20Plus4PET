AXE:{

	IsCarrying: .byte 0
	BeingFired: .byte 0
	AxeMoveCounter: .byte 8, 8

	HandFrames: .byte 62, 63, 64, 65, 66, 99

	FramesPerColumn: .byte 4,4, 4, 1

	Column: .byte 1
    Colour: .byte 7


    KillBirdPositions:
    		.byte 98, 98, 8, 4
    		.byte 98, 98, 9, 5
    		.byte 98, 98, 98, 98
    		.byte 98, 98, 98, 98

 
	Frames: 
			.byte 67, 68, 69, 70
	 		.byte 71, 72, 73, 74
	 		.byte 75, 76, 77, 78
	 		.byte 79, 80, 81, 82


	FrameID: .byte 0
	StartFrameID: .byte 0
	CurrentFrame: .byte 0



	Reset: {

		jsr DeletePriorCharacter

		lda #3
		sta FramesPerColumn
		sta FramesPerColumn + 1
		sta FramesPerColumn + 2

		lda #1
		sta FramesPerColumn + 3

		rts

	}


	Draw:{

		jsr DeletePriorCharacter

		lda IsCarrying
		bne PutInHand

		lda BeingFired
		bne GetThrowData

		lda MAIN.GameMode	
		beq Finish

		// on tee

		lda HandFrames
		sta FrameID
		jmp DrawAxe

		GetThrowData:

			lda StartFrameID
			clc
			adc CurrentFrame
			tax 
			lda Frames, x
			sta FrameID
			
			jsr CheckWhetherHitDino
			jsr CheckWhetherHitBird
			jmp DrawAxe

		TurnOffSprite:  // Don't - it's used by the cage

			jmp Finish

		PutInHand:

			ldx CAVEMAN.Position
			lda HandFrames, x
			sta FrameID

			tax

			cpx #99
			beq Finish
			ldy #ONE
			jsr CHAR_DRAWING.ColourObject

		DrawAxe: 

			ldx FrameID

			cpx #99
			beq Finish

			ldy #ONE
			jsr CHAR_DRAWING.ColourObject

		Finish:

			rts
	}



	DeletePriorCharacter:{

		ldx FrameID
		cpx #99

		beq DontDelete
		ldy #ZERO
		jsr CHAR_DRAWING.ColourObject

		DontDelete:

		rts
	}



	CheckWhetherHitBird: {

		lda KillBirdPositions, x

		cmp BIRD.Position
		bne Finish
		
		//jsr SOUND.SFX_HIT
		jsr BIRD.KillBird

		jsr DespawnAxe

		Finish:
			rts

	}

	CheckWhetherHitDino: {



		ldy Column
		cpy #2
		bcc Finish

		lda DINO.Position
		cmp #1
		bne Finish

		lda FramesPerColumn, y
		cmp CurrentFrame
		bne Finish


		lda DINO.ToBeStunned
		bne Finish

		lda DINO.IsStunned
		bne Finish

		jsr DINO.Stun
	//	jsr SOUND.SFX_HIT

		jsr DespawnAxe

		Finish:

		rts
	}


	ThrowAxe:{

		// can't throw if not holding it
		lda IsCarrying
		beq Finish

		lda BeingFired
		bne Finish

		// can't throw if at stool
		lda CAVEMAN.Position
		beq Finish

		// can't throw if at egg
		cmp #4
		beq Finish


		lda CAVEMAN.Position
		sec
		sbc #1	// reduce to 0-3
		sta Column

		asl
		asl
		sta StartFrameID

		lda #ZERO
		sta CurrentFrame
		sta IsCarrying

		lda #ONE
		sta BeingFired
		//jsr SOUND.SFX_LOW

		lda AxeMoveCounter + 1
		sta AxeMoveCounter



		Finish:
			rts


	}

	FrameCode:{

		lda BeingFired
		beq CheckWhetherCarrying

		dec AxeMoveCounter
		bne Finish

		jsr MoveAxe
		jmp Finish

		CheckWhetherCarrying:

			lda IsCarrying
			bne Finish
			jsr SpawnAxe

		Finish:

			jsr Draw
			rts


	}




	MoveAxe: {



		lda AxeMoveCounter + 1
		sta AxeMoveCounter

		ldx Column
		lda CurrentFrame

		cmp FramesPerColumn, x
		bne DontRemove

		jsr DespawnAxe
		jsr Draw
		jmp Finish

		DontRemove:

			inc CurrentFrame
			lda CurrentFrame

		Finish:

		rts

	}


	DespawnAxe: {

		lda #ZERO
		sta BeingFired
		sta IsCarrying

		rts

	}

	SpawnAxe: {

	
		lda MAIN.GameMode
		bne NoAutoCarry

		lda #ONE
		sta IsCarrying

		NoAutoCarry:

		rts
	}

	



}