`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2015 11:12:27 PM
// Design Name: 
// Module Name: Multiplexer
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


module Multiplexer(
    input logic [2:0] a,
    input logic [3:0] in0,in1,in2,in3,in4,in5,in6,in7,
    output logic [3:0] y,
    output logic dp
    );
    
    always_comb
        case(a)
            3'b000: begin y=in0; dp=1'b0; end
            3'b001: begin y=in1; dp=1'b0; end
            3'b010: begin y=in2; dp=1'b1; end
            3'b011: begin y=in3; dp=1'b0; end
            3'b100: begin y=in4; dp=1'b0; end
            3'b101: begin y=in5; dp=1'b0; end
            3'b110: begin y=in6; dp=1'b0; end
            3'b111: begin y=in7; dp=1'b0; end
        endcase            
            
endmodule

