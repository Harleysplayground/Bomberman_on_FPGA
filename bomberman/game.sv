module game (input Reset, frame_clk,
				input [7:0]   keycode,
				output [299:0] map_1d,
				output [9:0]  playerX, playerY,
				output logic over			// 0: in game , 1: p1 wins, 2: p2 wins
				);
//enum logic [2:0] {EMPTY, WAVE, MONSTER, WALL, BRICK, BOMB} object;
enum logic [2:0] {up, down, left, right, set_bomb, no_op} command;

// Registers
logic [2:0] map[9:0][9:0];
logic [2:0] bomb_state;
logic [3:0] bomb_x, bomb_y;
logic [3:0] monsterX, monsterY;
logic [3:0] pre_monsterX, pre_monsterY;
logic [9:0] monster_counter;
logic [2:0] monster_command;
logic [2:0] prev_left,prev_right,prev_up,prev_down;

// Wire
logic [3:0] mapX, mapY, tempX, tempY; 
logic [9:0] next_playerX, next_playerY;

logic [7:0] UP, DOWN, LEFT, RIGHT, RELEASE;
logic enabled;

parameter xSpeed = 5'd4;
parameter ySpeed = 5'd3; 
parameter [7:0] SPACE = 8'h2C;		// Space 
parameter [7:0] A_UP = 8'h52;			 // Arrow up
parameter [7:0] A_DOWN = 8'h51;		 // Arrow down
parameter [7:0] A_LEFT = 8'h50;		 // Arrow left
parameter [7:0] A_RIGHT = 8'h4F;		 // Arrow rigt
parameter [9:0] width = 10'd64;
parameter [9:0] height = 10'd48;

assign mapX = playerX / width;
assign mapY = playerY / height;
assign UP = A_UP;
assign DOWN = A_DOWN;
assign LEFT = A_LEFT;
assign RIGHT = A_RIGHT;
assign RELEASE = SPACE;

