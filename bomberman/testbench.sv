`timescale 1ns / 1ps

module testbench();

logic [9:0]  playerX, playerY;
logic reset, over; 
logic clk = 0;
logic [7:0] keycode;
logic [299:0] map_1d;
parameter [7:0] SPACE = 8'h2C;		// Space 
parameter [7:0] A_UP = 8'h52;			 // Arrow up
parameter [7:0] A_DOWN = 8'h51;		 // Arrow down
parameter [7:0] A_LEFT = 8'h50;		 // Arrow left
parameter [7:0] A_RIGHT = 8'h4F;		 // Arrow rigt
game game1 (.Reset(reset), .frame_clk(clk), .*);

always begin: CLOCK_GENERATION
	#1 clk = ~clk;
end

initial begin: CLOCK_INITIALIZATION
	clk = 0;
end

initial begin: TEST
	reset = 1;
	
	#4 reset = 0;

	#4 keycode = A_RIGHT;
	
	#4 keycode = A_RIGHT;
		
		#4 keycode = A_RIGHT;
			#4 keycode = A_RIGHT;
				#4 keycode = A_RIGHT;
					#4 keycode = A_RIGHT;
	#6 keycode = A_RIGHT;
	
	#4 keycode = SPACE;
	
	#4 keycode = A_UP;
	
	#6 keycode = A_RIGHT;
	
	#6 keycode = A_DOWN;
	
	#4 keycode = A_LEFT;
end

endmodule