//*=$7000 "Import"

.if (target == 264) {
	*=$3b00 "Code"
}

.if (target == "VIC") {

	*=$3600"Code"
}

#import "lookups/labels.asm"
#import "setup/macros.asm"
#import "setup/maploader.asm"
#import "setup/titleloader.asm"
#import "setup/insloader.asm"
#import "lookups/charData.asm"
#import "lookups/soundData.asm"
#import "lookups/levelData.asm"
#import "interrupts/charDrawing.asm"



// #import "setup/sound.asm"

 #import "interrupts/score.asm"
 #import "interrupts/lives.asm"

 .if (target == 264) {
	//*=$055F "Code"
}


 #import "interrupts/caveman.asm"

  .if (target == 264) {
// "Code"
}

 #import "interrupts/egg.asm"
 #import "interrupts/cave.asm"
 #import "interrupts/bird.asm"
 #import "interrupts/axe.asm"
 #import "interrupts/lava.asm"
 #import "interrupts/dino.asm"
  #import "interrupts/volcano.asm"
 #import "interrupts/stars.asm"