always_ff @ (posedge Reset or posedge frame_clk)
begin

	if(Reset) begin
		map[0] <= '{3'd3, 3'd3, 3'd3, 3'd3, 3'd3, 3'd3, 3'd3, 3'd3,3'd3, 3'd3};
		map[1] <= '{3'd3, 3'd0, 3'd0, 3'd4, 3'd4, 3'd4, 3'd4, 3'd0,3'd0, 3'd3};
		map[2] <= '{3'd3, 3'd0, 3'd3, 3'd3, 3'd0, 3'd2, 3'd3, 3'd3,3'd0, 3'd3};
		map[3] <= '{3'd3, 3'd4, 3'd3, 3'd3, 3'd0, 3'd0, 3'd3, 3'd3,3'd4, 3'd3};
		map[4] <= '{3'd3, 3'd4, 3'd0, 3'd2, 3'd4, 3'd4, 3'd0, 3'd2,3'd4, 3'd3};
		map[5] <= '{3'd3, 3'd4, 3'd0, 3'd0, 3'd4, 3'd4, 3'd0, 3'd0,3'd4, 3'd3};
		map[6] <= '{3'd3, 3'd4, 3'd3, 3'd3, 3'd0, 3'd2, 3'd3, 3'd3,3'd4, 3'd3};
		map[7] <= '{3'd3, 3'd0, 3'd3, 3'd3, 3'd0, 3'd0, 3'd3, 3'd3,3'd0, 3'd3};
		map[8] <= '{3'd3, 3'd0, 3'd0, 3'd4, 3'd4, 3'd4, 3'd4, 3'd0,3'd0, 3'd3};
		map[9] <= '{3'd3, 3'd3, 3'd3, 3'd3, 3'd3, 3'd3, 3'd3, 3'd3,3'd3, 3'd3};
		monsterX <= 3'd4;
		monsterY <= 3'd5;
		monster_counter <= 10'd0;
	end
	
	else begin
		// Handle bomb	
		if(command == set_bomb) begin
			if(map[bomb_x-1'd1][bomb_y] == 3'd4 || map[bomb_x-1'd1][bomb_y] == 3'd2)
				prev_left = 3'd0;
			else
				prev_left = map[bomb_x-1'd1][bomb_y];

			if(map[bomb_x][bomb_y-1'd1] == 3'd4 || map[bomb_x][bomb_y-1'd1] == 3'd2)
				prev_down = 'd0;
			else
				prev_down = map[bomb_x][bomb_y-1'd1];
				
			if(map[bomb_x][bomb_y+1'd1] == 3'd4 || map[bomb_x][bomb_y+1'd1] == 3'd2)	
				prev_up = 3'd0;
			else
				prev_up = map[bomb_x][bomb_y+1'd1];
		
			if(map[bomb_x+1'd1][bomb_y] == 3'd4 || map[bomb_x+1'd1][bomb_y] == 3'd2)
				prev_right = 3'd0;
			else 
				prev_right = map[bomb_x+1'd1][bomb_y];

		end

		else if(bomb_state == 3'd0)
			map[bomb_x][bomb_y] = 3'd5;
		else if(bomb_state == 3'd1) begin
		
			map[bomb_x-3'd1][bomb_y] = 3'd1;
			map[bomb_x][bomb_y-3'd1] = 3'd1;
			map[bomb_x][bomb_y+3'd1] = 3'd1;
			map[bomb_x+3'd1][bomb_y] = 3'd1;
			map[bomb_x][bomb_y]  = 3'd1;
		end
		else if(bomb_state == 3'd3) begin
			map[bomb_x-3'd1][bomb_y] = prev_left;
			map[bomb_x][bomb_y-3'd1] = prev_down;
			map[bomb_x][bomb_y+3'd1] = prev_up;
			map[bomb_x+3'd1][bomb_y] = prev_right;
			map[bomb_x][bomb_y] = 3'd0;
		end
		// Update Monster
		if (monster_command != no_op) begin
			pre_monsterX <= monsterX;
			pre_monsterY <= monsterY;
		end
		if (monster_command == up) begin
			monsterX <= monsterX;
			monsterY <= monsterY -3'd1;
		end
		else if (monster_command == right) begin
			monsterX <= monsterX + 3'd1;
			monsterY <= monsterY;
		end
		else if (monster_command == down) begin
			monsterX <= monsterX;
			monsterY <= monsterY + 3'd1;
		end
		else if (monster_command == left) begin
			monsterX <= monsterX - 3'd1;
			monsterY <= monsterY;
		end
		
		if (map[pre_monsterX-3'd2][pre_monsterY] == 3'd2) begin
			map[monsterX-3'd2][monsterY] = 3'd2;
			map[pre_monsterX-3'd2][pre_monsterY] = 3'd0;
		end	
		if (map[pre_monsterX+3'd2][pre_monsterY] == 3'd2) begin
			map[monsterX+3'd2][monsterY] = 3'd2;
			map[pre_monsterX+3'd2][pre_monsterY] = 3'd0;
		end
		if (map[pre_monsterX][pre_monsterY-3'd2]== 3'd2) begin
			map[monsterX][monsterY-3'd2] = 3'd2;
			map[pre_monsterX][pre_monsterY-3'd2] = 3'd0;
		end
		if (map[pre_monsterX][pre_monsterY+3'd2]== 3'd2) begin
			map[monsterX][monsterY+3'd2] = 3'd2;
			map[pre_monsterX][pre_monsterY+3'd2] = 3'd0;
		end
		monster_counter <= (monster_counter + 10'd1) % 479;
		// Update map
		map <= map;
	end
end	

always_comb
begin
					
	// death detection
	over = 1'd0;
	if (map[playerX/width][playerY/height] == 3'd1 || map[playerX/width][playerY/height] == 3'd2) begin
		over = 1'd1;
	end
	else if (map[(playerX + width -1'd1)/ width][playerY/height] == 3'd1 || map[(playerX + width -1'd1)/ width][playerY/height] == 3'd2) begin
		over = 1'd1;
	end
	else if (map[playerX/width][(playerY + height -1'd1)/height] == 3'd1 || map[playerX/width][(playerY + height -1'd1)/height] == 3'd2) begin
		over = 1'd1;
	end
	else if (map[(playerX + width -1'd1)/ width][(playerY + height -1'd1)/height] == 3'd1 || map[(playerX + width -1'd1)/ width][(playerY + height -1'd1)/height] == 3'd2) begin
		over = 1'd1;
	end

	// win detection
		
	// Update command
	unique case(keycode)
		UP: begin
			next_playerX = playerX;
			next_playerY = playerY - ySpeed;
			command = up;
		end
		
		DOWN: begin									
			next_playerX = playerX;
			next_playerY = playerY + ySpeed;
			command = down;
		end
		
		LEFT: begin									
			next_playerX = playerX - xSpeed;
			next_playerY = playerY;
			command = left;
		end
		
		RIGHT: begin								
			next_playerX = playerX + xSpeed;
			next_playerY = playerY;
			command = right;
		end
		RELEASE: begin
			next_playerX = playerX;
			next_playerY = playerY;
			command = set_bomb;
		end	
		default: begin
			next_playerX = playerX;
			next_playerY = playerY;
			command = no_op;
		end
	endcase

	// Collision detection
	tempX = next_playerX / width;
	tempY = next_playerY / height;
	enabled = 1'd0;
	if(command >= 0 && command < no_op)begin
		if (map[tempX][tempY] < 3'd3 || map[tempX][tempY] == 3'd5) begin
			tempX = (next_playerX + width -1'd1)/ width;
			tempY = next_playerY / height;
			if (map[tempX][tempY] < 3'd3 || map[tempX][tempY] == 3'd5) begin
				tempX = next_playerX/ width;
				tempY = (next_playerY + height - 1'd1) / height ;
				if (map[tempX][tempY] < 3'd3 || map[tempX][tempY] == 3'd5) begin
					tempX = (next_playerX + width -1'd1)/ width;
					tempY = (next_playerY + height - 1'd1) / height ;
					if (map[tempX][tempY] < 3'd3 || map[tempX][tempY] == 3'd5) begin
						enabled = 1'd1;
					end
				end
			end
		end
	end
	
	// monster command
	monster_command = no_op;
	if (monster_counter == 10'd0)
		monster_command = up;
	else if (monster_counter == 10'd120)
		monster_command = right;
	else if (monster_counter == 10'd240)
		monster_command = down;
	else if (monster_counter == 10'd360)
		monster_command = left;
end

 player player1(.Reset(Reset),
					 .frame_clk(frame_clk),
					 .command(command),
					 .enabled(enabled),
					 .xSpeed(xSpeed),
					 .ySpeed(ySpeed),
					 .playerX(playerX), .playerY(playerY),
					 .state(bomb_state),  // 0: placed a bomb 1: flame 2:empty
					 .outx(bomb_x),
					 .outy(bomb_y));
					 
					 
					 
	
					 

assign map_1d = { map[0][0], map[0][1], map[0][2], map[0][3], map[0][4], map[0][5], map[0][6], map[0][7], map[0][8], map[0][9],
						map[1][0], map[1][1], map[1][2], map[1][3], map[1][4], map[1][5], map[1][6], map[1][7], map[1][8], map[1][9],
						map[2][0], map[2][1], map[2][2], map[2][3], map[2][4], map[2][5], map[2][6], map[2][7], map[2][8], map[2][9],
						map[3][0], map[3][1], map[3][2], map[3][3], map[3][4], map[3][5], map[3][6], map[3][7], map[3][8], map[3][9],
						map[4][0], map[4][1], map[4][2], map[4][3], map[4][4], map[4][5], map[4][6], map[4][7], map[4][8], map[4][9],
						map[5][0], map[5][1], map[5][2], map[5][3], map[5][4], map[5][5], map[5][6], map[5][7], map[5][8], map[5][9],
						map[6][0], map[6][1], map[6][2], map[6][3], map[6][4], map[6][5], map[6][6], map[6][7], map[6][8], map[6][9],
						map[7][0], map[7][1], map[7][2], map[7][3], map[7][4], map[7][5], map[7][6], map[7][7], map[7][8], map[7][9],
						map[8][0], map[8][1], map[8][2], map[8][3], map[8][4], map[8][5], map[8][6], map[8][7], map[8][8], map[8][9],
						map[9][0], map[9][1], map[9][2], map[9][3], map[9][4], map[9][5], map[9][6], map[9][7], map[9][8], map[9][9]
						};

	
endmodule