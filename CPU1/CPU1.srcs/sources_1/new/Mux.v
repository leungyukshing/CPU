`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/18 18:58:10
// Design Name: 
// Module Name: Mux
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


module Mux(
    input clk,
    input[31:0] pc,
    input[31:0] ExtOut,
    input[25:0] JumpAddr,
    input[1:0] PCSrc,
    input PCWre,
    output reg[31:0] nextpc
    );
    
    always@(*)
            begin
                if(!PCWre) begin
                    nextpc = pc;
                    end
                else begin
                case(PCSrc)
                    2'b00:
                        begin
                            nextpc = pc + 4;
                        end
                                    2'b01:
                                        begin
                                            nextpc = pc + 4 + ExtOut * 4;
                                        end
                                    2'b10:
                                        begin
                                            nextpc = pc + 4;
                                            
                                            nextpc[27:2] = JumpAddr[25:0];
                                            nextpc[1] = 0;
                                            nextpc[0] = 0;
                                        end
                                    2'b11:
                                        begin
                                        end
                                endcase
                                end
            end
endmodule
