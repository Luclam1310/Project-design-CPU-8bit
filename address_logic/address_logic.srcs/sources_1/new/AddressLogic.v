`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2024 04:24:49 PM
// Design Name: 
// Module Name: AddressLogic
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


module AddressLogic(
    input [15:0] PCside, Rside,
    input [7:0] Iside,
    input ResetPC, PCplusI, PCplus1, RplusI, Rplus0,
    output reg [15:0] ALout
    );
    
    always @ (PCside or Rside or Iside or ResetPC or PCplusI or PCplus1 or RplusI or Rplus0)
    begin
        case ({ResetPC, PCplusI, PCplus1, RplusI, Rplus0})
            5'b10000: ALout = 0;
            5'b01000: ALout = PCside + Iside;
            5'b00100: ALout = PCside + 1;
            5'b00010: ALout = Iside + Rside;
            5'b00001: ALout = Rside;
            default: ALout = PCside;
        endcase
    end
    
endmodule
