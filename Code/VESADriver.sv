`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Signal Generator for VESA (800x600@72Hz VGA)
// Generates Hsync and Vsync signals
// Outputs current screen X and Y coordinates for use elsewhere
//  Keep in mind that computer geometry's origin is at the top-left, and 
//  positive-y is down. 
// Timings from http://tinyvga.com/vga-timing/800x600@72Hz, assuming a 50Mhz clock.
//////////////////////////////////////////////////////////////////////////////////
module VESADriver(
		  input logic clk,
		  output logic Hsyncb,
		  output logic Vsyncb,
		  output logic [9:0] x,
		  output logic [9:0] y = 0,
		  output logic frame
		  );

   parameter 		 HLEN             = 11'd800;
   parameter 		 HFRONT_PORCH_LEN = 11'd56;
   parameter 		 HSYNC_WIDTH      = 11'd120;
   parameter 		 HBACK_PORCH_LEN  = 11'd64;
   parameter 		 HTOTAL          = 11'd1040;
 		 
   
   parameter 		 VHEIGHT          = 10'd600;
   parameter  		 VFRONT_PORCH_LEN = 10'd37;
   parameter 		 VSYNC_LEN        = 10'd6; 
   parameter 		 VBACK_PORCH_LEN  = 23;
   parameter 		 VTOTAL          = 666;
 		 
   
   //The back porch requires 11 bits of x, but only 10
   //bits are needed to address the screen. 
   //Slicing off the last bit makes X and Y have the same 
   //dimension, bitwise. It's a bit nicer to work with. 
   logic [10:0] 	 xinternal = 0;
   assign 		 x = xinternal[9:0];
   
   assign 		 Hsync = ~((xinternal > HLEN + HFRONT_PORCH_LEN)
				   && (xinternal < HLEN + HFRONT_PORCH_LEN + HSYNC_WIDTH));
   assign 		 Vsync = ~((y > VHEIGHT + VFRONT_PORCH_LEN)
				   && (y < VHEIGHT + VFRONT_PORCH_LEN + VSYNC_LEN));
   assign 		 frame = (xinternal == HTOTAL-1 && y == VTOTAL-1);
   
   always_ff @(posedge clk) begin
      Hsyncb <= Hsync;
      Vsyncb <= Vsync;
      
      if (xinternal == HTOTAL-1 && y != VTOTAL-1) begin
	 xinternal <= 0;
	 y <= y+1;
      end
      else xinternal<= xinternal+1;
      
      if (xinternal == HTOTAL-1 && y == VTOTAL-1) begin
	 y <= 0;
	 xinternal <= 0;
      end
   end
   
endmodule
