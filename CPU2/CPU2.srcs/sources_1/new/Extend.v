`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/14 20:15:54
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
    input ExtSel,
    input [15:0] imd,
    output reg [31:0] ExtOut
    );
    
    always @(imd or ExtSel) begin
        if (ExtSel) begin
            ExtOut <= {{16{imd[15]}}, imd[15:0]};
        end
        else begin
            ExtOut <= {{16{0}}, imd[15:0]};
        end
    end
endmodule
