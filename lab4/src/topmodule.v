`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CSE224
// Engineer: Student
// 
// Create Date: 04/15/2025
// Design Name: Register File with ALU
// Module Name: topmodule
// Project Name: Lab4
// Target Devices: FPGA
// Tool Versions: Vivado 2023.1
// Description: Top level module combining ALU and Register File
// 
// Dependencies: ALU, RegisterFile
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Implements a simple processor datapath
// 
//////////////////////////////////////////////////////////////////////////////////

module topmodule #(
    parameter DATA_WIDTH = 4,
    parameter ADDR_WIDTH = 5,
    parameter OPCODE_WIDTH = 2
)(
    input [DATA_WIDTH-1:0] inputA, inputB,
    input [OPCODE_WIDTH-1:0] opcode,
    input clk,
    input WE3,
    input [ADDR_WIDTH-1:0] A1, A2, A3,
    input [DATA_WIDTH-1:0] WD3,
    output reg [DATA_WIDTH-1:0] outputC,
    output [DATA_WIDTH-1:0] RD1, RD2
);

    // Internal signals
    wire [DATA_WIDTH-1:0] alu_out;

    // ALU instance
    ALU #(
        .DATA_WIDTH(DATA_WIDTH),
        .OPCODE_WIDTH(OPCODE_WIDTH)
    ) Module1 (
        .inputA(inputA),
        .inputB(inputB),
        .outputC(alu_out),
        .clk(clk),
        .opcode(opcode)
    );

    // Output register
    always @(posedge clk) begin
        outputC <= alu_out;
    end

    // Register File instance
    RegisterFile #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) Module2 (
        .clk(clk),
        .WE3(WE3),
        .A1(A1),
        .A2(A2),
        .RD1(RD1),
        .RD2(RD2),
        .A3(A3),
        .WD3(WD3)
    );

endmodule

module ALU #(
    parameter DATA_WIDTH = 4,
    parameter OPCODE_WIDTH = 2
)(
    input [DATA_WIDTH-1:0] inputA, inputB,
    output reg [DATA_WIDTH-1:0] outputC,
    input clk,
    input [OPCODE_WIDTH-1:0] opcode
);

    // ALU operations
    localparam ADD = 2'b00;  // Addition
    localparam SUB = 2'b01;  // Subtraction
    localparam SHL = 2'b10;  // Shift left
    localparam SHR = 2'b11;  // Shift right

    always @(posedge clk) begin
        case(opcode)
            ADD: outputC <= inputA + inputB;
            SUB: outputC <= inputA - inputB;
            SHL: outputC <= inputA << inputB;
            SHR: outputC <= inputA >> inputB;
            default: outputC <= {DATA_WIDTH{1'b0}};
        endcase
    end

endmodule

module RegisterFile #(
    parameter DATA_WIDTH = 4,
    parameter ADDR_WIDTH = 5
)(
    input clk,
    input WE3,
    input [ADDR_WIDTH-1:0] A1, A2, A3,
    output reg [DATA_WIDTH-1:0] RD1, RD2,
    input [DATA_WIDTH-1:0] WD3
);

    // Register file memory
    reg [DATA_WIDTH-1:0] RegisterFile [(2**ADDR_WIDTH)-1:0];

    // Register file operations
    always @(posedge clk) begin
        if (WE3) begin
            RegisterFile[A3] <= WD3;  // Write operation
        end
        else begin
            RD1 <= RegisterFile[A1];  // Read operation port 1
            RD2 <= RegisterFile[A2];  // Read operation port 2
        end
    end

endmodule
