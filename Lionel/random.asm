RANDOM:{


    RandomAdd: .byte 0 

	C64: {


        .if (target == "C64") {
            lda seed
            beq doEor
            
            beq noEor
            bcc noEor
        doEor:    
            eor #$1d
            eor $dc04
            eor $dd04
        noEor: 
            sta seed
            adc RandomAdd
            rts
        seed:
            .byte $62

        }
    }


    VIC:{

        .if(target == "VIC") {

            lda #$01
            asl               
            bcc Skip         
            eor #$4d  

            Skip:            
            sta VIC+1
            eor $9124

        }

         adc RandomAdd

        rts

    }

    Initialise: {

    	.if (target == "C64") {

    	    lda #$ff
            sta $dc05
            sta $dd05
            lda #$7f
            sta $dc04
            lda #$37
            sta $dd04

            lda #$91
            sta $dc0e
            sta $dd0e
            rts
    	}


    	rts

    }



    Get: {

       .if(target == "C64") {

            jsr C64
       }  

       .if(target == "VIC") {
            jsr VIC
       }

       .if(target == "264") {
        
            lda $ff1e
            adc RandomAdd
       }

       rts

    }



}