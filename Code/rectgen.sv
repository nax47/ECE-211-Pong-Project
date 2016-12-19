`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2015 01:38:25 PM
// Design Name: 
// Module Name: rectgen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module rectgen(
    input logic [9:0] x,
    input logic [9:0] y,
    output logic [11:0] rgb
    );
    
     // Upper-left-hand corner
   parameter XLOC = 100;
   parameter YLOC = 100;
   // Dimensions
   parameter WIDTH = 100;
   parameter HEIGHT = 100;
   // RGB
   parameter COLOR = 12'hf00;
   
   always_comb
     if(x >= XLOC && x < (XLOC + WIDTH) && y >= YLOC && y < (YLOC + HEIGHT))
        rgb = COLOR;
     else 
        rgb = 12'h000;
     
   
endmodule
