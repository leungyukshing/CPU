`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/16 15:11:07
// Design Name: 
// Module Name: PCAdd
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


module PCAdd(
    input [25:0] addr,
    input [31:0] pc,
    output reg [31:0] nextpc
    );
    always@(addr) begin
        nextpc[31:28] = pc[31:28];
        nextpc[27:2] <= addr[25:0];
        nextpc[1] <= 0;
        nextpc[0] <= 0;
    end
endmodule
