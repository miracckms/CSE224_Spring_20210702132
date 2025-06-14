`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CSE224
// Engineer: Student
// 
// Create Date: 04/15/2025 12:04:37 PM
// Design Name: Top Level Module
// Module Name: top
// Project Name: Lab3
// Target Devices: FPGA
// Tool Versions: Vivado 2023.1
// Description: Top level module connecting counter and display
// 
// Dependencies: ZeroToFiveCounter, DisplayOut
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Integrates counter with 7-segment display
// 
//////////////////////////////////////////////////////////////////////////////////

module top #(
    parameter COUNT_WIDTH = 4,
    parameter SEGMENT_WIDTH = 7
)(
    input clk,
    input rst,
    output wire [0:SEGMENT_WIDTH-1] out
);
    // Internal signals
    wire [COUNT_WIDTH-1:0] count;
    
    // Counter instance
    ZeroToFiveCounter #(
        .COUNT_WIDTH(COUNT_WIDTH)
    ) uut (
        .clk(clk),
        .rst(rst),
        .count(count)
    );
    
    // Display decoder instance
    DisplayOut #(
        .INPUT_WIDTH(COUNT_WIDTH),
        .SEGMENT_WIDTH(SEGMENT_WIDTH)
    ) display_out (
        .in(count),
        .out(out)
    );
endmodule
        

