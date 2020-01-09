SOUND_DATA: {


	DataStart: 

		 .word StartTune, MoveLeft, MoveRight, StealEgg, PutEgg, HitDino, ShowStun // 0-6
		 .word HideStun, KillBird, Baby1, Baby2, LifeLost, GameOver, GetAxe, SoundTest
		

	SongLength:
		 .byte 12, 0, 0, 1, 0, 1, 0, 0, 2, 1, 1, 6, 11, 1, 35


	StartTune:	.byte 12,35,14,5,15,35,11,5,12,15,14,5,15,15,19,5,18,75,19,5,17,5,15,5,12,10
	//StartTune:	.byte 0, 20, 1, 20, 2, 20, 3, 20, 4, 20, 5, 20, 6, 20, 7, 20, 8, 20, 9, 20, 10, 20, 11, 20, 12, 20
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
	GetAxe:		.byte 18, 2, 26, 4
	SoundTest:	.byte 0, 20, 1, 20, 2, 20, 3, 20, 4, 20, 5, 20, 6, 20, 7, 20, 8, 20, 9, 20, 10, 20, 11, 20
				.byte 12, 20, 13, 20, 14, 20, 15, 20, 16, 20, 17, 20, 18, 20, 19, 20, 20, 20, 21, 20, 22, 20, 23, 20
				.byte 24, 20, 25, 20, 26, 20, 27, 20, 28, 20, 29, 20, 30, 20, 31, 20, 32, 20, 33, 20, 34, 20, 35, 20	


}