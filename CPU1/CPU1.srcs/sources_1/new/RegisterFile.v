`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/17 13:08:36
// Design Name: 
// Module Name: RegisterFile
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


module RegisterFile(
    input clk,
    input[4:0] rs,
    input[4:0] rt,
    input[4:0] rd,
    input RegDst,
    input[31:0] result,
    input[31:0] DataOut,
    input DBDataSrc,
    input RegWre,
    output[31:0] ReadData1,
    output[31:0] ReadData2
    );
    
    reg[31:0] registers[31:0];
    integer i;
    
    // Initialize the registers
    initial
        begin
            for(i = 0; i < 32; i=i+1)
                registers[i] <= 0;
        end
        
    wire[4:0] regToWrite;
    wire[31:0] WriteData;
    // choose reg
    assign regToWrite = (RegDst ? rd : rt);
    // choose data
    assign WriteData = (DBDataSrc ? DataOut : result);
    
    // Read
    assign ReadData1 = registers[rs];
    assign ReadData2 = registers[rt];
    
    // Write
    always @(negedge clk)
        begin
            if (RegWre && regToWrite)
                registers[regToWrite] <= WriteData;
        end
endmodule
