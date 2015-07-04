//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//                                                                       --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 7                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper ( input        [9:0] BallX, BallY, DrawX, DrawY, 
							  input			[7:0]  SP_Red, SP_Green, SP_Blue,
                       output logic [7:0]  Red, Green, Blue,
							  output logic [9:0] DistX, DistY);
    
    logic ball_on;


	 logic [10:0] Addr_on_sprite, Addr;
	 assign DistX = DrawX - BallX;
    assign DistY = DrawY - BallY;
	 assign Addr = 0;

	 
    always_comb
    begin:Ball_on_proc
        if (((DistX) <= (7)) && ((DistX) >= (0)) && ((DistY) <= (7)) && ((DistY) >= (0)) ) 
            ball_on = 1'b1;
        else 
            ball_on = 1'b0;
     end 
       
    always_comb
    begin:RGB_Display
        if ((ball_on == 1'b1)) 
        begin 
            Red = SP_Red;   //sit the color from color_table
            Green = SP_Green;
            Blue = SP_Blue;
        end       
        else 
        begin 
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h7f - DrawX[9:3];
        end      
    end 
    
	 
endmodule
