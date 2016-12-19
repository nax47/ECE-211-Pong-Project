`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2015 02:46:49 PM
// Design Name: 
// Module Name: paddle
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


module paddle(
    input logic reset,
    input logic up_I,
    input logic down_I,
    input logic [9:0] vga_x,
    input logic [9:0] vga_y,
    output logic [11:0] rgb,
    input logic frame,
    input logic clk,
    output logic tophit,
    output logic midhit,
    output logic bothit,
    input logic [9:0] ball_x,
    input logic [9:0] ball_y
    );
    
    parameter XLOC = 0;
    parameter COLOR = 12'hfff;
    parameter OFFSET = 0;
    
    mvrectgen #(.OFFSET(OFFSET), .XLOC(XLOC), .YLOC(), .WIDTH(), .HEIGHT(), .COLOR(COLOR), .UP_LIMIT(136), .DOWN_LIMIT(512)) paddle(.x(vga_x), .y(vga_y), .rgb(rgb), .clk(clk), .up(up_I), .down(down_I), .reset(reset), .en(frame), .ball_x(ball_x), .ball_y(ball_y), .tophit(tophit), .midhit(midhit), .bothit(bothit));
    
endmodule
