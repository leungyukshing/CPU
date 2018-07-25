`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/16 16:08:45
// Design Name: 
// Module Name: Selector_2_to_1
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


module Selector_2_to_1(
    input signal,
    input [31:0] A,
    input [31:0] B,
    output wire [31:0] out
    );
    assign out = (signal ? B : A);
endmodule
