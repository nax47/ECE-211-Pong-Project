`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2015 11:07:59 PM
// Design Name: 
// Module Name: counter_bcd
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


module counter_bcd(input logic clk, output logic [3:0] Q,
       output logic carry, input logic reset, input logic en);
  
  assign carry = ((Q == 4'b1001) && en);
  
   always_ff @( posedge clk )
     begin
     if(reset) 
     Q <= 4'b0000;
     
     else if(en)   
        if(Q == 4'b1001)
        Q <= 4'b0000;
        else
        Q <= Q + 1;     
     end
endmodule // counter

