`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2024 04:55:43 PM
// Design Name: 
// Module Name: ArithmeticUnit
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


`define B15to0H 10'b1000000000
`define AandBH 10'b0100000000
`define AorBH 10'b0010000000
`define notBH 10'b0001000000
`define shlBH 10'b0000100000
`define shrBH 10'b0000010000
`define AaddBH 10'b0000001000
`define AsubBH 10'b0000000100
`define AmulBH 10'b0000000010
`define AcmpBH 10'b0000000001
module ArithmeticUnit ( A, B, B15to0, AandB, AorB, notB, shlB, shrB, AaddB, AsubB, AmulB, AcmpB, aluout, cin, zout, cout);
    input [15:0] A, B;
    input B15to0, AandB, AorB, notB, shlB, shrB, AaddB, AsubB, AmulB, AcmpB;
    input cin;
    output [15:0] aluout;
    output zout, cout;
    reg [15:0] aluout;
    reg zout, cout;
    always @( A or B or B15to0 or AandB or AorB or notB or shlB or shrB or AaddB or AsubB or AmulB or AcmpB or cin)
    begin
        zout = 0; cout = 0; aluout = 0;
        case ({B15to0, AandB, AorB, notB, shlB, shrB, AaddB, AsubB, AmulB, AcmpB})
            `B15to0H:aluout = B;
            `AandBH: aluout = A & B;
            `AorBH: aluout = A | B;
            `notBH: aluout = ~B;
            `shlBH: aluout = {B[15:0], B[0]};
            `shrBH: aluout = {B[15], B[15:1]};
            `AaddBH: {cout, aluout} = A + B + cin;
            `AsubBH: {cout, aluout} = A - B - cin;
            `AmulBH: aluout = A[7:0] * B[7:0];
            `AcmpBH: begin
            aluout = A;
            if (A> B) cout = 1; else cout = 0;
            if (A==B) zout = 1; else zout = 0;
            end
            default: aluout = 0;
        endcase
        if (aluout == 0) zout = 1'b1;
        end
endmodule

