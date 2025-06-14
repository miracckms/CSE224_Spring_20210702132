`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CSE224
// Engineer: Student
// 
// Create Date: 04/15/2025
// Design Name: Instruction Memory
// Module Name: Instruction_Memory
// Project Name: Lab5
// Target Devices: FPGA
// Tool Versions: Vivado 2023.1
// Description: Instruction memory for CPU
// 
// Dependencies: instruction_memory.txt
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Stores program instructions in memory
// 
//////////////////////////////////////////////////////////////////////////////////

module Instruction_Memory #(
    parameter ADDR_WIDTH = 8,
    parameter INSTR_WIDTH = 32,
    parameter MEM_DEPTH = 256
)(
    input [ADDR_WIDTH-1:0] A,
    output wire [INSTR_WIDTH-1:0] RD
);

    // Instruction memory array
    reg [INSTR_WIDTH-1:0] instructions [MEM_DEPTH-1:0];

    // Read instruction from memory
    assign RD = instructions[A];

    // Initialize memory from file
    initial begin
        $readmemb("instruction_memory.txt", instructions);
    end

endmodule
