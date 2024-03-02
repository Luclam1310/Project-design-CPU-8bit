`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2024 04:37:42 PM
// Design Name: 
// Module Name: AddressingUnit
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


module AddressingUnit (
    input [15:0] Rside, input [7:0] Iside, output [15:0] Address,
    input clk, ResetPC, PCplusI, PCplus1, RplusI, Rplus0, PCenable);
    
    wire [15:0] PCout;
    ProgramCounter PC (Address, PCenable, clk, PCout);
    AddressLogic AL (PCout, Rside, Iside, Address, ResetPC, PCplusI, PCplus1, RplusI, Rplus0);
    
endmodule
