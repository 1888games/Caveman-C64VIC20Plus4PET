CHAR_DATA:{


	DataStart: 

		 .word Top_Leave, Got_Egg, Miss_Egg, Swoop_Egg, Top_1, Top_2, Top_3, Top_4
		 .word Bottom_1, Bottom_2, Bottom_3, Bottom_4
		 .word On_Tee, Egg_1, Egg_2, Egg_3, Egg_4, Egg_Front, Egg_Legs, Egg_Back, Egg_Open
		 .word Eggs1, Eggs2, Eggs3, Eggs4, Eggs5, Eggs6, Eggs7, Eggs8, Egg_Carry
		 .word Baby_1, Baby_2
		 .word Lava_1, Lava_2, Lava_3
		 .word Man_1, Man_2, Man_3, Man_4, Man_5, Man_6
		 .word Died_1, Died_2, Died_3, Died_4
		 .word Lava_Crack, FireText
		 .word AwayBlue, FireBlue, UpBlue, AwayGreen, FireGreen, UpGreen, Fire, Stars, Stars_Red
		 .word Body_1, Body_2, Body_3, Body_4, Body_5, Body_6
		 .word Axe_1, Axe_2, Axe_3, Axe_4, Axe_5
		 .word Axe_2_1, Axe_2_2, Axe_2_3, Axe_2_4
		 .word Axe_3_1, Axe_3_2, Axe_3_3, Axe_3_4
		 .word Axe_4_1, Axe_4_2, Axe_4_3, Axe_4_4
		 .word Clonk
		 .word Lava_1_1, Lava_1_2, Lava_1_3,Lava_1_4,Lava_1_5
		 .word Lava_2_1, Lava_2_2, Lava_2_3,Lava_2_4,Lava_2_5,Lava_2_6
		 .word Lava_3_1, Lava_3_2, Lava_3_3,Lava_3_4,Lava_3_5,Lava_3_6
		 .word Lava_4_1, Lava_4_2, Lava_4_3,Lava_4_4,Lava_4_5,Lava_4_6
		 .word Lava_5_1, Lava_5_2, Lava_5_3,Lava_5_4,Lava_5_5,Lava_5_6
		 .word Egg_Bird
		 

	ObjectType:
		.fill 12, 0 // bird
		.fill 9, 1 // egg
		.fill 9, 1 // eggsCave
		.fill 2, 2 // babies
		.fill 3, 3 // lava spew
		.fill 6, 4 // man head legs
		.fill 4, 7 // died
		.fill 1, 3 // lava crack
		.fill 1, 9 // text
		.fill 3, 2 // dino blue
		.fill 3, 5 // dino green
		.fill 1, 8 // fire
		.fill 1, 9 // stars
		.fill 1, 8 // stars red
		.fill 6, 6 // body
		.fill 5, 9 // axe carry
		.fill 12, 9 // axe throw
		.fill 1, 7 // clonk
		.fill 29, 3 // lava
		.fill 1, 1 // egg bird



	TypeColours:
		.byte 4, 1, 3, 2, 5, 5, 6, 2, 2, 7

	Sizes: {

		.if (target == "C64" || target == "264") {

			.byte 14, 16, 12, 16, 12, 10, 12, 10, 12, 10, 12, 10 // 0-11  	// BIRD
			.byte 2, 2, 2, 2, 2, 2, 2, 2, 4 // 12- 20 		// EGGS
			.byte 2, 2, 2, 2, 2, 2, 2, 2, 2  // EGGS  21 - 29
			.byte 12, 10 // 20  		// BABIES 30-31
			.byte 2, 6, 22  // LAVA32-34
			.byte 18, 16, 18, 16, 18, 12 // MAN 35,40
			.byte 12, 12, 12, 12  // 41-44	// DIED
			.byte 16 // 45 // LAVACRACK
			.byte 12 // 46 Firetext
			.byte 14, 12, 14 // 47-49 Blue Dino
			.byte 8, 10, 8// 50-52 Green 
			.byte 4, 4, 8// 53-55 Fire
			.byte 2, 4, 2, 4, 2, 4 // 56 -61 Body
			.byte 4, 4, 4, 4, 4	// 62-66 Axe
			.byte 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2  // 67-78 Axe throw
			.byte 2 // 79 clonk
			.byte 2, 2, 2, 2, 2 // 80-84 lava
			.byte 2, 2, 2, 2, 2, 2// 85-90 lava
			.byte 2, 2, 2, 2, 2, 2// 91-96 lava
			.byte 2, 2, 2, 2, 2, 2// 97-102 lava
			.byte 2, 2, 2, 2, 2, 2// 103-108 lava
			.byte 2, 2 // 109 - egg bird
		
		
		}

		.if (target == "VIC") {

			.byte 8, 8, 6, 6, 8, 8, 8, 8, 8, 8, 8, 8// 0-11  	// BIRD
			.byte 2, 2, 2, 2, 2, 2, 2, 2, 2// 12- 20 		// EGGS
			.byte 2, 2, 2, 2, 2, 2, 2, 2, 2 // EGGS  21 - 29
			.byte 4, 4// 20  		// BABIES 30-31
			.byte 2, 6, 12   // LAVA 32-34
			.byte 8, 8, 8, 8, 8, 6  // MAN 35,40
			.byte 2, 2, 2, 2 // 41-44	// DIED
			.byte 4 // 45 // LAVACRACK
			.byte 10 // 46 Firetext
			.byte 8, 6, 6// 47-49 Blue Dino
			.byte 2, 2, 2 //50-52 Green Dino
			.byte 2, 4, 2// 53-55 Fire
			.byte 2, 2, 2, 2, 2, 2 // 56-61 Body
			.byte 2, 2, 2, 2, 2	// 62-66 Axe
			.byte 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2  // 67-78 Axe throw
			.byte 2 // 79 clonk
			.byte 2, 2, 2, 2, 2 // 80-84 lava
			.byte 2, 2, 2, 2, 2, 2// 85-90 lava
			.byte 2, 2, 2, 2, 2, 2// 91-96 lava
			.byte 2, 2, 2, 2, 2, 2// 97-102 lava
			.byte 2, 2, 2, 2, 2, 2// 103-108 lava
			.byte 2, 2 // 109 - egg bird
		
		
			
		}

		.if (target == "PET") {

			.byte 8, 8, 8, 10, 8, 8, 10, 8, 8, 10, 10, 8// 0-11  	// BIRD
			.byte 2, 2, 2, 2, 2, 2, 2, 2, 4// 12- 20 		// EGGS
			.byte 2, 2, 2, 2, 2, 2, 2, 2, 2 // EGGS  21 - 29
			.byte 10, 12 // 20  		// BABIES 30-31
			.byte 2, 6, 18 // LAVA 32-34
			.byte 18, 20, 18, 20, 18, 16 // MAN 35,40
			.byte 12, 12, 12, 12  // 41-44	// DIED
			.byte 10 	// 45 // LAVACRACK
			.byte 12 // 46 Firetext
			.byte 28, 22, 28// 47-49 Blue Dino
			.byte 2, 2, 2// 50-52 Green Dino
			.byte 4, 6, 2// 53-55 Fire
			.byte 2, 2, 2, 2, 2, 2 // 56-61 Body
			.byte 2, 2, 2, 2, 2	// 62-66 Axe
			.byte 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2  // 67-78 Axe throw
			.byte 6 // 79 clonk
			.byte 2, 2, 2, 2, 2 // 80-84 lava
			.byte 2, 2, 2, 2, 2, 2// 85-90 lava
			.byte 2, 2, 2, 2, 2, 2// 91-96 lava
			.byte 2, 2, 2, 2, 2, 2// 97-102 lava
			.byte 2, 2, 2, 2, 2, 2// 103-108 lava
			.byte 2, 2 // 109 - egg bird
		

		}
			


	}


	
	Top_Leave:	.if (target == "C64" || target == "264") {			
					.byte 0, 6, 1, 6, 2, 6, 3, 6, 1, 7, 2, 7, 3, 7
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}

	Got_Egg: 	.if (target == "C64" || target == "264") {			
					.byte 1, 8, 2, 8, 3, 8, 1, 9, 2, 9, 3, 9, 2, 10, 3, 10
				}

				.if (target == "VIC") {
					.byte 1, 11, 2, 11, 1, 12, 2, 12
				}

				.if (target == "PET") {
					.byte 1, 8, 2, 8, 3, 8, 2, 9
				}

	Miss_Egg: 	.if (target == "C64" || target == "264") {			
					.byte 4, 6, 5, 6, 6, 6, 4, 7, 5, 7, 6, 7
				}

				.if (target == "VIC") {
					.byte 2, 10, 3, 10, 3, 11
				}

				.if (target == "PET") {
					.byte 5, 6, 4, 7, 5, 7, 6, 7
				}

	Swoop_Egg:	.if (target == "C64" || target == "264") {			
					.byte 4, 10, 5, 10, 4, 11, 5, 11, 6, 11, 4, 12, 5, 12, 4, 13
				}

				.if (target == "VIC") {
					.byte 2, 15, 3, 15, 2, 16
				}

				.if (target == "PET") {
					.byte 5, 10, 4, 11, 5, 11, 6, 11, 5, 12
				}

	Top_1:		.if (target == "C64" || target == "264") {			
					.byte 10, 3, 11, 3, 12, 3, 10, 4, 11, 4, 12, 4
				}

				.if (target == "VIC") {
					.byte 5, 7, 6, 7, 5, 8, 6, 8
				}

				.if (target == "PET") {
					.byte 11, 3, 10, 4, 11, 4, 12, 4
				}


	Top_2:		.if (target == "C64" || target == "264") {			
					.byte 14, 3, 15, 3, 16, 3, 14, 4, 15, 4
				}

				.if (target == "VIC") {
					.byte 7, 7, 8, 7, 7, 8, 8, 8
				}

				.if (target == "PET") {
					.byte 15, 3, 14,  4, 15, 4, 16, 4
				}

	Top_3:		.if (target == "C64" || target == "264") {			
					.byte 18, 3, 19, 3, 20, 3, 18, 4, 19, 4, 20, 4
				}

				.if (target == "VIC") {
					.byte 9, 7, 10, 7, 9, 8, 10, 8
				}

				.if (target == "PET") {
					.byte 19, 3, 18,  4, 19, 4, 20, 4, 19, 5
				}


	Top_4:		.if (target == "C64" || target == "264") {			
					.byte 22, 3, 23, 3, 24, 3, 22, 4, 23, 4
				}

				.if (target == "VIC") {
					.byte 11, 7, 12, 7, 11, 8, 12, 8
				}

				.if (target == "PET") {
					.byte 23, 3, 22,  4, 23, 4, 24, 4
				}

	Bottom_1:	.if (target == "C64" || target == "264") {			
					.byte 10, 6, 11, 6, 12, 6, 10, 7, 11, 7, 12, 7
				}

				.if (target == "VIC") {
					.byte 5, 10, 6, 10, 5, 11, 6, 11
				}

				.if (target == "PET") {
					.byte 11, 6, 10, 7, 11, 7, 12, 7
				}

	Bottom_2:	.if (target == "C64" || target == "264") {			
					.byte 14, 6, 15, 6, 16, 6, 14, 7, 15, 7
				}

				.if (target == "VIC") {
					.byte 7, 10, 8, 10, 7, 11, 8, 11
				}

				.if (target == "PET") {
					.byte 15, 5, 14, 6, 15, 6, 16, 6, 15, 7
				}

	Bottom_3:	.if (target == "C64" || target == "264") {			
					.byte 18, 6, 19, 6, 20, 6, 18, 7, 19, 7, 20, 7
				}

				.if (target == "VIC") {
					.byte 9, 10, 10, 10, 9, 11, 10, 11
				}

				.if (target == "PET") {
					.byte 19, 6, 18, 7, 19, 7, 20, 7, 19, 8
				}

	Bottom_4:	.if (target == "C64" || target == "264") {			
					.byte 22, 5, 23, 5, 24, 5, 22, 6, 23, 6
				}

				.if (target == "VIC") {
					.byte 11, 9, 12, 9, 11, 10, 12, 10
				}

				.if (target == "PET") {
					.byte 22, 5, 23, 5, 24, 5, 23, 6
				}

 	On_Tee:		.if (target == "C64" || target == "264") {			
					.byte 4, 14
				}

				.if (target == "VIC") {
					.byte 2, 17
				}

				.if (target == "PET") {
					.byte 4, 14
				}

	Egg_1:		.if (target == "C64" || target == "264") {			
					.byte 10, 13
				}

				.if (target == "VIC") {
					.byte 5, 18
				}

				.if (target == "PET") {
					.byte 10, 13
				}


	Egg_2:		.if (target == "C64" || target == "264") {			
					.byte 16, 14
				}

				.if (target == "VIC") {
					.byte 7, 18
				}

				.if (target == "PET") {
					.byte 16, 14
				}

	Egg_3:		.if (target == "C64" || target == "264") {			
					.byte 18, 13
				}

				.if (target == "VIC") {
					.byte 9, 18
				}

				.if (target == "PET") {
					.byte 18, 13
				}

	Egg_4:		.if (target == "C64" || target == "264") {			
					.byte 24, 14
				}

				.if (target == "VIC") {
					.byte 11, 18
				}

				.if (target == "PET") {
					.byte 24, 14
				}


	Egg_Front:	.if (target == "C64" || target == "264") {			
					.byte 28, 15
				}

				.if (target == "VIC") {
					.byte 15, 18
				}

				.if (target == "PET") {
					.byte 28, 15
				}

	Egg_Legs:	.if (target == "C64" || target == "264") {			
					.byte 31, 15
				}

				.if (target == "VIC") {
					.byte 17, 18
				}

				.if (target == "PET") {
					.byte 31, 15
				}

	Egg_Back:	.if (target == "C64" || target == "264") {			
					.byte 33, 15
				}

				.if (target == "VIC") {
					.byte 19, 18
				}

				.if (target == "PET") {
					.byte 33, 15
				}

	Egg_Open:	.if (target == "C64" || target == "264") {			
					.byte 34, 15, 35, 15
				}

				.if (target == "VIC") {
					.byte 21, 18
				}

				.if (target == "PET") {
					.byte 34, 15, 35, 15
				}

	Eggs1:	.if (target == "C64" || target == "264") {			
					.byte 3, 14
				}

				.if (target == "VIC") {
					.byte 1, 17
				}

				.if (target == "PET") {
					.byte 3, 14
				}


	Eggs2:	.if (target == "C64" || target == "264") {			
					.byte 2, 14
				}

				.if (target == "VIC") {
					.byte 0, 17
				}

				.if (target == "PET") {
					.byte 2, 14
				}

	Eggs3:	.if (target == "C64" || target == "264") {			
					.byte 1, 14
				}

				.if (target == "VIC") {
					.byte 1, 16
				}

				.if (target == "PET") {
					.byte 1, 14
				}

	Eggs4:	.if (target == "C64" || target == "264") {			
					.byte 3, 13
				}

				.if (target == "VIC") {
					.byte 0, 16
				}

				.if (target == "PET") {
					.byte 3, 13
				}

	Eggs5:	.if (target == "C64" || target == "264") {			
					.byte 2, 13
				}

				.if (target == "VIC") {
					.byte 1, 15
				}

				.if (target == "PET") {
					.byte 2, 13
				}

	Eggs6:	.if (target == "C64" || target == "264") {			
					.byte 1, 13
				}

				.if (target == "VIC") {
					.byte 0, 15
				}

				.if (target == "PET") {
					.byte 1, 13
				}


	Eggs7:	.if (target == "C64" || target == "264") {			
					.byte 3, 12
				}

				.if (target == "VIC") {
					.byte 1, 14
				}

				.if (target == "PET") {
					.byte 3, 12
				}

	Eggs8:	.if (target == "C64" || target == "264") {			
					.byte 2, 12
				}

				.if (target == "VIC") {
					.byte 0, 14
				}

				.if (target == "PET") {
					.byte 2, 12
				}

	Egg_Carry:	.if (target == "C64" || target == "264") {			
					.byte 0, 8
				}

				.if (target == "VIC") {
					.byte 0, 11
				}

				.if (target == "PET") {
					.byte 0, 8
				}

	Baby_1:		.if (target == "C64" || target == "264") {			
					.byte 36, 13, 37, 13, 36, 14, 37, 14, 36, 15, 37, 15
				}

				.if (target == "VIC") {
					.byte 20, 17, 20, 18
				}

				.if (target == "PET") {
					.byte 37, 13, 36, 14, 37, 14, 36, 15, 37, 15
				}


	Baby_2:		.if (target == "C64" || target == "264") {			
					.byte 39, 13, 38, 14, 39, 14, 38, 15, 39, 15
				}

				.if (target == "VIC") {
					.byte 21, 16, 21, 17
				}

				.if (target == "PET") {
					.byte 38, 13, 39, 13, 38, 14, 39, 14, 38, 15, 39, 15
				}


	Lava_1:	.if (target == "C64" || target == "264") {			
					.byte 37, 7
				}

				.if (target == "VIC") {
					.byte 20, 8
				}

				.if (target == "PET") {
					.byte 37, 7
				}


	Lava_2:	.if (target == "C64" || target == "264") {			
					.byte 36, 6, 37, 6, 38, 6
				}

				.if (target == "VIC") {
					.byte 19, 7, 20, 7, 21, 7
				}

				.if (target == "PET") {
					.byte 36, 6, 37, 6, 38, 6

				}


	Lava_3:		.if (target == "C64" || target == "264") {			
					.byte 27, 3, 31, 3, 33, 3, 35, 3, 37, 3, 39, 3, 36, 4, 38, 4, 35, 5, 37, 5, 39, 5
				}

				.if (target == "VIC") {
					.byte 14, 6, 16, 6, 18, 6, 19, 6, 20, 6, 21, 6
				}

				.if (target == "PET") {
					.byte 27, 3, 31, 3, 33, 3, 35, 3, 37, 3, 39, 3, 34, 4, 36, 4, 38, 4

				}

	Man_2:	.if (target == "C64" || target == "264") {			
					.byte 11, 10, 12, 10, 11, 11, 12, 11, 10, 12, 12, 12, 10, 14, 12, 13 
				}

				.if (target == "VIC") {
					.byte 6,16, 5, 17, 7, 17, 6, 18
				}

				.if (target == "PET") {
					.byte 11, 10, 12, 10,  11, 11, 12, 11, 10, 12, 11, 12, 12, 12, 11, 13, 12, 13, 10, 14
				}

	Man_1:	.if (target == "C64" || target == "264") {			
					.byte 7,12, 8, 12, 7, 13, 8, 13, 6, 14, 8, 14, 6,15, 7, 15, 8, 15
				}

				.if (target == "VIC") {
					.byte 4,16, 3, 17, 5, 17, 4, 18
				}

				.if (target == "PET") {
					.byte 6, 12, 7, 12, 6, 13, 7, 13, 6, 14, 7, 14, 8, 14, 6, 15, 7, 15
				}	

	Man_3:	.if (target == "C64" || target == "264") {			
					.byte 15, 11, 16, 11, 17, 11, 15, 12, 16, 12, 14, 12, 16, 13, 14, 13, 15, 14
				}

				.if (target == "VIC") {
					.byte 8,16, 7, 17, 9, 17, 8, 18
				}

				.if (target == "PET") {
					.byte 15, 11, 16, 11, 15, 12, 16, 12, 14, 12, 14, 13, 15, 13, 16, 13, 15, 14
				}	
	Man_4:	.if (target == "C64" || target == "264") {			
					.byte 19, 10, 20, 10, 19, 11, 20, 11, 18, 12, 20, 12, 20, 13, 18, 14 
				}

				.if (target == "VIC") {
					.byte 10,16, 9, 17, 11, 17, 10, 18
				}

				.if (target == "PET") {
					.byte 19, 10, 20, 10, 19, 11, 20, 11, 18, 12, 19, 12, 20, 12, 19, 13, 20, 13, 18, 14
				}

	Man_5:	.if (target == "C64" || target == "264") {			
					.byte 23, 11, 24, 11, 25, 11, 23, 12, 24, 12, 22, 12, 24, 13, 22, 13, 23, 14
				}

				.if (target == "VIC") {
					.byte 12,16, 11, 17, 13, 17, 12, 18
				}

				.if (target == "PET") {
					.byte 23, 11, 24, 11, 23, 12, 24, 12, 22, 12, 22, 13, 23, 13, 24, 13, 23, 14
				}

	Man_6:	.if (target == "C64" || target == "264") {			
					.byte 26, 12, 27, 12, 26, 13, 27, 13, 27, 14, 27, 15
				}

				.if (target == "VIC") {
					.byte 14,16, 13, 17, 14, 18
				}

				.if (target == "PET") {
					.byte 26, 12, 27, 12, 26, 13, 27, 13, 26, 14, 27, 14, 26, 15, 27, 15
				}

	Died_1:		.if (target == "C64" || target == "264") {			
					.byte 11, 14, 12, 14, 11, 15, 12, 15, 9, 15, 10, 15
				}

				.if (target == "VIC") {
					.byte 21, 13
				}

				.if (target == "PET") {
					.byte 11, 14, 12, 14, 11, 15, 12, 15, 9, 15, 10, 15
				}

	Died_2:		.if (target == "C64" || target == "264") {			
					.byte 13, 14, 14, 14, 13, 15, 14, 15, 15, 15, 16, 15
				}

				.if (target == "VIC") {
					.byte 21, 13
				}

				.if (target == "PET") {
					.byte 13, 14, 14, 14, 13, 15, 14, 15, 15, 15, 16, 15
				}

	Died_3:		.if (target == "C64" || target == "264") {			
					.byte 19, 14, 20, 14, 19, 15, 20, 15, 17, 15, 18, 15
				}

				.if (target == "VIC") {
					.byte 21, 13
				}

				.if (target == "PET") {
					.byte 19, 14, 20, 14, 19, 15, 20, 15, 17, 15, 18, 15
				}

	Died_4:		.if (target == "C64" || target == "264") {			
					.byte 21, 14, 22, 14, 21, 15, 22, 15, 23, 15, 24, 15
				}

				.if (target == "VIC") {
					.byte 21, 13
				}

				.if (target == "PET") {
					.byte 21, 14, 22, 14, 21, 15, 22, 15, 23, 15, 24, 15
				}


	Lava_Crack:	.if (target == "C64" || target == "264") {			
 					.byte 37, 9, 36, 10, 37, 10, 38, 10, 36, 11, 38, 11, 39, 11, 39, 12
 				}

 				.if (target == "VIC") {
 					.byte 20, 10, 20, 11
 				}

				.if (target == "PET") {
 					.byte 37, 9, 37, 10, 36, 11, 37, 11, 38, 11
 				}

 	FireText:	.if (target == "C64" || target == "264") {			
 					.byte 2, 3, 3, 3, 4, 3, 5, 3, 6, 3, 7, 3
 				}

 				.if (target == "VIC") {
 					.byte 0, 7, 1, 7, 2, 7, 3, 7, 4, 7
 				}

				.if (target == "PET") {
 					.byte 2, 3, 3, 3, 4, 3, 5, 3, 6, 3, 7, 3
 				}

 	AwayBlue:	.if (target == "C64" || target == "264") {			
 					.byte 32, 7, 33, 7, 32, 8, 33, 8, 34, 8, 35, 8, 34, 9
 				}

 				.if (target == "VIC") {
 					.byte 17, 12, 18, 12, 18, 13, 19, 13
 				}

				.if (target == "PET") {
 					.byte 31, 7, 32, 7, 33, 7, 34, 7, 35, 7, 32, 6, 33, 6, 34, 6, 35, 6
 					.byte 33, 8, 34, 8, 35, 8, 34, 9, 35, 9

 				}

 	FireBlue:	.if (target == "C64" || target == "264") {			
 					.byte 28, 8, 29, 8, 27, 9, 28, 9, 26, 10, 27, 10
 				}

 				.if (target == "VIC") {
 					.byte 15, 13, 14, 14, 15, 14
 				}

				.if (target == "PET") {
 					.byte 26, 8, 27, 8, 28, 8, 29, 8, 26, 9, 27, 9, 28, 9, 26, 9, 27, 9, 26, 10, 27, 10

 				}


 	UpBlue:		.if (target == "C64" || target == "264") {			
 					.byte 28, 5, 29, 5, 30, 5, 28, 6, 29, 6, 30, 6, 30, 7
 				}

 				.if (target == "VIC") {
 					.byte 15, 11, 16, 11, 16, 12
 				}

				.if (target == "PET") {
 					.byte 29, 3, 30, 3, 29, 4, 30, 4, 31, 4, 28, 5, 29, 5, 30, 5, 31, 5, 28, 6, 29, 6, 30, 6, 31, 6, 30, 7

 				}

 	AwayGreen:	.if (target == "C64" || target == "264") {			
 					.byte 32, 6, 33, 6, 34, 6, 34, 7
 				}

 				.if (target == "VIC") {
 					.byte 19,12
 				}

				.if (target == "PET") {
 					.byte 34, 10

 				}

 	FireGreen:	.if (target == "C64" || target == "264") {			
 					.byte 26, 9, 26, 8, 27, 8, 27, 7, 28, 7
 				}

 				.if (target == "VIC") {
 					.byte 14, 13
 				}

				.if (target == "PET") {
 					.byte 34, 10

 				}


 	UpGreen:	.if (target == "C64" || target == "264") {			
 					.byte 29, 3, 29, 4, 31, 5, 31, 6 
 				}

 				.if (target == "VIC") {
 					.byte 15, 10
 				}

				.if (target == "PET") {
 					.byte 34, 10

 				}

 	Fire:	.if (target == "C64" || target == "264") {			
 					.byte 26, 11, 27, 11
 				}

 				.if (target == "VIC") {
 					.byte 14,15
 				}

				.if (target == "PET") {
 					.byte 26, 11, 27, 11

 				}

 	Stars:	.if (target == "C64" || target == "264") {			
 					.byte 33, 4, 33, 5
 				}

 				.if (target == "VIC") {
 					.byte 18, 11, 19,11
 				}

				.if (target == "PET") {
 					.byte 33, 5, 34, 5, 35, 5
 				}

 	Stars_Red:	.if (target == "C64" || target == "264") {			
 					.byte 32, 4, 32, 5, 34, 4, 34, 5
 				}

 				.if (target == "VIC") {
 					.byte 17,11
 				}

				.if (target == "PET") {
 					.byte 32, 5

 				}


	Body_1:		.if (target == "C64" || target == "264") {			
					.byte 7, 14
				}

				.if (target == "VIC") {
					.byte 4,17
				}

				.if (target == "PET") {
					.byte 9,12

				}

	Body_2:		.if (target == "C64" || target == "264") {			
					.byte 11, 12, 11, 13
				}

				.if (target == "VIC") {
					.byte 6,17
				}

				.if (target == "PET") {
					.byte 9,12

				}

	Body_3:		.if (target == "C64" || target == "264") {			
					.byte 15,13
				}

				.if (target == "VIC") {
					.byte 8,17
				}

				.if (target == "PET") {
					.byte 9,12

				}

	Body_4:		.if (target == "C64" || target == "264") {			
					.byte 19,12,19,13
				}

				.if (target == "VIC") {
					.byte 10,17
				}

				.if (target == "PET") {
					.byte 9,12

				}

	Body_5:		.if (target == "C64" || target == "264") {			
					.byte 23, 13
				}

				.if (target == "VIC") {
					.byte 12,17
				}

				.if (target == "PET") {
					.byte 9,12

				}

	Body_6:		.if (target == "C64" || target == "264") {			
					.byte 26, 14, 26, 15
				}

				.if (target == "VIC") {
					.byte 14,17
				}

				.if (target == "PET") {
					.byte 9,12

				}

	Axe_1:		.if (target == "C64" || target == "264") {			
					.byte 5, 13, 5, 14
				}

				.if (target == "VIC") {
					.byte 3,18
				}

				.if (target == "PET") {
					.byte 5,15

				}

	Axe_2:		.if (target == "C64" || target == "264") {			
					.byte 10, 10, 10, 11
				}

				.if (target == "VIC") {
					.byte 5, 16
				}

				.if (target == "PET") {
					.byte 10, 11

				}

	Axe_3:		.if (target == "C64" || target == "264") {			
					.byte 14, 10, 14, 11
				}

				.if (target == "VIC") {
					.byte 7, 16
				}

				.if (target == "PET") {
					.byte 14,11

				}

	Axe_4:		.if (target == "C64" || target == "264") {			
					.byte 18, 10, 18, 11
				}

				.if (target == "VIC") {
					.byte 9, 16
				}

				.if (target == "PET") {
					.byte 18,11

				}

	Axe_5:		.if (target == "C64" || target == "264") {			
					.byte 22, 10, 22, 11
				}

				.if (target == "VIC") {
					.byte 11, 16
				}

				.if (target == "PET") {
					.byte 22,11

				}



	Axe_2_1:	.if (target == "C64" || target == "264") {			
					.byte 11,9
				}

				.if (target == "VIC") {
					.byte 5,15
				}

				.if (target == "PET") {
					.byte 11,9

				}

	Axe_2_2:	.if (target == "C64" || target == "264") {			
					.byte 11,8
				}

				.if (target == "VIC") {
					.byte 6,13
				}

				.if (target == "PET") {
					.byte 11,8

				}

	Axe_2_3:	.if (target == "C64" || target == "264") {			
					.byte 13,7
				}

				.if (target == "VIC") {
					.byte 5,12
				}

				.if (target == "PET") {
					.byte 13,7
				}

	Axe_2_4:	.if (target == "C64" || target == "264") {			
					.byte 11,5
				}

				.if (target == "VIC") {
					.byte 6,9
				}

				.if (target == "PET") {
					.byte 11,5

				}

	Axe_3_1:	.if (target == "C64" || target == "264") {			
					.byte 15,10
				}

				.if (target == "VIC") {
					.byte 7,15
				}

				.if (target == "PET") {
					.byte 15,10
				}

	Axe_3_2:	.if (target == "C64" || target == "264") {			
					.byte 15,8
				}

				.if (target == "VIC") {
					.byte 8,13
				}

				.if (target == "PET") {
					.byte 15,8

				}

	Axe_3_3:	.if (target == "C64" || target == "264") {			
					.byte 16,7
				}

				.if (target == "VIC") {
					.byte 7,12
				}

				.if (target == "PET") {
					.byte 16,7
				}

	Axe_3_4:	.if (target == "C64" || target == "264") {			
					.byte 14,5
				}

				.if (target == "VIC") {
					.byte 8,9
				}

				.if (target == "PET") {
					.byte 14,5

				}

	Axe_4_1:	.if (target == "C64" || target == "264") {			
					.byte 20,9
				}

				.if (target == "VIC") {
					.byte 9,15
				}

				.if (target == "PET") {
					.byte 20,9
				}

	Axe_4_2:	.if (target == "C64" || target == "264") {			
					.byte 22,8
				}

				.if (target == "VIC") {
					.byte 11,14
				}

				.if (target == "PET") {
					.byte 22,8

				}

	Axe_4_3:	.if (target == "C64" || target == "264") {			
					.byte 24,7
				}

				.if (target == "VIC") {
					.byte 12,13
				}

				.if (target == "PET") {
					.byte 24,7
				}

	Axe_4_4:	.if (target == "C64" || target == "264") {			
					.byte 26,6
				}

				.if (target == "VIC") {
					.byte 14,12
				}

				.if (target == "PET") {
					.byte 26,6

				}


	Clonk:	.if (target == "C64" || target == "264") {			
					.byte 27,5
				}

				.if (target == "VIC") {
					.byte 14,11
				}

				.if (target == "PET") {
					.byte 26,5, 27, 5, 27, 6

				}


	Lava_1_1:	.if (target == "C64" || target == "264") {			
					.byte 8,5
				}

				.if (target == "VIC") {
					.byte 3,9
				}

				.if (target == "PET") {
					.byte 8,5

				}



	
	Lava_1_2:	.if (target == "C64" || target == "264") {			
					.byte 7,7
				}

				.if (target == "VIC") {
					.byte 4,11
				}

				.if (target == "PET") {
					.byte 7,7
				}


	Lava_1_3:	.if (target == "C64" || target == "264") {			
					.byte 8,9
				}

				.if (target == "VIC") {
					.byte 4,14
				}

				.if (target == "PET") {
					.byte 8,9

				}


	Lava_1_4:	.if (target == "C64" || target == "264") {			
					.byte 7,11
				}

				.if (target == "VIC") {
					.byte 4,15
				}

				.if (target == "PET") {
					.byte 7,11

				}				


	Lava_1_5:	.if (target == "C64" || target == "264") {			
					.byte 5,15
				}

				.if (target == "VIC") {
					.byte 3,14
				}

				.if (target == "PET") {
					.byte 8,15

				}


	Lava_2_1:	.if (target == "C64" || target == "264") {			
					.byte 13,3
				}

				.if (target == "VIC") {
					.byte 6,6
				}

				.if (target == "PET") {
					.byte 13,3

				}



	
	Lava_2_2:	.if (target == "C64" || target == "264") {			
					.byte 12,5
				}

				.if (target == "VIC") {
					.byte 5,9
				}

				.if (target == "PET") {
					.byte 12,5

				}


	Lava_2_3:	.if (target == "C64" || target == "264") {			
					.byte 13,6
				}

				.if (target == "VIC") {
					.byte 6,12
				}

				.if (target == "PET") {
					.byte 13,6

				}


	Lava_2_4:	.if (target == "C64" || target == "264") {			
					.byte 12,8
				}

				.if (target == "VIC") {
					.byte 6,14
				}

				.if (target == "PET") {
					.byte 12,8

				}				


	Lava_2_5:	.if (target == "C64" || target == "264") {			
					.byte 12,9
				}

				.if (target == "VIC") {
					.byte 6,15
				}

				.if (target == "PET") {
					.byte 12,9

				}	

	Lava_2_6:	.if (target == "C64" || target == "264") {			
					.byte 13,13
				}

				.if (target == "VIC") {
					.byte 3,14
				}

				.if (target == "PET") {
					.byte 13,13

				}	


	Lava_3_1:	.if (target == "C64" || target == "264") {			
					.byte 17,3
				}

				.if (target == "VIC") {
					.byte 8,6
				}

				.if (target == "PET") {
					.byte 17,3

				}



	
	Lava_3_2:	.if (target == "C64" || target == "264") {			
					.byte 16,5
				}

				.if (target == "VIC") {
					.byte 7,9
				}

				.if (target == "PET") {
					.byte 16,5

				}


	Lava_3_3:	.if (target == "C64" || target == "264") {			
					.byte 17,7
				}

				.if (target == "VIC") {
					.byte 8,12
				}

				.if (target == "PET") {
					.byte 17,7

				}


	Lava_3_4:	.if (target == "C64" || target == "264") {			
					.byte 17,9
				}

				.if (target == "VIC") {
					.byte 8,14
				}

				.if (target == "PET") {
					.byte 17,9

				}				


	Lava_3_5:	.if (target == "C64" || target == "264") {			
					.byte 16,10
				}

				.if (target == "VIC") {
					.byte 8,15
				}

				.if (target == "PET") {
					.byte 16,10

				}

	Lava_3_6:	.if (target == "C64" || target == "264") {			
					.byte 17,13
				}

				.if (target == "VIC") {
					.byte 3,14
				}

				.if (target == "PET") {
					.byte 17,13

				}

	Lava_4_1:	.if (target == "C64" || target == "264") {			
					.byte 21,3
				}

				.if (target == "VIC") {
					.byte 10,6
				}

				.if (target == "PET") {
					.byte 21,3

				}



	
	Lava_4_2:	.if (target == "C64" || target == "264") {			
					.byte 20,5
				}

				.if (target == "VIC") {
					.byte 9,9
				}

				.if (target == "PET") {
					.byte 20,5
				}


	Lava_4_3:	.if (target == "C64" || target == "264") {			
					.byte 21,6
				}

				.if (target == "VIC") {
					.byte 10,12
				}

				.if (target == "PET") {
					.byte 21,6

				}


	Lava_4_4:	.if (target == "C64" || target == "264") {			
					.byte 20,8
				}

				.if (target == "VIC") {
					.byte 10,14
				}

				.if (target == "PET") {
					.byte 20,8

				}				


	Lava_4_5:	.if (target == "C64" || target == "264") {			
					.byte 19,9
				}

				.if (target == "VIC") {
					.byte 10,15
				}

				.if (target == "PET") {
					.byte 19,9

				}


	Lava_4_6:	.if (target == "C64" || target == "264") {			
					.byte 21,13
				}

				.if (target == "VIC") {
					.byte 3,14
				}

				.if (target == "PET") {
					.byte 21,13

				}

	Lava_5_1:	.if (target == "C64" || target == "264") {			
					.byte 25,3
				}

				.if (target == "VIC") {
					.byte 12,6
				}

				.if (target == "PET") {
					.byte 25,3
				}



	
	Lava_5_2:	.if (target == "C64" || target == "264") {			
					.byte 25,5
				}

				.if (target == "VIC") {
					.byte 13,8
				}

				.if (target == "PET") {
					.byte 25,5

				}


	Lava_5_3:	.if (target == "C64" || target == "264") {			
					.byte 23,7
				}

				.if (target == "VIC") {
					.byte 12,11
				}

				.if (target == "PET") {
					.byte 23,7

				}


	Lava_5_4:	.if (target == "C64" || target == "264") {			
					.byte 24,9
				}

				.if (target == "VIC") {
					.byte 12,14
				}

				.if (target == "PET") {
					.byte 24,9

				}				


	Lava_5_5:	.if (target == "C64" || target == "264") {			
					.byte 23,10
				}

				.if (target == "VIC") {
					.byte 12,15
				}

				.if (target == "PET") {
					.byte 23,10

				}


	Lava_5_6:	.if (target == "C64" || target == "264") {			
					.byte 25,13
				}

				.if (target == "VIC") {
					.byte 3,14
				}

				.if (target == "PET") {
					.byte 25,13

				}


	Egg_Bird:	.if (target == "C64" || target == "264") {			
					.byte 0,8
				}

				.if (target == "VIC") {
					.byte 0,11
				}

				.if (target == "PET") {
					.byte 0,8

				}




}