// PET - Commodore PETs
// C64 - Commodore 64
// 264 - C16, C116, Plus4
// VIC - VIC 20

.var target = "264"
#import "../Lionel/zeroPage.asm"

MAIN: {


#import "../Lionel/lionel.asm"
#import "setup/loadModules.asm"

BASICStub(Entry,"Caveman")

//exomizer sfx sys -t 64 -x "inc $d020" -o yakf.exo yakf.prg

Entry:		
	
	jsr LIONEL.Initialise	
 	jsr C64.BankOutKernalAndBasic
	jsr C64.DisableCIA
	jsr VIC20.ConvertCharacterSet
	jsr VIC20.ConvertTitleSet

	jsr MAPLOADER.Initialise
	jsr TITLE_LOADER.Initialise
	jsr INS_LOADER.Initialise

	Set256CharMode264()
	SetMultiColourMode(1)
	SetVICRows(23)

	jsr SetupScreenMemory

	//jmp LoadGame
	jmp TitleScreen


.if(target == "VIC") {

*= $2C00 "Main"

}

PerformFrameCodeFlag: 	.byte $00
GameCounter:			.byte 60, 180, 40 // curr,currMax,Max
GameTickFlag:			.byte $00
GameMode: 				.byte 0
BackgroundColour:		.byte 0
GameIsActive:			.byte 0
InitialCooldown:		.byte 250
GameOverTimer:			.byte 0, 4
GameOver:				.byte 1
LevelCompleteTimer:		.byte 0, 5
WaitingForFire: 		.byte 1



TitleScreen: {

	ldy #0
	jsr SOUND.StartSong

	SetBorderColour(0, 5)
	SetBackgroundColour(0,5)
	SetExtendedColour1(3 , 5)  //9
	SetExtendedColour2(7,  5)  //13

	.if (target == "VIC") {
			SetBorderColour(7, 0)
	
	}


	jsr SetupCharMemoryTitle	

	ClearScreen()

	jsr TITLE_LOADER.DrawMap

	jmp TitleLoop

}



TitleLoop: {

	.if (target == "VIC") {
		WaitForRasterLine(40)
	}
	else {
		WaitForRasterLine(50)
	}

	jsr SOUND.Update

	ldy #2
	jsr INPUT.ReadJoystick
	lda INPUT.FIRE_UP_THIS_FRAME, y
	bne Instructions

	jmp TitleLoop

	
}



Instructions: {

	ClearScreen()

	SetBorderColour(3,5)

	jsr INS_LOADER.DrawMap
	jsr ColourLastRow


	jmp InstructionsLoop


}


ColourLastRow: {


			
		.label COLOR_ADDRESS = VECTOR4
		.label SCREEN_ADDRESS = VECTOR5
		 .label RowOffset = TEMP7

		//get row for this position
		ldy #21
		lda VIDEO.ScreenRowLSB, y
	
		// Get CharAddress
		
		sta SCREEN_ADDRESS
		sta COLOR_ADDRESS

		adc #0
		
		lda VIDEO.ScreenRowMSB, y	
		adc #0  // get carry bit from above
		sta RowOffset

		lda SCREEN_RAM + 1
		clc
		adc RowOffset
		sta SCREEN_ADDRESS + 1

		lda COLOR_RAM + 1
		clc
		adc RowOffset
		sta COLOR_ADDRESS +1

		ldy #0
		lda #7

		Loop:	


			
			sta (COLOR_ADDRESS), y

			cpy #12
			bcc NoChange

			lda #4

			NoChange:

			cpy #21
			beq Finish
			iny
			jmp Loop

		Finish:

			rts

}


InstructionsLoop:

	.if (target == "VIC") {
		WaitForRasterLine(40)
	}
	else {
		WaitForRasterLine(50)
	}

	jsr SOUND.Update

	ldy #2
	jsr INPUT.ReadJoystick


	
	lda INPUT.JOY_LEFT_NOW, y
	bne Amateur

	lda INPUT.JOY_RIGHT_NOW, y
	bne Pro
	
	jmp InstructionsLoop

	Pro:

		lda #ONE
		sta GameMode
		jmp LoadGame

	Amateur:

		lda #ZERO
		sta GameMode
		jmp LoadGame


SetupGameColours: {

		SetBackgroundColour(0 , 5)
		SetExtendedColour1(9 , 5)  //9

		.if (target == "VIC") {
			SetBorderColour(13, 0)
			SetExtendedColour1(8 , 5)  //9
		}

		else {
			SetExtendedColour2(13, 5)  //13
		}

		rts
	

}


SetupScreenMemory: {

	SetC64ScreenMemory($C000)
	SetVICScreenMemory($1000)
	Set264ScreenMemory($1C00)

	rts

}



SetupCharMemory: {
	
		SetC64CharacterMemory($F000)
		SetVICCharacterMemory($1C00)
		Set264CharacterMemory($2800)
	
		

		rts
	

}

SetupCharMemoryTitle: {

		SetC64CharacterMemory($F800)
		Set264CharacterMemory($2000)
		SetVICCharacterMemory($1400)
	
		rts

}



MainIRQ: {



	lda #ONE
	sta MAIN.PerformFrameCodeFlag

	clc
	dec MAIN.GameCounter


	bne NotYet


	lda MAIN.GameCounter + 1
	sta MAIN.GameCounter


	asl 

	jsr GameTick

	NotYet:

	rts
}


CavemanIRQ:{


		lda MAIN.GameOver
		bne NotYet

		lda MAIN.WaitingForFire
		beq NotWaiting

		//jsr CheckFire

		NotWaiting:

		lda MAIN.GameIsActive
		beq Paused

		

		jsr CAVEMAN.Control

		Paused:

	
		jsr CAVEMAN.Draw
	

		NotYet:

		rts

}

NewGame: {	


 	jsr CHAR_DRAWING.ClearAll


	lda #ONE
	sta LEVELDATA.Ones
	sta GameIsActive

	lda #ZERO
	sta LEVELDATA.NextLevelID
	sta LEVELDATA.Tens
	sta GameOver
//	sta GameIsActive
	
	jsr SCORE.Reset
	jsr LEVELDATA.SetupNextLevel

	jsr Reset

	jsr LIVES.Reset
	jsr CAVE.Reset

	lda #ZERO
	sta WaitingForFire
	sta CAVEMAN.Cooldown

	rts
	
}


NextLife:{

	lda #ONE
	sta GameIsActive

	lda LIVES.Value
	cmp #1
	bcs NotDead

	jsr SetGameOver
	jmp Finish


	NotDead:

	jsr Reset

	Finish:

	rts

}
NextLevel:{	

	lda #ZERO
	sta GameIsActive

	jsr SCORE.LevelComplete


	ldy #0
	jsr SOUND.StartSong

	lda LevelCompleteTimer + 1
	sta LevelCompleteTimer



	rts
}

GotoNextLevel: {

	jsr Reset
	jsr LEVELDATA.SetupNextLevel


	lda #ONE
	sta GameIsActive

	jsr CAVE.Reset
		

	rts


}

CheckNextLevel:{

	lda LevelCompleteTimer
	beq Finish

	dec LevelCompleteTimer
	bne Finish

	jsr GotoNextLevel

	Finish:
		rts

}

Random:{


	rts
}


Reset:{

		SetBorderColour(3 , 5)

		jsr CAVEMAN.Reset	
		jsr AXE.Reset
		jsr DINO.Reset
		jsr BIRD.Reset
		jsr VOLCANO.Start
		jsr EGG.Reset
		jsr CAVE.RemoveStoolEgg
		jsr LAVA.Reset

		rts

}


LoadGame: {

	jsr SetupGameColours
	jsr SetupCharMemory

	jsr MAPLOADER.DrawMap

	jsr NewGame

	//jmp TempLoop
	jmp Loop

}



TempLoop: {

	jmp TempLoop
}





CheckWhetherToUpdateScore: {

		//lda ZP_COUNTER
		//and #1
		//bne NoScoreAdd

		jsr SCORE.CheckScoreToAdd

		NoScoreAdd:
			rts
}




SetGameOver:{

	lda #ZERO
	sta GameIsActive

	lda #ONE
	sta GameOver

	lda GameOverTimer+1
	sta GameOverTimer
	
	rts

}



Loop:
		
	.if (target == "VIC") {
		WaitForRasterLine(40)
	}
	else {
		WaitForRasterLine(50)
	}

	jsr SOUND.Update
	


	//inc $d020
	jsr CavemanIRQ
	jsr MainIRQ
	jsr FrameCode

	//dec $d020

	jmp Loop
	

GameOverUpdate: {

	lda GameOver
	beq Loop

	lda GameOverTimer
	cmp #1
	bcs Waiting

	jmp Loop


	Waiting:

	dec GameOverTimer
	jmp Loop

}


FrameCode: {

		
		lda GameIsActive
		beq GamePaused

		inc ZP_COUNTER
		
		jsr AXE.FrameCode
		//jsr STARS.Update
		jsr LAVA.CheckHitCaveman
		//jsr CAVEMAN.CheckKilledByDino

		GamePaused:

			jsr CheckWhetherToUpdateScore

			lda GameOver
			beq Finish

			lda GameOverTimer
			bne Finish

			ldx #46
			ldy #ONE
			jsr CHAR_DRAWING.ColourObject

			lda INPUT.FIRE_UP_THIS_FRAME
			bne Finish

			jmp TitleScreen


			Finish:
				rts

	

}	



GameTick: {

		lda GameIsActive
		beq NotRunning

		jsr EGG.Update
		jsr BIRD.Update
		jsr DINO.Update
		jsr VOLCANO.Update
		jsr LAVA.Update

		jmp Finish

		NotRunning:

			jsr DINO.DeathUpdate
			jsr CheckNextLevel
			jmp GameOverUpdate

	

		Finish:
		
		rts
}


#import "setup/assets.asm"


}
