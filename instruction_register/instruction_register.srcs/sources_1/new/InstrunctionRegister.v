`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2024 05:06:09 PM
// Design Name: 
// Module Name: InstrunctionRegister
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


module InstrunctionRegister (in, IRload, clk, out);

    input [15:0] in;
    input IRload, clk;
    output [15:0] out;
    reg [15:0] out;
    always @(negedge clk) if (IRload == 1) out <= in;

endmodule
