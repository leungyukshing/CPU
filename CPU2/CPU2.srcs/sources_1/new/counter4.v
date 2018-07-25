`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/21 22:12:11
// Design Name: 
// Module Name: counter4
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


module counter4(
    input clk,
    input reset,
    output reg[3:0] count
    );
    reg[3:0] count;
    initial begin
        count <= 0;
    end
    always @(posedge clk or negedge reset) begin
        if(reset == 0) begin
            count <= 4'b0000; 
        end else begin
            if (count == 4'b0000)
                count <= 4'b1110;
            else if (count == 4'b1110)
                count <= 4'b1101;
            else if (count == 4'b1101)
                count <= 4'b1011;
            else if (count == 4'b1011)
                count <= 4'b0111;
            else if (count == 4'b0111)
                count <= 4'b1110;
                
        end
    end
endmodule

