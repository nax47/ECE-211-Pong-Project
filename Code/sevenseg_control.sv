`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2015 11:11:33 PM
// Design Name: 
// Module Name: sevenseg_control
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


module sevenseg_control(
    input logic clk,
    input logic right_en,
    input logic left_en,
    input logic reset,
    output logic [7:0] an,
    output logic [6:0] segments,
    output logic dp,
    input logic frame,
    output logic win
    );
    
    logic [2:0] q;
    logic [3:0] y;
    logic [3:0] in0;
    logic [3:0] in1;
    logic [3:0] in2= 4'h0;
    logic [3:0] in3= 4'h0;
    logic [3:0] in4= 4'h0;
    logic [3:0] in5= 4'h0;
    logic [3:0] in6;
    logic [3:0] in7;
    logic en1;
    logic en2;
    logic sclk;
    logic right_en2;
    logic left_en2;
    logic reset2;
    
    assign right_en2 = right_en && frame;
    assign left_en2 = left_en && frame;
    assign reset2 = reset && frame;
    assign win = ((in1&&right_en2) || (in7&&left_en2));
    
    clkdiv #(.DIVFREQ(1000)) clk(.clk(clk), .reset(1'b0), .sclk(sclk));
    
    counter_bcd dig0(.clk(clk), .Q(in0), .carry(en1), 
.reset(reset2), .en(right_en2));
    counter_bcd dig1(.clk(clk), .Q(in1), .carry(), 
.reset(reset2), .en(en1));
    counter_bcd dig6(.clk(clk), .Q(in6), .carry(en2), 
.reset(reset2), .en(left_en2));
    counter_bcd dig7(.clk(clk), .Q(in7), .carry(), 
.reset(reset2), .en(en2));
    counter_3bit cnt(.clk(sclk), .q(q));
    decoder3_8 decoder(.a(q), .y(an));
    Multiplexer mux(.a(q), .y(y), .in0(in0), .in1(in1), .in2(in2), 
.in3(in3), .in4(in4), .in5(in5), .in6(in6), .in7(in7), .dp(dp));
    seven_seg seg(.data(y), .segments(segments));
    
endmodule

