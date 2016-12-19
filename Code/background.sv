`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2015 01:52:58 PM
// Design Name: 
// Module Name: background
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


module background(
    input logic [9:0] vga_x,
    input logic [9:0] vga_y,
    output logic [11:0] rgb
    );
    
    logic [11:0] rgb1;
    logic [11:0] rgb2;
    logic [11:0] rgb3;
    logic [11:0] rgb3_n;
    logic [11:0] alt_bit;
    assign alt_bit = {12{vga_y[4]}};
    
    rectgen #(.XLOC(0), .YLOC(128), .WIDTH(799), .HEIGHT(8), .COLOR(12'hfff)) top_wall(.x(vga_x), .y(vga_y), .rgb(rgb1));
    rectgen #(.XLOC(0), .YLOC(512), .WIDTH(799), .HEIGHT(8), .COLOR(12'hfff)) bottom_wall(.x(vga_x), .y(vga_y), .rgb(rgb2));
    rectgen #(.XLOC(396), .YLOC(136), .WIDTH(8), .HEIGHT(376), .COLOR(12'hfff)) net(.x(vga_x), .y(vga_y), .rgb(rgb3));
    
    
    assign rgb3_n = rgb3 & alt_bit;
    assign rgb = rgb1 | rgb2 | rgb3_n;
    
    
endmodule
