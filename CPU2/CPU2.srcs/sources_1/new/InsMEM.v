`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/15 09:12:18
// Design Name: 
// Module Name: InsMEM
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


module InsMEM(
    input clk,
    input InsMemRW,
    input IRWre,
    input [31:0] IAddr,
    output reg [31:0] DataOut
    );
    reg [31:0] temp; // 中间变量 存储地址输出
    // 指令寄存器模块
    reg [7:0] ins[0:127];
    initial begin
        $readmemb("C:/Xilinx/Vivado/CPU2/CPU2.srcs/sources_1/new/ins.txt", ins);
    end
    
    always @(IAddr or InsMemRW) begin 
        // Read Instruction
        if (InsMemRW) begin
            temp[31:24] = ins[IAddr];
            temp[23:16] = ins[IAddr+1];
            temp[15:8] = ins[IAddr+2];
            temp[7:0] = ins[IAddr+3];
        end
    end
    
    // IR
    always @(posedge clk) begin
        if(IRWre)
            DataOut <= temp;
    end
endmodule
