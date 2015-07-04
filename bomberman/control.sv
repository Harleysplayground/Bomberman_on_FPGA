module control (input Reset, frame_clk,
					 input [7:0]   keycode,
					 input 			over,
					 output			reset,
					 output [1:0]  stage);
					 
enum logic [1:0] {WAIT, RUN, OVER}   state, next_state;
parameter [7:0] enter = 8'h28;

always_ff @ (posedge Reset or posedge frame_clk)
begin
	if(Reset) begin
		state <= WAIT;
	end
	else begin
		state <= next_state;
	end
	
end

always_comb
begin
	next_state = state;
	unique case (state)
		WAIT: begin
			if(keycode == enter)
				next_state = RUN;
		end
		RUN: begin
			if(over != 1'd0)
				next_state = OVER;
		end
		
		OVER: begin
			if(keycode == enter)
				next_state = WAIT;
		end
	endcase
end

always_comb
begin
	reset = 0;
	stage = state;
	unique case (state)
		WAIT: begin
			reset = 1;
		end
		RUN: begin
			reset = 0;
		end
		
		OVER: begin
			reset = 1;
		end
	endcase
end

endmodule