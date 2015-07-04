module graphics(input [299:0]  	map_1d,
					 input [9:0] 		PlayerXp1, PlayerYp1, DrawX, DrawY,
					 input [1:0]	 	stage,
					 output logic [7:0]  Red, Green, Blue,
					 output logic [9:0] DistXs, DistYs,
					 output logic [3:0] mapx,mapy);

enum logic [2:0] {EMPTY, WALL, BRICK, BOMB, WAVE, MONSTER} object;


//map index according to drawx and drawy
logic [2:0] map [10][10];
//logic [3:0] mapx,mapy;
assign mapx = DrawX / 8'd64;
assign mapy = DrawY / 8'd48;
//assign map = '{3'd0,3'd1,3'd2,3'd0};

assign { map[0][0], map[0][1], map[0][2], map[0][3], map[0][4], map[0][5], map[0][6], map[0][7], map[0][8], map[0][9],
						map[1][0], map[1][1], map[1][2], map[1][3], map[1][4], map[1][5], map[1][6], map[1][7], map[1][8], map[1][9],
						map[2][0], map[2][1], map[2][2], map[2][3], map[2][4], map[2][5], map[2][6], map[2][7], map[2][8], map[2][9],
						map[3][0], map[3][1], map[3][2], map[3][3], map[3][4], map[3][5], map[3][6], map[3][7], map[3][8], map[3][9],
						map[4][0], map[4][1], map[4][2], map[4][3], map[4][4], map[4][5], map[4][6], map[4][7], map[4][8], map[4][9],
						map[5][0], map[5][1], map[5][2], map[5][3], map[5][4], map[5][5], map[5][6], map[5][7], map[5][8], map[5][9],
						map[6][0], map[6][1], map[6][2], map[6][3], map[6][4], map[6][5], map[6][6], map[6][7], map[6][8], map[6][9],
						map[7][0], map[7][1], map[7][2], map[7][3], map[7][4], map[7][5], map[7][6], map[7][7], map[7][8], map[7][9],
						map[8][0], map[8][1], map[8][2], map[8][3], map[8][4], map[8][5], map[8][6], map[8][7], map[8][8], map[8][9],
						map[9][0], map[9][1], map[9][2], map[9][3], map[9][4], map[9][5], map[9][6], map[9][7], map[9][8], map[9][9]
						} = map_1d;
/*
assign map[0] = '{3'd1, 3'd1, 3'd1, 3'd1, 3'd1, 3'd1, 3'd1, 3'd1,3'd1, 3'd1};
assign map[1] = '{3'd1, 3'd0, 3'd0, 3'd2, 3'd2, 3'd0, 3'd0, 3'd0,3'd0, 3'd1};
assign map[2] = '{3'd1, 3'd0, 3'd1, 3'd1, 3'd0, 3'd0, 3'd1, 3'd1,3'd0, 3'd1};
assign map[3] = '{3'd1, 3'd2, 3'd1, 3'd1, 3'd0, 3'd0, 3'd1, 3'd1,3'd0, 3'd1};
assign map[4] = '{3'd1, 3'd2, 3'd0, 3'd0, 3'd0, 3'd0, 3'd0, 3'd0,3'd0, 3'd1};
assign map[5] = '{3'd1, 3'd2, 3'd0, 3'd0, 3'd0, 3'd0, 3'd0, 3'd0,3'd0, 3'd1};
assign map[6] = '{3'd1, 3'd2, 3'd1, 3'd1, 3'd0, 3'd0, 3'd1, 3'd1,3'd0, 3'd1};
assign map[7] = '{3'd1, 3'd0, 3'd1, 3'd1, 3'd0, 3'd0, 3'd1, 3'd1,3'd0, 3'd1};
assign map[8] = '{3'd1, 3'd0, 3'd0, 3'd2, 3'd2, 3'd0, 3'd0, 3'd0,3'd0, 3'd1};
assign map[9] = '{3'd1, 3'd1, 3'd1, 3'd1, 3'd1, 3'd1, 3'd1, 3'd1,3'd1, 3'd1};
*/



logic 	player_on,wall_on,brick_on,bomb_on,wave_on,monster_on,empty_on;

logic[7:0] P_Red, P_Green, P_Blue;
logic[7:0] S_Red, S_Green, S_Blue;
logic[7:0] B_Red, B_Green, B_Blue;
logic[7:0] BB_Red, BB_Green, BB_Blue;
logic[7:0] W_Red, W_Green, W_Blue;
logic[7:0] M_Red, M_Green, M_Blue;


