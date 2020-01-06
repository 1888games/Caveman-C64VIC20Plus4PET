RANDOM:{



	C64: {
        lda seed
        beq doEor
        asl
        beq noEor
        bcc noEor
    doEor:    
        eor #$1d
        eor $dc04
        eor $dd04
    noEor:  
        sta seed
        rts
    seed:
        .byte $62


    Init: 
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


    VIC:{

        lda #$01
        asl               
        bcc Skip         
        eor #$4d  

        Skip:            
        sta VIC+1
        eor $9124

        rts

    }

    Initialise: {

    	.if (target == "C64") {
    		jsr C64.Init
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
       }

       rts

    }



}