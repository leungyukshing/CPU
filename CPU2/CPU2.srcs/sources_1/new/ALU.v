`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/14 20:24:36
// Design Name: 
// Module Name: ALU
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


module ALU(
    input ALUSrcA,
    input ALUSrcB,
    input [2:0] ALUOp,
    input [31:0] ReadData1,
    input [31:0] ReadData2,
    input [4:0] sa,
    input [31:0] ExtOut,
    output reg [31:0] result,
    output wire zero,
    output wire sign
    );
    
    // 两个操作数变量
    wire [31:0] A;
    wire [31:0] B;
    assign zero = (result ? 0 : 1);
    assign sign = result[31];
    // 确认第一个操作数
    assign A = (ALUSrcA ? sa : ReadData1);
    // 确认第二个操作数
    assign B = (ALUSrcB ? ExtOut : ReadData2);
    
    always @(A or B or ALUOp) begin
        case(ALUOp)
            3'b000: result <= A + B;
            3'b001: result<=  A - B;
            3'b010: result <= (A < B) ? 1 : 0;
            3'b011: result <= (((A < B) && (A[31] == B[31])) || ((A[31] == 1 && B[31] == 0))) ? 1 : 0;
            3'b100: result <= B << A;
            3'b101: result <= A | B;
            3'b110: result <= A & B;
            3'b111: result <= A ^ B;
            default: result <= 0;
        endcase
    end
endmodule
