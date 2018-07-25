`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/17 13:25:29
// Design Name: 
// Module Name: PC
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


module PC(
    input PCWre,
    input clk,
    input Reset,
    input[31:0] pcin,
    output[31:0] ExtOut,
    output[31:0] pc
    );
    reg[31:0] pc;
    
    always@(posedge clk or negedge Reset)
        begin
            if (!Reset)
                pc = 0;
            else
                begin
                    if (PCWre)
                        begin
                            pc = pcin;
                        end
                end
        end
endmodule
