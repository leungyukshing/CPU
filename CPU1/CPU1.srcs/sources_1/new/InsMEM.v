`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/17 12:30:01
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
    input[31:0] IAddr,
    input InsMemRW,
    output[5:0] op,
    output[4:0] rs,
    output[4:0] rt,
    output[4:0] rd,
    output[4:0] sa,
    output[15:0] imd,
    output[25:0] JumpAddr
    );
    wire[7:0] ins[0:100];
    
    // store all instructions
    
    // addi $1, $0, 8  04010008
    assign ins[0] = 8'h04;
    assign ins[1] = 8'h01;
    assign ins[2] = 8'h00;
    assign ins[3] = 8'h08;
    
    // ori $2. $0, 2  40020002
    assign ins[4] = 8'h40;
    assign ins[5] = 8'h02;
    assign ins[6] = 8'h00;
    assign ins[7] = 8'h02;
    
    // add $3, $2, $1  00411800
    assign ins[8] = 8'h00;
    assign ins[9] = 8'h41;
    assign ins[10] = 8'h18;
    assign ins[11] = 8'h00;
    
    // sub $5, $3, $2  08622800
    assign ins[12] = 8'h08;
    assign ins[13] = 8'h62;
    assign ins[14] = 8'h28;
    assign ins[15] = 8'h00;
    
    // and $4, $5, $2  44a22000
    assign ins[16] = 8'h44;
    assign ins[17] = 8'ha2;
    assign ins[18] = 8'h20;
    assign ins[19] = 8'h00;
    
    // or $8, $4, $2  48824000
    assign ins[20] = 8'h48;
    assign ins[21] = 8'h82;
    assign ins[22] = 8'h40;
    assign ins[23] = 8'h00;
    
    // sll $8, $8, 1  60084040
    assign ins[24] = 8'h60;
    assign ins[25] = 8'h08;
    assign ins[26] = 8'h40;
    assign ins[27] = 8'h40;
    
    // bne $8, $1, -2  c501fffe
    assign ins[28] = 8'hc5;
    assign ins[29] = 8'h01;
    assign ins[30] = 8'hff;
    assign ins[31] = 8'hfe;
    
    // slti $6, $2, 8  6c460008
    assign ins[32] = 8'h6c;
    assign ins[33] = 8'h46;
    assign ins[34] = 8'h00;
    assign ins[35] = 8'h08;
    
    // slti $7, $6, 0  6cc70000
    assign ins[36] = 8'h6c;
    assign ins[37] = 8'hc7;
    assign ins[38] = 8'h00;
    assign ins[39] = 8'h00;
    
    // addi $7, $7, 8  04e70008
    assign ins[40] = 8'h04;
    assign ins[41] = 8'he7;
    assign ins[42] = 8'h00;
    assign ins[43] = 8'h08;
    
    // beq $7, $1, -2  c0e1fffe
    assign ins[44] = 8'hc0;
    assign ins[45] = 8'he1;
    assign ins[46] = 8'hff;
    assign ins[47] = 8'hfe;
    
    // sw $2, 4($1)  98220004
    assign ins[48] = 8'h98;
    assign ins[49] = 8'h22;
    assign ins[50] = 8'h00;
    assign ins[51] = 8'h04;
    
    // lw $9, 4($1)  9c290004
    assign ins[52] = 8'h9c;
    assign ins[53] = 8'h29;
    assign ins[54] = 8'h00;
    assign ins[55] = 8'h04;
    
    // j 0x00000040  e00000010
    assign ins[56] = 8'he0;
    assign ins[57] = 8'h00;
    assign ins[58] = 8'h00;
    assign ins[59] = 8'h10;
    
    // addi $10, $0, 10  040a000a
    assign ins[60] = 8'h04;
    assign ins[61] = 8'h0a;
    assign ins[62] = 8'h00;
    assign ins[63] = 8'h0a;
    
    // halt  fc000000
    assign ins[64] = 8'hfc;
    assign ins[65] = 8'h00;
    assign ins[66] = 8'h00;
    assign ins[67] = 8'h00;
    
    // read instruction
    wire[31:0] temp;
    assign temp[31:24] = ins[IAddr[6:2]*4];
    assign temp[23:16] = ins[IAddr[6:2]*4+1];
    assign temp[15:8] = ins[IAddr[6:2]*4+2];
    assign temp[7:0] = ins[IAddr[6:2]*4+3];
    
    assign op = temp[31:26];
    assign rs = temp[25:21];
    assign rt = temp[20:16];
    assign rd = temp[15:11];
    assign sa = temp[10:6];
    assign imd = temp[15:0];
    assign JumpAddr = temp[25:0];

endmodule
