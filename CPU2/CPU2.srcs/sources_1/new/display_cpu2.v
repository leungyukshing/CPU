`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/21 22:13:25
// Design Name: 
// Module Name: display_cpu2
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


module display_cpu2(
    input clock,
    input reset,
    input button1,
    input button2,
    input btn,
    output [3:0] select,
    output [7:0] dispcode,
    output testsignal
    );
    
    wire [3:0] pos1;
    wire [3:0] pos2;
    wire [3:0] pos3;
    wire [3:0] pos4;
    wire clk_sys;
    wire [2:0] count;
    wire [31:0] pc;
    wire [31:0] pcnext;
    wire [5:0] Opcode;
    wire [31:0] instruction;
    wire [31:0] result;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [31:0] Data1;
    wire [31:0] Data2;
    wire [31:0] DataOut;
    reg [3:0] num;
    //wire clr;
    wire clk;
    wire testsignal;
    assign testsignal = btn;
    //assign clr = ~reset;
    // counter
     //counter4 U0(clk_sys, reset,select);
    
    // test counter
    counter4 U0(clock, reset, select);
    
    // clock
    //clock_div U1 (clock,clk_sys);

    // fangdou
    key_fangdou f(clock, btn, clk);
    
    // display
    display dis (num, dispcode);
    
    assign pos1 = (button1 ? (button2 ? result[7:4] : rt[4]) : (button2 ? rs[4] : pc[7:4] ));
    assign pos2 = (button1 ? (button2 ? result[3:0] : rt[3:0]): (button2 ? rs[3:0] : pc[3:0] ));
    assign pos3 = (button1 ? (button2 ? DataOut[7:4] : Data2[7:4]) : (button2 ? Data1[7:4] : pcnext[7:4]));
    assign pos4 = (button1 ? (button2 ? DataOut[3:0] : Data2[3:0]): (button2 ? Data1[3:0] : pcnext[3:0]));
    
    // s_cpu
    m_cpu uut (clk, reset, Opcode, Data1, Data2, pc, pcnext, instruction, result, rs, rt, DataOut);
    always @(select)
        begin
            case(select)
                4'b1110:
                    begin
                        num = pos4;
                    end
                4'b1101:
                    begin
                        num = pos3;
                    end
                4'b1011:
                    begin
                        num = pos2;
                    end
                4'b0111:
                    begin
                        num = pos1;
                    end
            endcase
        end

endmodule

