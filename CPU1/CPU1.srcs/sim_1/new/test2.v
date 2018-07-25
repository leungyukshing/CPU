`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/22 22:51:44
// Design Name: 
// Module Name: test2
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

/*
 input clock,
   input reset,
   input button1,
   input button2,
   input btn,
   output [3:0] select,
   output [7:0] dispcode,
*/

module test2;
    // Inputs
    reg clk;
    reg CLK;
    reg reset;
    reg button1;
    reg button2;
    // Outputs
    wire btn;
    wire [3:0] select;
    wire [7:0] dispcode;
    reg [7:0] c;
    
    display_cpu t (
        .clock(CLK),
        .reset(reset),
        .button1(button1),
        .button2(button2),
        .btn(clk),
        .select(select),
        .dispcode(dispcode) 
    );
    
    // Initialize inputs
    initial begin
    clk <= 0;
    reset <= 0;
    button1 <= 1;
    button2 <= 1;
    CLK <= 0;
    c <= 0;
    #1;
    reset <= 1;
    
    
    forever #4
    begin
    CLK = ~CLK;
    if (c>6)
    begin
        c <= 0;
        clk = ~clk;
    end
    else
        c <= c + 1;
    end
    end
endmodule
