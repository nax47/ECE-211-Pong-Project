`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2015 01:32:07 PM
// Design Name: 
// Module Name: ball
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


module ball(
    input logic reset,
    input logic tophit_l,
    input logic midhit_l,
    input logic bothit_l,
    input logic tophit_r,
    input logic midhit_r,
    input logic bothit_r,
    input logic clk,
    input logic frame,
    input logic [9:0] vga_x,
    input logic [9:0] vga_y,
    output logic [11:0] rgb,
    input logic visible,
    input logic srv_l,
    input logic srv_r,
    output logic miss_l,
    output logic miss_r,
    output logic [9:0] ball_x,
    output logic [9:0] ball_y
    );

   parameter WIDTH = 10; // dimension
   parameter HEIGHT = 10;
   parameter XLOC = 400; // location on reset
   parameter YLOC = 300;
   parameter COLOR = 12'hff0; // output color
   parameter UP_LIMIT = 0;
   parameter DOWN_LIMIT = 600;
   parameter LEFT_LIMIT = 0;
   parameter RIGHT_LIMIT = 800;  
   
   logic [9:0] Y_LOC_new = YLOC;    
   logic [9:0] X_LOC_new = XLOC;
   logic [9:0] X_vel = 0;
   logic [9:0] Y_vel = 0;
   logic [2:0] speed_counter = 1;
   logic y_direction_counter = 0;
   
   always_ff @(posedge clk)
   begin
   if(frame)
   begin
   y_direction_counter <= y_direction_counter + 1;
   if(speed_counter == 5)
   speed_counter <= 1;
   else
   speed_counter <= speed_counter + 1;
   end
   end
     
     
    always_ff @(posedge clk)
    begin

        if (reset) 
            begin 
            Y_LOC_new <= YLOC; 
            X_LOC_new <= XLOC;
            X_vel <= 0;
            Y_vel <= 0;
            miss_l <= 0;
            miss_r <= 0;
            end
    
        else if(frame)
            begin
            miss_l <= 0;
            miss_r <= 0;  
            
            if(srv_l)
                begin
                X_vel <= -2;
                if(y_direction_counter == 1)
                    Y_vel <= speed_counter;
                else
                    Y_vel <= -speed_counter;
    
                X_LOC_new <= X_LOC_new + X_vel;  
                Y_LOC_new <= Y_LOC_new + Y_vel;
                end
    
            else if(srv_r)
                begin
                X_vel <= 2;
                if(y_direction_counter == 1)
                    Y_vel <= speed_counter;
                else
                    Y_vel <= -speed_counter;
    
                X_LOC_new <= X_LOC_new + X_vel;  
                Y_LOC_new <= Y_LOC_new + Y_vel;
                end
    
            else
                begin
    
                if(X_LOC_new <= (LEFT_LIMIT+30)) 
                    begin
                    miss_l <= 1'b1;
                    Y_LOC_new <= YLOC; 
                    X_LOC_new <= XLOC;
                    X_vel <= 0;
                    Y_vel <= 0;
                    end
    
                else if(X_LOC_new >= (RIGHT_LIMIT-30)) 
                    begin
                    miss_r <= 1'b1;
                    Y_LOC_new <= YLOC; 
                    X_LOC_new <= XLOC;
                    X_vel <= 0;
                    Y_vel <= 0;
                    end
    
                else if(Y_LOC_new <= UP_LIMIT || Y_LOC_new >= (DOWN_LIMIT-HEIGHT))
                    begin
                    Y_vel <= -Y_vel;
                    X_LOC_new <= X_LOC_new + X_vel;  
                    Y_LOC_new <= Y_LOC_new - Y_vel; 
                    end   
    
                else if(tophit_l || tophit_r)
                    begin
                    X_vel <= -X_vel;
                    X_LOC_new <= X_LOC_new - (X_vel*2);  
                    if(Y_vel>1)
                        Y_vel <= Y_vel-1;
                    else if(Y_vel<1)
                        Y_vel <= Y_vel+1;
                    end
    
                else if(midhit_l || midhit_r)
                    begin
                    X_vel <= -X_vel;
                    X_LOC_new <= X_LOC_new - (X_vel*2);
                    end   
    
                else if(bothit_l || bothit_r)
                    begin
                    X_vel <= -X_vel;
                    X_LOC_new <= X_LOC_new - (X_vel*2);
                    if(Y_vel>0 && Y_vel<5)
                        Y_vel <= Y_vel+1;
                    else if(Y_vel<0 && Y_vel>-5)
                        Y_vel <= Y_vel-1;
                    end  
    
                else
                    begin
                    X_LOC_new <= X_LOC_new + X_vel;  
                    Y_LOC_new <= Y_LOC_new + Y_vel;
                    end    
                end
            end
     end
    
    
    always_comb
    begin
    ball_x = X_LOC_new;
    ball_y = Y_LOC_new;
    if(vga_x >= (X_LOC_new) && vga_x < (X_LOC_new + WIDTH) && vga_y >= (Y_LOC_new) && vga_y < (Y_LOC_new + HEIGHT) && visible)
       rgb = COLOR;
    else 
       rgb = 12'h000;
    
    end
    
endmodule
