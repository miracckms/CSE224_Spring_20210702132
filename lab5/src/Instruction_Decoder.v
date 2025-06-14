`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CSE224
// Engineer: Student
// 
// Create Date: 04/15/2025
// Design Name: Instruction Decoder
// Module Name: Instruction_Decoder
// Project Name: Lab5
// Target Devices: FPGA
// Tool Versions: Vivado 2023.1
// Description: Decodes RISC-V like instructions
// 
// Dependencies: None
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Extracts instruction fields for control and data path
// 
//////////////////////////////////////////////////////////////////////////////////

module Instruction_Decoder #(
    parameter INSTR_WIDTH = 32,
    parameter OPCODE_WIDTH = 7,
    parameter FUNCT3_WIDTH = 3,
    parameter FUNCT7_WIDTH = 7,
    parameter REG_ADDR_WIDTH = 5,
    parameter IMM_WIDTH = 12
)(
    input [INSTR_WIDTH-1:0] instr,
    output wire [OPCODE_WIDTH-1:0] op,
    output wire [FUNCT3_WIDTH-1:0] funct3,
    output wire [FUNCT7_WIDTH-1:0] funct7,
    output wire [REG_ADDR_WIDTH-1:0] A1, A2, A3,
    output wire [IMM_WIDTH-1:0] imm
);

    // Instruction field extraction
    assign funct7 = instr[31:25];  // Function 7 field
    assign imm = instr[31:20];     // Immediate field
    assign A2 = instr[24:20];      // Source register 2
    assign A1 = instr[19:15];      // Source register 1
    assign funct3 = instr[14:12];  // Function 3 field
    assign A3 = instr[11:7];       // Destination register
    assign op = instr[6:0];        // Opcode field

endmodule
