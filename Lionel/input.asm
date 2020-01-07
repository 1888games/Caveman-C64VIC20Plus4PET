
 .var joyPort2Registers = Hashtable()
 .eval rasterLineRegisters.put("C64",$dc00)
 .eval rasterLineRegisters.put("264",$FF1D)
 .eval rasterLineRegisters.put("VIC",$9904)
 .eval rasterLineRegisters.put("PET",$9999)


 .var joyPort1Registers = Hashtable()
 .eval rasterLineRegisters.put("C64",$dc01)
 .eval rasterLineRegisters.put("264",$FF1D)
 .eval rasterLineRegisters.put("VIC",$9904)
 .eval rasterLineRegisters.put("PET",$9999)

.var joyUpMasks = Hashtable()
.eval joyUpMasks.put("C64", %00001)
.eval joyUpMasks.put("264", %00000001)
.eval joyUpMasks.put("VIC", %00000100)
.eval joyUpMasks.put("PET", %00001)

.var joyDownMasks = Hashtable()
.eval joyDownMasks.put("C64", %00010)
.eval joyDownMasks.put("264", %00000010)
.eval joyDownMasks.put("VIC", %00001000)
.eval joyDownMasks.put("PET", %00001)

.var joyLeftMasks = Hashtable()
.eval joyLeftMasks.put("C64", %00100)
.eval joyLeftMasks.put("264", %00000100)
.eval joyLeftMasks.put("VIC", %00010000)
.eval joyLeftMasks.put("PET", %00001)

.var joyRightMasks = Hashtable()
.eval joyRightMasks.put("C64", %01000)
.eval joyRightMasks.put("264", %00001000)
.eval joyRightMasks.put("VIC", %10000000)
.eval joyRightMasks.put("PET", %00001)

.var joyFireMasks = Hashtable()
.eval joyFireMasks.put("C64", %10000)
.eval joyFireMasks.put("264", %01000000)
.eval joyFireMasks.put("VIC", %00100000)
.eval joyFireMasks.put("PET", %00001)





.var defaultJoystickPorts = Hashtable()
.eval defaultJoystickPorts .put("C64", 2)
.eval defaultJoystickPorts .put("264", 1)
.eval defaultJoystickPorts.put("VIC", 1)
.eval defaultJoystickPorts .put("PET", 1)

.label JOY_PORT_UDLF = $9111
.label JOY_PORT_RIGHT = $9120



// plus4
Plus4Select: .byte %00000100, %00000010



INPUT: {


	Initialise: 

		.label joyUpMask =  joyUpMasks.get(target)
		.label joyDownMask = joyDownMasks.get(target)
		.label joyLeftMask = joyLeftMasks.get(target)
		.label joyRightMask = joyRightMasks.get(target)
		.label joyFireMask = joyFireMasks.get(target)
		.label defaultJoystickPort = defaultJoystickPorts.get(target)

		rts
	

	JOY_READING: 		.word $00
	PortToRead:			.byte 0

	JOY_RIGHT_LAST: 	.word $00
	JOY_LEFT_LAST:  	.word $00
	JOY_DOWN_LAST: 		.word $00
	JOY_UP_LAST:  		.word $00
	JOY_FIRE_LAST: 		.word $00

	JOY_RIGHT_NOW:  	.word $00
	JOY_LEFT_NOW:  		.word $00
	JOY_DOWN_NOW: 		.word $00
	JOY_UP_NOW:  		.word $00
	JOY_FIRE_NOW: 		.word $00

	FIRE_UP_THIS_FRAME: .word $00


	


	ReadC64Joystick: {

		.if(target == "C64") {

			cpy #ZERO
			beq PortOne

			lda $dc00
			jmp StoreReading

			PortOne:

			lda $dc01

			StoreReading:

			sta JOY_READING, y

		}

		rts
	}


	Read264Joystick: {


		.if(target == "264") {

			.label temp = TEMP4
			.label JOYSTICKSELECT = TEMP8

			lda Plus4Select, y
			sta JOYSTICKSELECT

			GetJoystick:

			jsr gatherJoystick1
			sta temp
			jmp gatherJoystick2


			gatherJoystick1:
				lda #$ff
				sta $fd30
				lda JOYSTICKSELECT
				sta $ff08
				lda $ff08
		
				rts

			gatherJoystick2:

				jsr gatherJoystick1
				cmp temp
				bne GetJoystick

			sta JOY_READING, y

		}

		rts

	}



	ReadVICJoystick: {


		.if(target == "VIC") {

			sta $9113
			lda #127
			sta $9122

			lda JOY_PORT_UDLF
			sta JOY_READING, y

			lda JOY_PORT_RIGHT
			dey
			sta JOY_READING, y
		}

		rts
	}



	ReadPETKeyboard: {

		.if(target == "PET") {

		}

		rts
	}


	CalculateButtons: {

		ldy PortToRead

		CheckFire:

			// Check i fire held now
			lda JOY_READING, y
			and #INPUT.joyFireMask
			bne CheckFireUp

			// Fire held now
			lda #ONE
			sta JOY_FIRE_NOW, y
			sta JOY_FIRE_LAST, y
			jmp CheckLeft

			// Fire not held now
			CheckFireUp:

				lda #ZERO
				sta JOY_FIRE_NOW, y
				lda JOY_FIRE_LAST, y
				sta FIRE_UP_THIS_FRAME, y

				lda #ZERO
				sta JOY_FIRE_LAST, y


		CheckLeft:

			lda JOY_READING, y
			and #INPUT.joyLeftMask
			bne LeftUp

			lda #ONE
			sta JOY_LEFT_NOW, y

			jmp Finish

			LeftUp:
				lda #ZERO
				sta JOY_LEFT_LAST, y


		CheckUp:

			lda JOY_READING, y
			and #INPUT.joyUpMask
			bne UpUp


			lda #ONE
			sta JOY_UP_NOW, y


			jmp Finish
			
			UpUp:
				lda #ZERO
				sta JOY_UP_LAST, y

		CheckDown:

			lda JOY_READING, y
			and #INPUT.joyDownMask
			bne DownUp


			lda #ONE
			sta JOY_DOWN_NOW, y

			jmp Finish
			
			DownUp:
				lda #ZERO
				sta JOY_DOWN_LAST, y


		CheckRight:

			.if(target == "VIC") {
				dey
			}

			lda JOY_READING, y

			.if(target == "VIC") {
				iny
			}
			and #INPUT.joyRightMask

			
			bne RightUp


			lda #ONE
			sta JOY_RIGHT_NOW, y

			jmp Finish
			
			RightUp:
				lda #ZERO
				sta JOY_RIGHT_LAST, y


		Finish:



		rts
	}

	ReadJoystick: {

		dey
		sty INPUT.PortToRead
		
		lda #ZERO
		sta INPUT.JOY_FIRE_NOW, y
		sta INPUT.JOY_RIGHT_NOW, y
		sta INPUT.JOY_LEFT_NOW, y
		sta INPUT.JOY_UP_NOW, y
		sta INPUT.JOY_DOWN_NOW, y

		.if(target == "C64") {

			jsr INPUT.ReadC64Joystick
		}

		.if(target == "264") {	

			jsr INPUT.Read264Joystick
		}

		.if(target == "VIC") {

			jsr INPUT.ReadVICJoystick
		}


		.if(target == "PET") {

			jsr INPUT.ReadPETKeyboard

		}

		else {


			jsr INPUT.CalculateButtons
		}

		rts


	}


}


