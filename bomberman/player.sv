//-------------------------------------------------------------------------
//    Ball.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 298 Lab 7                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  player (input Reset, frame_clk,
					input [2:0]   command,
					input 		  enabled,
					input [4:0]	  xSpeed, ySpeed,
               output [9:0]  playerX, playerY,
					output [2:0]	state,
					output [3:0]   outx,outy);
					
 enum logic [2:0] {up, down, left, right, set_bomb, no_op} command_name;   
 // Player state 
 logic 		 is_alive;
 logic [3:0] bomb_count;
 logic [3:0] bomb_power;
 // Player position, speed within 480 x 640
 logic [9:0] player_X_pos;
 logic [9:0] player_Y_pos;
 logic [9:0] player_X_motion;
 logic [9:0] player_Y_motion;
 logic [3:0] mapX,mapY;

 // Bomb_command
 logic [2:0] bomb_command;
 
 
 assign playerX = player_X_pos;
 assign playerY = player_Y_pos;
 assign mapX = playerX / 8'd64;
 assign mapY = playerY / 8'd48;

 
 // Initial set up
 parameter [9:0] player_X_pos_init = 10'd64;    
 parameter [9:0] player_Y_pos_init = 10'd48; 
 parameter [3:0] bomb_count_init =1;      
 parameter [3:0] bomb_power_init =1;

 // Player size
parameter [9:0] width = 10'd64;
parameter [9:0] height = 10'd48; 
 
 always_ff @ (posedge Reset or posedge frame_clk )
 begin: Update_Player
	if (Reset)  // Asynchronous Reset
	begin
		is_alive <= 1'b1;
		bomb_count <= bomb_count_init; 
		bomb_power <= bomb_power_init; 
		player_X_pos <= player_X_pos_init;
		player_Y_pos <= player_Y_pos_init;
	end
		
	else begin  
		 // Update player position
		 player_Y_pos <= (player_Y_pos + player_Y_motion);  
		 player_X_pos <= (player_X_pos + player_X_motion);
		 
		 if(command == set_bomb && bomb_count != 0 && state == 3'd2) begin
			bomb_count <= 0;
		 end
		 else if ( state == 3'd3 && bomb_count == 0) begin
			bomb_count <= 1;
		 end
	end  
end

always_comb
begin
	bomb_command = no_op;
	if(command == set_bomb && bomb_count != 0 && state == 3'd2) begin
		bomb_command = command;
	end 
	
	if(enabled) begin 
		// update by command
		unique case(command)
			3'd0: begin
				player_X_motion = 10'd0;
				player_Y_motion = (~ (ySpeed) + 1'b1);
			end
			
			3'd1: begin									
				player_X_motion = 10'd0;
				player_Y_motion = ySpeed;
			end
			
			3'd2: begin									
				player_X_motion = (~ (xSpeed) + 1'b1);
				player_Y_motion = 10'd0;
			end
			
			3'd3: begin								
				player_X_motion = xSpeed;
				player_Y_motion = 10'd0;
			end
			
			default: begin
				player_X_motion = 10'd0;
				player_Y_motion = 10'd0;
			end
		endcase
	end
	else begin
		player_X_motion = 10'd0;
		player_Y_motion = 10'd0;
	end
end


bob bob1(.*, .command(bomb_command));
 
 
 
endmodule
