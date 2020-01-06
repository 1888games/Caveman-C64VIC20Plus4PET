SOUND_DATA: {


	DataStart: 

		 .word StartTune, MoveLeft, MoveRight, StealEgg, PutEgg, HitDino, ShowStun // 0-6
		 .word HideStun, KillBird, Baby1, Baby2, LifeLost, GameOver
		

	SongLength:
		 .byte 12, 0, 0, 1, 0, 1, 0, 0, 2, 1, 1, 6, 11


	StartTune:	.byte 12,35,14,5,15,35,11,5,12,15,14,5,15,15,19,5,18,75,19,5,17,5,15,5,12,10
	MoveLeft: 	.byte 12,3
	MoveRight: 	.byte 20,3
	StealEgg: 	.byte 24,2, 30, 2
	PutEgg: 	.byte 35,3
	HitDino:	.byte 16, 3, 8, 6
	ShowStun:	.byte 28, 10
	HideStun:	.byte 18, 10
	KillBird:	.byte 30, 2, 28, 2, 26, 2
	Baby1:		.byte 35, 4, 33, 6
	Baby2:		.byte 33, 4, 35, 6
	LifeLost:	.byte 27,15,22,9,22,6,24,15,22,30,26,15,27,15
	GameOver:	.byte 31,10,29,10,15,20,31,10,29,10,17,20,31,10,29,10,20,20,32,20,31, 1, 32,20





}