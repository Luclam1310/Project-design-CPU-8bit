`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2024 08:38:42 PM
// Design Name: 
// Module Name: WindowPointer
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


module WindowPointer (
    input [2:0] IRout, // Input IRout 3-bit
    input clk,         // Clock signal
    input WPreset,     // Reset signal for Window Pointer
    input WPadd,       // Add signal for Window Pointer
    output reg [2:0] WPout // Output Window Pointer
);

    reg [2:0] window_pointer; // Window Pointer register

    always @(posedge clk) begin
        if (WPreset) begin
            window_pointer <= 3'b000; // Reset Window Pointer to 000
        end else if (WPadd) begin
            window_pointer <= (window_pointer == 3'b111) ? 3'b000 : window_pointer + 1; // Add 1 to Window Pointer, wrap around at 111
        end
    end
    
    always @(*) begin
        assign WPout = window_pointer; // Assign the Window Pointer to the output
    end

endmodule
