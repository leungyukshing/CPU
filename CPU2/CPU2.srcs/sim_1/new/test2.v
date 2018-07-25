`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/22 00:41:18
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
    reg [7:0] r;
    
    display_cpu2 t (
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
    button1 <= 0;
    button2 <= 0;
    CLK <= 0;
    c <= 0;
    r <= 0;
    
    
    forever #4
    begin
    CLK = ~CLK;
    if (c>6) begin
        c <= 0;
        clk = ~clk;
    end
    else begin
        c <= c + 1;
    end
    if (r == 30) begin
        reset <= 1;
    end
    else begin
          r <= r + 1;
    end
    end
    end
endmodule

