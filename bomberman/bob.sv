module bob( input Reset, frame_clk,
				input[2:0] command,
				input[3:0]  mapX,mapY,
				output logic [2:0] state,    // 0: placed a bomb 1: flame  2:empty 3:restore flamed object
				output logic [3:0] outx,outy);
 

 logic[9:0] Counter;
 logic[3:0] bombx,bomby;

 parameter [9:0] restore_time = 10'd10;
 parameter [9:0] flame_time = restore_time + 10'd60;
 parameter [9:0] bomb_cycle = flame_time + 10'd120;

 
always_ff @ (posedge Reset or posedge frame_clk)
begin

		if(Reset) begin
			Counter = 10'd0;
			state = 3'd2;
			bombx = 4'd0;
			bomby = 4'd0;
			end
			
		else if(command == 3'd4 && Counter == 10'd0) begin  //if command is Release, place the bomb at (x,y) and start counting
			Counter = bomb_cycle;
			bombx = mapX;
			bomby = mapY;
			end 
			
			
		else if(Counter > flame_time) begin
			Counter = Counter - 1;
			state = 3'd0;
			outx = bombx;
			outy = bomby;
			end 
		
		else if(Counter > restore_time) begin
			Counter = Counter - 1;
			state = 3'd1;
			outx = bombx;
			outy = bomby;
			end
			
		else if(Counter > 10'd1) begin
			Counter = Counter - 1;
			state = 3'd3;
			outx = bombx;
			outy = bomby;
			end
			
		else begin
			Counter = 10'd0;
			state = 3'd2;
			end
end

endmodule
