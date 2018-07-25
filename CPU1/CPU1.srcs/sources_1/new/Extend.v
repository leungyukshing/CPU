`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/17 13:02:23
// Design Name: 
// Module Name: Extend
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


module Extend(
    input[15:0] imd,
    input ExtSel,
    output [31:0] ExtOut
    );
    
    assign ExtOut[15:0] = imd;    
    assign ExtOut[31:16] = (ExtSel ? (imd[15] ? 16'hffff: 16'h0000) : 16'h0000);
endmodule
