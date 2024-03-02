`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2024 08:27:31 PM
// Design Name: 
// Module Name: StatusRegister
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


module StatusRegister (
    input wire SRCin, SRZin, SRload, clk, Cset, Creset, Zset, Zreset,
    output reg SRCout, SRZout
);

    reg [1:0] status_reg; // Khai báo thanh ghi tr?ng thái 2 bit

    always @(posedge clk)
    begin
        // X? lý reset và set
        if (Creset) begin
            status_reg <= 2'b00; // Reset thanh ghi tr?ng thái v? 00
        end
        else if (Cset) begin
            status_reg <= 2'b11; // Set thanh ghi tr?ng thái thành 11
        end
        else begin
        // X? lý load d? li?u vào thanh ghi tr?ng thái
            if (SRload) begin
                status_reg <= {SRCin, SRZin}; // Load d? li?u t? c?ng vào vào thanh ghi tr?ng thái
            end
        end
    end

// X? lý reset và set c?ng ra
    always @(*) begin
        assign SRCout = (Zreset) ? 1'b0 : status_reg[1];
        assign SRZout = (Zset) ? 1'b0 : status_reg[0];
    end

endmodule
