`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/16 22:13:48
// Design Name: 
// Module Name: test
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


module test;

    // Inputs
    reg clk;
    reg rst;
    
    // Outputs
    wire [5:0] Opcode;
    wire [31:0] ReadData1, ReadData2, pc, pcnext, instruction, result, DataOut;
    wire [4:0] rs, rt;
    m_cpu uut (
        .clk(clk),
        .rst(rst),
        .Opcode(Opcode),
        .ADR_out(ReadData1),
        .BDR_out(ReadData2),
        .pc(pc),
        .pcnext(pcnext),
        .instruction(instruction),
        .ALUoutDR_out(result),
        .rs(rs),
        .rt(rt),
        .DBDR_out(DataOut)
        );
    
    initial
                begin
                    // Initialize Inputs
                    clk = 0;
                    rst = 0;
                    // Wait 100 ns for global reset finish
                    //clk = ~clk;
                    #50;
                    rst = 1;
                end
                
                always
                    begin
                    #20;
                    clk = ~clk;
                    end
endmodule
