`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/17 12:19:05
// Design Name: 
// Module Name: DataMEM
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


module DataMEM(
    input[31:0] DAddr,
    input[31:0] DataIn,
    input mRD,
    input mWR,
    input clk,
    output reg[31:0] DataOut
    );
    initial begin
        DataOut <= 0;
    end
    reg [8:0] memory[31:0];
    integer i;
    
    initial
        begin
            for(i = 0; i < 32; i=i+1)
                memory[i] <= 0;
        end
    
    always @(*)
        begin
        // read data
            if (mRD)
                begin
                    DataOut[31:24] = memory[DAddr];
                    DataOut[23:16] = memory[DAddr+1];
                    DataOut[15:8] = memory[DAddr+2];
                    DataOut[7:0] = memory[DAddr+3];
                end
        // write data
            else if (mWR && !clk)
                begin
                    memory[DAddr] <= DataIn[31:24];
                    memory[DAddr+1] <= DataIn[23:16];
                    memory[DAddr+2] <= DataIn[15:8];
                    memory[DAddr+3] <= DataIn[7:0];
                    DataOut <= 0;
                end
        end
endmodule
