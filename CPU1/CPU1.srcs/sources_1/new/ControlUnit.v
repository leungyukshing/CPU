`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/17 19:10:11
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit(
    input[5:0] Opcode,
    input zero,
    input sign,
    output RegDst,
    output InsMemRW,
    output PCWre,
    output ExtSel,
    output DBDataSrc,
    output mWR,
    output mRD,
    output ALUSrcA,
    output ALUSrcB,
    output [1:0] PCSrc,
    output [2:0] ALUOp,
    output RegWre
    );
    
    // Control Signals
    assign RegDst = (Opcode == 6'b000000 || Opcode == 6'b000010 || Opcode == 6'b010001 || Opcode == 6'b010010 || Opcode == 6'b011000) ? 1 : 0;
    assign PCWre = (Opcode == 6'b111111) ? 0 : 1;
    assign ExtSel = (Opcode == 6'b010000) ? 0 : 1;
    assign DBDataSrc = (Opcode == 6'b100111) ? 1 : 0;
    assign mWR = (Opcode == 6'b100110) ? 1 : 0;
    assign mRD = (Opcode == 6'b100111) ? 1 : 0;
    assign ALUSrcA = (Opcode == 6'b011000) ? 1 : 0;
    assign ALUSrcB = (Opcode == 6'b000001 || Opcode == 6'b010000 || Opcode == 6'b011011 || Opcode == 6'b100110 || Opcode == 6'b100111) ? 1 : 0;
    assign RegWre = (Opcode == 6'b100110 || Opcode == 6'b110000 || Opcode == 6'b110001 || Opcode == 6'b111000 || Opcode == 6'b111111) ? 0 : 1;
    
    // PCSrc - choose next address
    assign PCSrc[0] = ((Opcode == 6'b110000 && zero == 1) || (Opcode == 6'b110001 && zero == 0)) ? 1 : 0;
    assign PCSrc[1] = (Opcode == 6'b111000) ? 1 : 0;
    
    // ALUOp - choose ALU functions
    assign ALUOp[0] = (Opcode == 6'b000010 || Opcode == 6'b010010 || Opcode == 6'b010000 || Opcode == 6'b110000 || Opcode == 6'b110001) ? 1 : 0;
    assign ALUOp[1] = (Opcode == 6'b010010 || Opcode == 6'b010000 || Opcode == 6'b011000 || Opcode == 6'b011011) ? 1 : 0;
    assign ALUOp[2] = (Opcode == 6'b010001 || Opcode == 6'b011011) ? 1 : 0;
    
endmodule
