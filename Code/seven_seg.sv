`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2015 11:15:42 PM
// Design Name: 
// Module Name: seven_seg
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


module seven_seg(input logic [3:0] data,
 output logic [6:0] segments);
       // Output patterns: abcdefg
   always_comb
     case (data)
       4'h0: segments = 7'b1111110;
       4'h1: segments = 7'b0110000;
       4'h2: segments = 7'b1101101;
       4'h3: segments = 7'b1111001;
       4'h4: segments = 7'b0110011;
       4'h5: segments = 7'b1011011;
       4'h6: segments = 7'b1011111;
       4'h7: segments = 7'b1110000;
       4'h8: segments = 7'b1111111;
       4'h9: segments = 7'b1110011;
       4'hA: segments = 7'b1110111;
       4'hB: segments = 7'b0011111;
       4'hC: segments = 7'b1001110;
       4'hD: segments = 7'b0111101;
       4'hE: segments = 7'b1001111;
       4'hF: segments = 7'b1000111;
       default: segments = 7'b0000000;
     endcase // case(data)
endmodule // seven_seg

