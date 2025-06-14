`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CSE224
// Engineer: Student
// 
// Create Date: 23.04.2025 15:51:54
// Design Name: Two's Complement Converter
// Module Name: TwosComplementer
// Project Name: Lab1
// Target Devices: FPGA
// Tool Versions: Vivado 2023.1
// Description: This module converts an 8-bit input to its two's complement representation
// 
// Dependencies: None
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Uses simple bitwise operations for two's complement conversion
// 
//////////////////////////////////////////////////////////////////////////////////

module TwosComplementer #(
    parameter WIDTH = 8
)(
    input [WIDTH-1:0] x,
    output [WIDTH-1:0] z
);
    // Two's complement conversion: invert all bits and add 1
    assign z = (~x) + 1'b1;
endmodule
