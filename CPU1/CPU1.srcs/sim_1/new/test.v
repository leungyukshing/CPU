`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/17 20:42:47
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
    reg reset;
    
    // Outputs
    wire[5:0] Opcode;
    wire[31:0] Data1;
    wire[31:0] Data2;
    wire[31:0] pc;
    wire[31:0] pcnext;
    wire[31:0] result;
    wire[4:0] rs;
    wire[4:0] rt;
    wire[31:0] DataOut;
    // uut
    s_cpu uut (
        .clk(clk),
        .reset(reset),
        .Opcode(Opcode),
        .Data1(Data1),
        .Data2(Data2),
        .pc(pc),
        .pcnext(pcnext),
        .result(result),
        .rs(rs),
        .rt(rt),
        .DataOut(DataOut)
    );
    
    initial
        begin
            // Initialize Inputs
            clk = 0;
            reset = 0;
            // Wait 100 ns for global reset finish
            #50
            reset = 1;
            
        end
        
        always
            begin
            #20;
            clk = ~clk;
            end
endmodule
