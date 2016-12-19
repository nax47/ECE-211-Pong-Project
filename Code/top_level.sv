`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2015 01:48:25 PM
// Design Name: 
// Module Name: top_level
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


module top_level(
    input logic clk_100mhz,
    input logic up_sw1,
    input logic down_sw1,
    input logic up_sw2,
    input logic down_sw2,
    input logic reset,
    input logic serve,
    output logic [3:0] vgaRed,
    output logic [3:0] vgaGreen,
    output logic [3:0] vgaBlue,
    output logic Hsync,
    output logic Vsync,
    output logic [7:0] an_n,
    output logic [6:0] segments_n
    );
    
    logic sclk;
    logic [9:0] x;
    logic [9:0] y;
    logic [11:0] rgb_back;
    logic [11:0] rgb_leftpad;
    logic [11:0] rgb_rightpad;
    logic [11:0] rgb_ball;
    logic [11:0] color;
    logic en;
    logic tophit_l;
    logic midhit_l;
    logic bothit_l;
    logic tophit_r;
    logic midhit_r;
    logic bothit_r;
    logic [9:0] ball_x;
    logic [9:0] ball_y;
    logic [7:0] an;
    logic [6:0] segments;
    logic visible;
    logic srv_l;
    logic srv_r;
    logic miss_l;
    logic miss_r;  
    
    
    clkdiv #(.DIVFREQ(50*1000*1000)) clk(.clk(clk_100mhz), .reset(1'b0), .sclk(sclk));
    VESADriver vesa(.clk(sclk), .Hsyncb(Hsync), .Vsyncb(Vsync), .x(x), .y(y), .frame(en));
    background back(.vga_x(x), .vga_y(y), .rgb(rgb_back));
    paddle #(.OFFSET(0), .XLOC(25), .COLOR(12'hf00)) left_paddle(.reset(reset), .up_I(up_sw1), .down_I(down_sw1), .vga_x(x), .vga_y(y), .rgb(rgb_leftpad), .frame(en), .clk(sclk), .tophit(tophit_l), .midhit(midhit_l), .bothit(bothit_l), .ball_x(ball_x), .ball_y(ball_y));
    paddle #(.OFFSET(10), .XLOC(765), .COLOR(12'h00f)) right_paddle(.reset(reset), .up_I(up_sw2), .down_I(down_sw2), .vga_x(x), .vga_y(y), .rgb(rgb_rightpad), .frame(en), .clk(sclk), .tophit(tophit_r), .midhit(midhit_r), .bothit(bothit_r), .ball_x(ball_x), .ball_y(ball_y));
    ball #(.UP_LIMIT(136), .DOWN_LIMIT(512)) game_ball(.reset(reset), .tophit_l(tophit_l), .midhit_l(midhit_l), .bothit_l(bothit_l), .tophit_r(tophit_r), .midhit_r(midhit_r), .bothit_r(bothit_r), .clk(sclk), .frame(en), .vga_x(x), .vga_y(y), .rgb(rgb_ball), .visible(visible), .srv_l(srv_l), .srv_r(srv_r), .miss_l(miss_l), .miss_r(miss_r), .ball_x(ball_x), .ball_y(ball_y));
    controlunitFSM cntrl(.clk(sclk), .reset(reset), .serve(serve), .visible(visible), .srv_l(srv_l), .srv_r(srv_r), .miss_l(miss_l), .miss_r(miss_r), .frame(en), .an(an), .segments(segments));
    
    assign color = rgb_back | rgb_leftpad | rgb_rightpad | rgb_ball;
    assign {vgaRed, vgaGreen, vgaBlue} = color;
    assign segments_n = ~segments;
    assign an_n = ~an;
    
endmodule
