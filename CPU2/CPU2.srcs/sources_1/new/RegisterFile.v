`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/14 19:43:30
// Design Name: 
// Module Name: RegisterFile
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


module RegisterFile(
    input clk,
    input RegWre,
    input [1:0] RegDst,
    input [4:0] rs,
    input [4:0] rt,
    input [4:0] rd,
    input [31:0] WriteData,
    output [31:0] ReadData1,
    output [31:0] ReadData2
    );
    // ¼Ä´æÆ÷×é
    reg [31:0] registers[31:0];
    integer i;
    reg [4:0] WriteReg; // ÐèÒªÐ´Èë¼Ä´æÆ÷µÄµØÖ·
    
    // Initialize the registers
    initial begin
        for(i = 0; i < 32; i=i+1)
            registers[i] <= 0;
    end
    
    // Ð´¼Ä´æÆ÷Ñ¡Ôñ
    always @(RegDst or rt or rd) begin
        case(RegDst)
        2'b00: WriteReg = 5'b11111;
        2'b01: WriteReg = rt;
        2'b10: WriteReg = rd;
        default: WriteReg = 0;
        endcase
    end
    
    // Read
    assign ReadData1 = registers[rs];
    assign ReadData2 = registers[rt];
    
    // Write
    always @(negedge clk) begin
    // assign WriteData = (WrRegDSrc ? MemData : PC4);
        if ((WriteReg != 0) && (RegWre == 1))
            registers[WriteReg] <= WriteData;
    end
    
endmodule
