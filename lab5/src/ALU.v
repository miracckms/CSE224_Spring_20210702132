`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CSE224
// Engineer: Student
// 
// Create Date: 04/15/2025
// Design Name: ALU
// Module Name: ALU
// Project Name: Lab5
// Target Devices: FPGA
// Tool Versions: Vivado 2023.1
// Description: Arithmetic Logic Unit for CPU
// 
// Dependencies: None
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Implements basic arithmetic and logical operations
// 
//////////////////////////////////////////////////////////////////////////////////

module ALU #(
    parameter DATA_WIDTH = 32,
    parameter CONTROL_WIDTH = 3
)(
    input [DATA_WIDTH-1:0] srcA,
    input [DATA_WIDTH-1:0] srcB,
    input [CONTROL_WIDTH-1:0] ALUControl,
    output reg [DATA_WIDTH-1:0] ALUResult
);

    // ALU operation codes
    localparam ADD = 3'b010;  // Addition
    localparam SUB = 3'b011;  // Subtraction
    localparam SHL = 3'b100;  // Shift left
    localparam SHR = 3'b101;  // Shift right

    // ALU operations
    always @(*) begin
        casex (ALUControl)
            ADD: ALUResult = srcA + srcB;
            SUB: ALUResult = srcA - srcB;
            SHL: ALUResult = srcA << srcB;
            SHR: ALUResult = srcA >> srcB;
            default: ALUResult = {DATA_WIDTH{1'b0}};
        endcase
    end
endmodule
