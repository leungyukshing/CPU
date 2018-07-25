`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/21 22:11:31
// Design Name: 
// Module Name: clock_div
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


module clock_div(
    input clk, // 100MHz 系统默认频率
    output reg clk_sys = 0 // 1Hz  初始化为0
    );
    
    reg [25:0] div_counter = 0; // 初始化为0
    
    always @(posedge clk) begin
            if (div_counter == 50000) begin
                clk_sys <= ~clk_sys; //电平反向
                div_counter <= 0;
            end else begin
            div_counter <= div_counter + 1;
            end
        end
endmodule
