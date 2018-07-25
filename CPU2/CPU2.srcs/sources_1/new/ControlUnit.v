`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/15 09:32:43
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
    input clk,
    input rst,
    input [5:0] Opcode,
    input zero,
    input sign,
    output reg PCWre,
    output reg ALUSrcA,
    output reg ALUSrcB,
    output reg DBDataSrc,
    output reg RegWre,
    output reg WrRegDSrc,
    output reg InsMemRW,
    output reg mRD,
    output reg mWR,
    output reg IRWre,
    output reg ExtSel,
    output reg [1:0] PCSrc,
    output reg [1:0] RegDst,
    output reg [2:0] ALUOp
    );
    
    // 存储前一个状态和后一个状态
    reg[2:0] presentState;
    reg[2:0] nextState;
    reg [5:0] test;
    parameter [2:0] sIF = 3'b000,
                          sID = 3'b001,
                          sEXE = 3'b010,
                          sWB = 3'b011,
                          sMEM = 3'b100;
    initial begin
        nextState <= sID;
        test <= 2'b000000;
        ALUOp <= 2'b111;
    end                
    
    // 触发器 跳到下一个状态
    always @(posedge clk) begin
        if (!rst)
            presentState <= sIF;
        else begin
            presentState <= nextState;
        end
    end
    
    parameter [5:0] add = 6'b000000,
                      sub = 6'b000001,
                      addi = 6'b000010,
                      Or = 6'b010000,
                      And = 6'b010001,
                      ori = 6'b010010,
                      sll = 6'b011000,
                      slt = 6'b100110,
                      sltiu = 6'b100111,
                      sw = 6'b110000,
                      lw = 6'b110001,
                      beq = 6'b110100,
                      bltz = 6'b110110,
                      j = 6'b111000,
                      jr = 6'b111001,
                      jal = 6'b111010,
                      halt = 6'b111111;
                      
    // 根据opcode和当前状态 计算出下一个状态
    always @(presentState or Opcode) begin
        case (presentState)
            sIF: nextState <= sID;
            sID: begin
                case (Opcode)
                    j,jr,halt: begin
                        nextState <= sIF;
                    end
                    jal: nextState <= sWB;
                    default: nextState <= sEXE;
                endcase
            end
            sEXE: begin
                case(Opcode)
                    beq,bltz: begin
                        nextState <= sIF;
                    end
                    sw,lw: begin
                        nextState <= sMEM;
                    end
                    default: nextState <= sWB;
                endcase
            end
            sMEM: begin
                case (Opcode)
                    sw: nextState <= sIF;
                    lw: nextState <= sWB;
                endcase
            end
            sWB: begin
                nextState <= sIF;
            end
        endcase
    end
    
    // 根据opcode和当前状态 确认当前控制信号
    always @(presentState or zero or Opcode or sign) begin
    // PCWre(时钟触发)
        if ((presentState == 3'b011) || (Opcode == sw && presentState == 3'b100) || ((Opcode == beq || Opcode == bltz) && presentState == 3'b010) || (Opcode == jr && presentState == 3'b001) || (Opcode == j && presentState == 3'b001))
            PCWre = 1;
        else
            PCWre = 0;
    // ALUSrcA
        if (presentState == 3'b010 && Opcode == sll)
            ALUSrcA = 1;
        else
            ALUSrcA = 0;
    // ALUSrcB
        if (presentState == 3'b010 && (Opcode == addi || Opcode == ori || Opcode == sltiu || Opcode == lw || Opcode == sw))
            ALUSrcB = 1;
        else
            ALUSrcB = 0;
    // DBDataSrc
        if (presentState == 3'b100 && Opcode == lw)
            DBDataSrc = 1;
        else
            DBDataSrc = 0;
    // RegWre
        if (presentState == 3'b011 || (presentState == 3'b011 && Opcode == jal))
            RegWre = 1;
        else
            RegWre = 0;
    // WrRegDSrc
        if (presentState == 3'b011 && Opcode != jal)
            WrRegDSrc = 1;
        else
            WrRegDSrc = 0;
    // InsMemRW
        if (presentState == 3'b000)
            InsMemRW = 1;
        else
            InsMemRW = 0;
    // mRD
        if (presentState == 3'b100 && Opcode == lw)
            mRD = 1;
        else
            mRD = 0;
    // mWR
        if (presentState == 3'b100 && Opcode == sw)
            mWR = 1;
        else
            mWR = 0;
    // IRWre
        if (presentState == 3'b000)
            IRWre = 1;
        else
            IRWre = 0;
    // ExtSel
        if (presentState == 3'b010 && (Opcode == addi || Opcode == lw || Opcode == sw || Opcode == beq || Opcode == bltz))
            ExtSel = 1;
        else
            ExtSel = 0;
    // PCSrc[1:0]
        if (Opcode == j || Opcode == jal)
            PCSrc = 2'b11;
        else if (Opcode == jr)
            PCSrc = 2'b10;
        else if ((zero == 1 && Opcode == beq) || ((zero == 0 || sign == 1) && Opcode == bltz))
            PCSrc = 2'b01;
        else
            PCSrc = 2'b00;
    // RegDst[1:0]
        if (Opcode == jal)
            RegDst = 2'b00;
        else if (presentState == 3'b011 && (Opcode == addi || Opcode == ori || Opcode == sltiu || Opcode == lw))
            RegDst = 2'b01;
        else if (presentState == 3'b011 && (Opcode == add || Opcode == sub || Opcode == Or || Opcode == And || Opcode == slt || Opcode == sll))
            RegDst = 2'b10;
        else
            RegDst = 2'b11;
    // ALUOp[2:0]
    /*
        if (Opcode == add || Opcode == addi) begin
            ALUOp = 2'b000;
        end
        else if (Opcode == Or || Opcode == ori) begin
            ALUOp = 2'b101;
        end
        else
            ALUOp = 2'b111;
        */
        case(Opcode)
            add,addi,lw,sw:begin
                ALUOp = 3'b000;
            end
            sub,beq,bltz: begin
                test = 6'b010101;
                ALUOp = 3'b001;
            end
            sltiu: ALUOp = 3'b010;
            slt: ALUOp = 3'b011;
            sll: ALUOp = 3'b100;
            Or,ori:begin
                test <= 6'b111111;
                ALUOp <= 3'b101;
            end
            And: ALUOp = 3'b110;
            default: ALUOp = 3'b000;
        endcase
        
   end
endmodule
