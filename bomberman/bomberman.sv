//-------------------------------------------------------------------------
//      lab7_usb.sv                                                      --
//      Christine Chen                                                   --
//      Fall 2014                                                        --
//                                                                       --
//      Fall 2014 Distribution                                           --
//                                                                       --
//      For use with ECE 385 Lab 7                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module  bomberman 		( input         Clk,
                                     Reset,
							  output [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
							  output [8:0]  LEDG,
							  output [17:0] LEDR,
							  // VGA Interface 
                       output [7:0]  Red,
							                Green,
												 Blue,
							  output        VGA_clk,
							                sync,
												 blank,
												 vs,
												 hs,
							  // CY7C67200 Interface
							  inout [15:0]  OTG_DATA,						//	CY7C67200 Data bus 16 Bits
							  output [1:0]  OTG_ADDR,						//	CY7C67200 Address 2 Bits
							  output        OTG_CS_N,						//	CY7C67200 Chip Select
												 OTG_RD_N,						//	CY7C67200 Write
												 OTG_WR_N,						//	CY7C67200 Read
												 OTG_RST_N,						//	CY7C67200 Reset
							  input			 OTG_INT,						//	CY7C67200 Interrupt
							  // SDRAM Interface for Nios II Software
							  output [12:0] sdram_wire_addr,				// SDRAM Address 13 Bits
							  inout  [31:0] sdram_wire_dq,				// SDRAM Data 32 Bits
							  output [1:0]  sdram_wire_ba,				// SDRAM Bank Address 2 Bits
							  output [3:0]  sdram_wire_dqm,				// SDRAM Data Mast 4 Bits
							  output			 sdram_wire_ras_n,			// SDRAM Row Address Strobe
							  output			 sdram_wire_cas_n,			// SDRAM Column Address Strobe
							  output			 sdram_wire_cke,				// SDRAM Clock Enable
							  output			 sdram_wire_we_n,				// SDRAM Write Enable
							  output			 sdram_wire_cs_n,				// SDRAM Chip Select
							  output			 sdram_clk						// SDRAM Clock
											);

	 logic [7:0] data;
    logic Reset_h, vssig;
    logic [9:0] drawxsig, drawysig, player1xsig, player1ysig, DistXs, DistYs;
	 logic [7:0] keycode;
	 logic [3:0] mapx, mapy;
	 logic [299:0] map_1d;
	 logic over;
	 logic [1:0] stage;
    
    assign {Reset_h}=~ (Reset);  // The push buttons are active low
	 assign OTG_FSPEED = 1'bz;
	 assign OTG_LSPEED = 1'bz;
	
	 usb_system usbsys_instance(
										 .clk_clk(Clk),         
										 .reset_reset_n(1'b1),   
										 .sdram_wire_addr(sdram_wire_addr), 
										 .sdram_wire_ba(sdram_wire_ba),   
										 .sdram_wire_cas_n(sdram_wire_cas_n),
										 .sdram_wire_cke(sdram_wire_cke),  
										 .sdram_wire_cs_n(sdram_wire_cs_n), 
										 .sdram_wire_dq(sdram_wire_dq),   
										 .sdram_wire_dqm(sdram_wire_dqm),  
										 .sdram_wire_ras_n(sdram_wire_ras_n),
										 .sdram_wire_we_n(sdram_wire_we_n), 
										 .sdram_out_clk_clk(sdram_clk),
										 .keycode_export(keycode),  
										 .usb_DATA(OTG_DATA),    
										 .usb_ADDR(OTG_ADDR),    
										 .usb_RD_N(OTG_RD_N),    
										 .usb_WR_N(OTG_WR_N),    
										 .usb_CS_N(OTG_CS_N),    
										 .usb_RST_N(OTG_RST_N),   
										 .usb_INT(OTG_INT) );
	
    vga_controller vgasync_instance(.*,
	                                 .Clk(Clk),
											   .Reset(Reset_h),
											   .pixel_clk(VGA_clk),
											   .DrawX(drawxsig),
							 			   .DrawY(drawysig) );
					
	 game game1(.Reset(reset),
	                    .frame_clk(vs),    // Vertical Sync used as an "ad hoc" 60 Hz clock signal
							  .keycode(keycode),
							  .map_1d(map_1d),
							  .playerX(player1xsig), .playerY(player1ysig),
							  .over(over));
							  
	/* player player2(.Reset(Reset_h),
	                    .frame_clk(vs),    // Vertical Sync used as an "ad hoc" 60 Hz clock signal
							  .keycode(keycode),
							  .id(2),	  
							  .playerX(player2xsig), .playerY(player2ysig));
	*/
	
	 graphics graphics1(.PlayerXp1(player1xsig), .PlayerYp1(player1ysig), .DrawX(drawxsig), .DrawY(drawysig), .map_1d(map_1d), .*);
	 control control1(.Reset(Reset_h), .frame_clk(vs),
					 .keycode(keycode),
					 .over(over),
					 .reset(reset),
					 .stage(stage));									
	
	 HexDriver hex_inst_0 (player1xsig[7:4], HEX0);
	 HexDriver hex_inst_1 (player1xsig[9:8], HEX1);

endmodule
