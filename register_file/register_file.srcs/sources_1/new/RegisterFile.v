`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2024 05:19:28 PM
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


module RegisterFile ( input [15:0] in, input clk, RFLwrite, RFHwrite, input [1:0] Laddr, Raddr, input [2:0] Base,
                      output [15:0] Lout, Rout );
                      
    reg [15:0] MemoryFile [0:7];
    wire [2:0] Laddress = Base + Laddr;
    wire [2:0] Raddress = Base + Raddr;
    assign Lout = MemoryFile [Laddress];
    assign Rout = MemoryFile [Raddress];
    reg [15:0] TempReg;
    always @(negedge clk)
    begin
        TempReg = MemoryFile [Laddress];
        if (RFLwrite) TempReg [7:0] = in [7:0];
        if (RFHwrite) TempReg [15:8] = in [15:8];
        MemoryFile [Laddress] = TempReg;
    end
    
endmodule
