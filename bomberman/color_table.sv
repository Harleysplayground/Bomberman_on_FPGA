module color_table(input color,
						 input [9:0] DrawX,
						 output logic [7:0] SP_Red, SP_Blue, SP_Green);
						 

						 
always_comb
begin
				unique case (color)
				//white
				4'd2: 
				begin
					SP_Red = 8'hff; 
					SP_Green = 8'hff;
					SP_Blue = 8'hff;			
				end
				//black
				4'd1: begin
					SP_Red = 8'hff; 
					SP_Green = 8'hff;
					SP_Blue = 8'hff;
				end
				//blue
				4'd0: begin
					SP_Red = 8'h00; 
					SP_Green = 8'h00;
					SP_Blue = 8'h7f - DrawX[9:3];
				end
				/*//red
				4'd2: begin
					SP_Red = 8'hff; 
					SP_Green = 8'h00;
					SP_Blue = 8'h00;			
				end
				//green
				4'd3: begin
					SP_Red = 8'h00; 
					SP_Green = 8'hff;
					SP_Blue = 8'h00;			
				end
				//blue
				4'd4: begin
					SP_Red = 8'h00; 
					SP_Green = 8'h00;
					SP_Blue = 8'hff;			
				end
				
				default: begin
					SP_Red = SP_Red;
					SP_Blue = SP_Blue;
					SP_Green = SP_Green;
				end		*/
			endcase
end 


endmodule