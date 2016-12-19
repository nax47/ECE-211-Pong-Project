`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2015 03:05:38 PM
// Design Name: 
// Module Name: mvrectgen
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


module mvrectgen(
    input logic clk,
    input logic reset,
    input logic en,
    input logic [9:0] x,
    input logic [9:0] y,
    input logic up,
    input logic down,
    output logic [11:0] rgb,
    input logic [9:0] ball_x,
    input logic [9:0] ball_y,
    output logic tophit,
    output logic midhit,
    output logic bothit
    );
    
   parameter WIDTH = 10; // dimension
   parameter HEIGHT = 75;
   parameter OFFSET = 0;
   parameter XLOC = 0; // location on reset
   parameter YLOC = (600-HEIGHT)/2;
   parameter COLOR = 12'hfff; // output color
   parameter UP_LIMIT = 0;
   parameter DOWN_LIMIT = 600;
   
   logic [9:0] Y_LOC_new = YLOC;
   
       always_ff @(posedge clk)
       begin
       if (reset) begin Y_LOC_new <= YLOC; end
       else if(en && up && ~down) 
        begin 
            if(Y_LOC_new <= UP_LIMIT)
                Y_LOC_new <= Y_LOC_new;
            else
                Y_LOC_new <= Y_LOC_new - 2;
        end
       else if(en && down && ~up) 
         begin 
             if(Y_LOC_new >= (DOWN_LIMIT-HEIGHT))
                 Y_LOC_new <= Y_LOC_new;
             else
                 Y_LOC_new <= Y_LOC_new + 2;
         end
        end
        
        always_comb
        begin
        
            tophit <= 1'b0;
            midhit <= 1'b0;
            bothit <= 1'b0;
         
                if(((ball_x+OFFSET) >= XLOC) && ((ball_x+OFFSET) <= XLOC + WIDTH))
                begin
         
                    if(ball_y >= (Y_LOC_new) && ball_y < (Y_LOC_new + (HEIGHT/3)))
                        tophit <= 1'b1;
                    else if(ball_y >= (Y_LOC_new + (HEIGHT/3)) && ball_y < (Y_LOC_new + (2*HEIGHT/3)))
                        midhit <= 1'b1;
                    else if(ball_y >= (Y_LOC_new + (2*HEIGHT/3)) && ball_y < (Y_LOC_new + (HEIGHT)))
                        bothit <= 1'b1;
         
                end
         
         
        end
        
      
     always_comb
     begin
     if(x >= (XLOC) && x < (XLOC + WIDTH) && y >= (Y_LOC_new) && y < (Y_LOC_new + HEIGHT))
        rgb = COLOR;
     else 
        rgb = 12'h000;
     end
      
   
endmodule
