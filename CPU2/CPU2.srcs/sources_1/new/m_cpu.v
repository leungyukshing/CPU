`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/16 15:20:36
// Design Name: 
// Module Name: m_cpu
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


module m_cpu(
    input clk,
    input rst,
    output [5:0] Opcode,
    output [31:0] ADR_out,
    output [31:0] BDR_out,
    output [31:0] pc,
    output [31:0] pcnext,
    output [31:0] instruction,
    output [31:0] ALUoutDR_out,
    output [4:0] rs,
    output [4:0] rt,
    output [31:0] DBDR_out
    );

    wire [2:0] ALUOp;
    wire [31:0] DBDR_in;
    wire [31:0] ReadData1, ReadData2, result, DataOut;
    //wire [31:0] ADR_out, BDR_out, ALUoutDR_out, DBDR_out;
    wire [31:0] ExtOut;
    wire [31:0] JumpAddr;
    wire [15:0] immediate;
    wire [4:0] rd, sa;
    wire [1:0] PCSrc;
    wire [1:0] RegDst;
    wire zero, sign, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, WrRegDSrc, InsMemRW, mRD, mWR, IRWre, ExtSel;
    wire [31:0] WriteData;
    
    assign Opcode = instruction[31:26];
    assign rs = instruction[25:21];
    assign rt = instruction[20:16];
    // modules
    // PC(clk, rst, PCWre, PCSrc, addr, imd, ReadData1, pc)
    PC Pc(clk, rst, PCWre, PCSrc, JumpAddr, ExtOut, ReadData1, pc, pcnext);
    
    // ALU(ALUSrcA, ALUSrcB, ALUOp, ReadData1, ReadData2, sa, ExtOut, result, zero, sign)
    ALU alu(ALUSrcA, ALUSrcB, ALUOp, ADR_out, BDR_out, instruction[10:6], ExtOut, result, zero, sign);
    DataRegister ALUoutDR(clk, result, ALUoutDR_out);
    
    // DataMEM(mRD, mWR, DAddr, DataIn, DataOut)
    DataMEM dataMem(mRD, mWR, ALUoutDR_out, BDR_out, DataOut);
    Selector_2_to_1 selector2(DBDataSrc, result, DataOut, DBDR_in);
    DataRegister DBDR(clk, DBDR_in, DBDR_out);
    
    // RegisterFile
    Selector_2_to_1 selector3(WrRegDSrc, (pc+4), DBDR_out, WriteData);
    RegisterFile registerfile(clk, RegWre, RegDst, instruction[25:21], instruction[20:16], instruction[15:11], WriteData, ReadData1, ReadData2);
    DataRegister ADR(clk, ReadData1, ADR_out);
    DataRegister BDR(clk, ReadData2, BDR_out);
    
    // Extend(ExtSel, imd, ExtOut)
    Extend extend(ExtSel, instruction[15:0], ExtOut);
    
    // PCAdd(addr, pc, nextpc)
    PCAdd pcAdd(instruction[25:0], pc, JumpAddr);
    
    // InsMEM(clk, InsMemRW, IRWre, IAddr, DataOut)
    InsMEM insMem(clk, InsMemRW, IRWre, pc, instruction);
    
    // ControlUnit(clk, rst, Opcode, zero, sign, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, WrRegDSrc, InsMemRW, mRD, mWR, IRWre, ExtSel, PCSrc, RegDst, ALUOp)
    ControlUnit controlunit(clk, rst, instruction[31:26], zero, sign, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, WrRegDSrc, InsMemRW, mRD, mWR, IRWre, ExtSel, PCSrc, RegDst, ALUOp);
    
    
endmodule
