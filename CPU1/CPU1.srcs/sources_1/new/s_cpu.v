`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/17 19:49:50
// Design Name: 
// Module Name: s_cpu
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


module s_cpu(
    input clk,
    input reset,
    output[5:0] Opcode,
    output[31:0] Data1,
    output[31:0] Data2,
    output[31:0] pc,
    output[31:0] pcnext,
    output[31:0] result,
    output[4:0] rs,
    output[4:0] rt,
    output[31:0] DataOut
    );
    wire[2:0] ALUOp;
    wire[31:0] ExtOut;
    wire[25:0] JumpAddr;
    wire[15:0] immediate;
    wire[4:0]  rd, sa;
    wire[1:0] PCSrc;
    wire RegDst, zero, sign, PCWre, ALUSrcA, ALUSrcB, ExtSel, DBDataSrc, mWR, mRD, InsMemRW;
    
    // ALU(ReadData1, ReadData2, ExtOut, sa, ALUSrcA, ALUSrcB, ALUOp, zero, result, sign)
    ALU alu(Data1, Data2, ExtOut, sa, ALUSrcA, ALUSrcB, ALUOp, zero, result, sign);
    // PC(PCWre, clk, Reset, pcin, ExtOut, pc)
    PC Pc(PCWre, clk, reset, pcnext, ExtOut, pc);
    // ControlUnit(Opcode, zero, sign, RegDst, InsMemRW, PCWre, ExtSel, DBDataSrc, mWR, mRD, ALUSrcA, ALUSrcB, PCSrc, ALUOp, RegWre)
    ControlUnit controlunit(Opcode, zero, sign, RegDst, InsMemRW, PCWre, ExtSel, DBDataSrc, mWR, mRD, ALUSrcA, ALUSrcB, PCSrc, ALUOp, RegWre);
    //  DataMEM(DAddr, DataIn, mRD, mWR, clk, DataOut)
    DataMEM dataMem(result, Data2, mRD, mWR, clk, DataOut);
    // InsMEM(IAddr, InsMemRW, op, rs, rt, rd, sa, imd, JumpAddr)
    InsMEM insMem(pc, InsMemRW, Opcode, rs, rt, rd, sa, immediate, JumpAddr);
    // RegisterFile(clk, rs, rt, rd, RegDst, result, DataOut, DBDataSrc, RegWre, ReadData1, ReadData2)
    RegisterFile registerfile(clk, rs, rt, rd, RegDst, result, DataOut, DBDataSrc, RegWre, Data1, Data2);
    // Extend(immediate, ExtSel, ExtOut)
    Extend extend(immediate, ExtSel, ExtOut);
    // Mux(pc, ExtOut, JumpAddress, PCSrc, nextpc)
    Mux mux(clk, pc, ExtOut, JumpAddr, PCSrc, PCWre, pcnext);
endmodule
