`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CSE224
// Engineer: Student
// 
// Create Date: 05.04.2025 23:02:01
// Design Name: Arithmetic Logic Unit
// Module Name: ALU
// Project Name: Lab2
// Target Devices: FPGA
// Tool Versions: Vivado 2023.1
// Description: 8-bit ALU with 8 different operations
// 
// Dependencies: None
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Supports basic arithmetic and logical operations
// 
//////////////////////////////////////////////////////////////////////////////////

// Opcode definitions
localparam NOT_A    = 3'b000;  // NOT operation
localparam OR_AB    = 3'b001;  // OR operation
localparam XOR_AB   = 3'b010;  // XOR operation
localparam AND_AB   = 3'b011;  // AND operation
localparam MUL_AB   = 3'b100;  // Multiplication
localparam ADD_AB   = 3'b101;  // Addition
localparam SUB_AB   = 3'b110;  // Subtraction
localparam ZERO     = 3'b111;  // Output zero

module ALU #(
    parameter WIDTH = 8
)(
    input [WIDTH-1:0] A,
    input [WIDTH-1:0] B,
    input [2:0] opcode,
    output reg [WIDTH-1:0] out
);
    
    always @(*) begin
        case(opcode)
            NOT_A:  out = ~A;
            OR_AB:  out = A | B;
            XOR_AB: out = A ^ B;
            AND_AB: out = A & B;
            MUL_AB: out = A * B;
            ADD_AB: out = A + B;
            SUB_AB: out = A - B;
            ZERO:   out = {WIDTH{1'b0}};
            default: out = {WIDTH{1'b0}};
        endcase
    end
endmodule
