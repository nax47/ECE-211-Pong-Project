`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2015 01:36:29 PM
// Design Name: 
// Module Name: controlunitFSM
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


module controlunitFSM(
    input logic serve,
    input logic reset,
    input logic clk,
    output logic visible,
    output logic srv_l,
    output logic srv_r,
    input logic miss_l,
    input logic miss_r,
    input logic frame,
    output logic [7:0] an,
    output logic [6:0] segments
    );
    
    typedef enum logic [1:0] {S_L, S_R, PLAY, OVER} state_type;
       state_type state, next;
       
       logic update_left;
       logic update_right;
       logic win;
  
    sevenseg_control control(.win (win), .clk(clk), .an(an), .segments(segments), .reset(reset), .right_en(update_right), .left_en(update_left), .dp(), .frame(frame));
           
       always_ff @(posedge clk)
       if(reset) begin state <= S_R; end
       else if(frame) state <= next;
       
       always_comb
       begin
       srv_l = 1'b0;
       srv_r = 1'b0;
       visible = 1'b0;
       update_left = 1'b0;
       update_right = 1'b0;
       next = S_R;
       case(state)
        PLAY:            

            begin
                visible = 1'b1;
                if(miss_r)
                begin
                update_left = 1'b1;
                if(win)
                next = OVER;
                else
                next = S_L;
                end
                else if(miss_l)
                begin
                update_right = 1'b1;
                if(win)
                next = OVER;
                else
                next = S_R;
                end
                else
                next = PLAY;
            end
        S_R:
            begin
                visible = 1'b1;
                if(serve)
                begin
                srv_r = 1'b1;
                next = PLAY;
                end
                else
                next = S_R;    
            end
        S_L:
                begin
                    visible = 1'b1;
                    if(serve)
                    begin
                    srv_l = 1'b1;
                    next = PLAY;
                    end
                    else
                    next = S_L;    
                end
         OVER:
                begin
                    visible = 1'b0;
                    next = OVER;
                end 
          endcase
        end          
endmodule