logic[11:0] playerindex;
logic[9:0] DistXp,DistYp;
assign DistXp = DrawX - PlayerXp1;
assign DistYp = DrawY - PlayerYp1;
assign playerindex = DistXp + (9'd64*DistYp); 


logic[11:0] spriteindex;
//logic[9:0] DistXs, DistYs;
assign spriteindex = DistXs + (9'd64*DistYs); 
assign DistXs = DrawX % 10'd64;
assign DistYs = DrawY % 10'd48;




    always_comb
    begin:Select_Object
			player_on = 1'b0;
			wall_on = 1'b0;
			brick_on = 1'b0;
			bomb_on = 1'b0;
			wave_on = 1'b0;
			monster_on = 1'b0;
			empty_on = 1'b0;
	 
	 
		  if ( ((DistXp) >= (0)) && ((DistXp) <= (63)) && ((DistYp) >= (0)) && ((DistYp) <= (47)) ) 
					player_on = 1'b1;
        else   if ( map[mapx][mapy] == 3'd1 ) 
					wave_on = 1'b1; 
		  else if ( map[mapx][mapy] == 3'd2 ) 
					monster_on = 1'b1; 
		  else if ( map[mapx][mapy] == 3'd3 )
					wall_on = 1'b1; 
		  else if ( map[mapx][mapy] == 3'd4 )
					brick_on = 1'b1; 
		  else if ( map[mapx][mapy] == 3'd5 )
					bomb_on = 1'b1; 
		  else if (player_on != 1'b1)
					empty_on = 1'b1; 
		  else 
					empty_on = 1'b0;
     end 


	      
       
		 
    always_comb
    begin:RGB_Display
		  if ((stage == 2'd0))
		  begin 
            Red = 8'd255; 
            Green = 8'd255;
            Blue = 8'd255;				
		  end
		  else if ((stage == 2'd2))
		  begin 
            Red = 8'd0; 
            Green = 8'd0;
            Blue = 8'd0;				
		  end
			
        else if ((player_on == 1'b1)) 
        begin 
            Red = P_Red;   //sit the color from color_table
            Green = P_Green;
            Blue = P_Blue;
        end       
        else if((wall_on == 1'b1)) 
		  begin
				Red = S_Red;   //sit the color from color_table
            Green = S_Green;
            Blue = S_Blue;	
		  end	 
		  else if((brick_on == 1'b1)) 
		  begin
				Red = B_Red;   //sit the color from color_table
            Green = B_Green;
            Blue = B_Blue;	
		  end
		  else if((bomb_on == 1'b1)) 
		  begin
				Red = BB_Red;   //sit the color from color_table
            Green = BB_Green;
            Blue = BB_Blue;	
		  end
		  else if((wave_on == 1'b1)) 
		  begin
				Red = W_Red;   //sit the color from color_table
            Green = W_Green;
            Blue = W_Blue;	
		  end
		  else if((monster_on == 1'b1)) 
		  begin
				Red = M_Red;   //sit the color from color_table
            Green = M_Green;
            Blue = M_Blue;	
		  end
		  else begin 
            Red = 8'd0; 
            Green = 8'd93;
            Blue = 8'd9;
        end      
    end 
   //player
font_rom  font_rom_1(.addr(playerindex),.ROM_RED(P_Red), .ROM_GREEN(P_Green), .ROM_BLUE(P_Blue));
	//brick
brick  brick1(.addr(spriteindex), .BRICK_RED(B_Red), .BRICK_GREEN(B_Green), .BRICK_BLUE(B_Blue));
	 //wall
silver silver1(.addr(spriteindex), .SILVER_RED(S_Red), .SILVER_GREEN(S_Green), .SILVER_BLUE(S_Blue));
	 //bomb
bomb bomb1(.addr(spriteindex), .BOMB_RED(BB_Red), .BOMB_GREEN(BB_Green), .BOMB_BLUE(BB_Blue));
	 //flame
flame flame1(.addr(spriteindex), .FLAME_RED(W_Red), .FLAME_GREEN(W_Green), .FLAME_BLUE(W_Blue));
	//monster
monster monster1(.addr(spriteindex), .MONSTER_RED(M_Red), .MONSTER_GREEN(M_Green), .MONSTER_BLUE(M_Blue));

endmodule
