`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CSE224
// Engineer: Student
// 
// Create Date: 04/15/2025
// Design Name: Control Unit
// Module Name: Control_Unit
// Project Name: Lab5
// Target Devices: FPGA
// Tool Versions: Vivado 2023.1
// Description: Control unit for CPU instruction decoding
// 
// Dependencies: None
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Generates control signals based on instruction fields
// 
//////////////////////////////////////////////////////////////////////////////////

module Control_Unit #(
    parameter OPCODE_WIDTH = 7,
    parameter FUNCT3_WIDTH = 3,
    parameter FUNCT7_WIDTH = 7,
    parameter ALU_CONTROL_WIDTH = 3
)(
    input clk,
    input [OPCODE_WIDTH-1:0] op,
    input [FUNCT3_WIDTH-1:0] funct3,
    input [FUNCT7_WIDTH-1:0] funct7,
    output reg [ALU_CONTROL_WIDTH-1:0] ALUControl,
    output wire ALUSrc,
    output reg RegWrite
);

    // Instruction type detection
    assign ALUSrc = ~op[5];  // Immediate or register operation

    // Initialize control signals
    initial begin
        RegWrite = 1'b0;
    end

    // Control signal generation
    always @(posedge clk) begin
        // ALU control signal generation based on function fields
        case (funct3)
            3'b000: ALUControl = {~op[5], 2'b10};  // ADD/SUB
            3'b010: ALUControl = {~op[5], 2'b11};  // SLT
            3'b001: ALUControl = 3'b100;           // SLL
            3'b101: ALUControl = 3'b101;           // SRL
            default: ALUControl = 3'b000;          // Default
        endcase

        // Toggle register write enable
        RegWrite <= ~RegWrite;
    end
endmodule
