	
.label BaseScreenLocation = $FF14
.label CharMemoryLocation = $FF13


PLUS4: {



}


.macro Set264ScreenMemory (location) {

	.if(target == "264") {

		//.break

		lda #<location
		sta SCREEN_RAM
		lda #>location
		sta SCREEN_RAM + 1

		sec
		sbc #4
		sta COLOR_RAM +1
		sta BaseScreenLocation
		
	}
		

}


.macro Set264CharacterMemory(location) {


	.if(target == "264") {

		lda #%11111011		// set to use ram for characters (bit 2)
		sta $ff12

		lda #>location
		sta CharMemoryLocation

	}




}

.macro Set256CharMode264 () {

	lda $ff07	// screen setup
	ora #%10000000		// set 256-char mode
	sta $ff07
}




	