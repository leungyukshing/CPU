`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/17 11:59:03
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
    input[31:0] ReadData1,
    input[31:0] ReadData2,
    input[31:0] ExtOut,
    input[4:0] sa,
    input ALUSrcA,
    input ALUSrcB,
    input[2:0] ALUOp,
    output zero,
    output [31:0] result,
    output sign
    );
    
    reg zero;
    reg[31:0] result;
    wire [31:0] A;
    wire [31:0] B;
    // Operand 1
    assign A = (ALUSrcA ? sa : ReadData1);
    // Operand 2
    assign B = (ALUSrcB ? ExtOut : ReadData2);
    
    always@(*)
        begin
            case(ALUOp)
                3'b000:
                    begin
                        result <= A + B;
                    end
                3'b001:
                    begin
                        result <= A - B;
                    end
                3'b010:
                    begin
                        result <= B << A;
                    end
                3'b011:
                    begin
                        result <= A | B;
                    end
                3'b100:
                    begin
                        result <= A & B;
                    end
                3'b101:
                    begin
                        result <= (A < B) ? 1 : 0;
                    end
                3'b110:
                    begin
                        result <= (((A < B) && (A[31] == B[31])) || ((A[31] == 1 && B[31] == 0))) ? 1 : 0;
                    end
                3'b111:
                    begin
                        result <= A ^ B;
                    end
                default:
                    result <= 0;
            endcase
            
            if(!result)
                zero = 1;
            else
                zero = 0;
        end
endmodule
