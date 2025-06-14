`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CSE224
// Engineer: Student
// 
// Create Date: 04/15/2025
// Design Name: Register File
// Module Name: Register_File
// Project Name: Lab5
// Target Devices: FPGA
// Tool Versions: Vivado 2023.1
// Description: Register file for CPU
// 
// Dependencies: None
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Implements 32 registers with read/write operations
// 
//////////////////////////////////////////////////////////////////////////////////

module Register_File #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 5,
    parameter NUM_REGS = 32
)(
    input clk,
    input WE3,
    input [ADDR_WIDTH-1:0] A1, A2, A3,
    input [DATA_WIDTH-1:0] WD3,
    output wire [DATA_WIDTH-1:0] RD1, RD2
);

    // Register file memory
    reg [DATA_WIDTH-1:0] memory [NUM_REGS-1:0];

    // Read operations (asynchronous)
    assign RD1 = memory[A1];
    assign RD2 = memory[A2];

    // Initialize register 0 to zero
    initial begin
        memory[0] = {DATA_WIDTH{1'b0}};
    end

    // Write operation (synchronous)
    always @(posedge clk) begin
        if (WE3 && (A3 != 0)) begin  // Write if enabled and not register 0
            memory[A3] <= WD3;
        end
    end

endmodule