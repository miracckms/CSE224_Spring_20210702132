`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CSE224
// Engineer: Student
// 
// Create Date: 17.04.2025 14:01:47
// Design Name: 7-Segment Display Decoder
// Module Name: DisplayOut
// Project Name: Lab3
// Target Devices: FPGA
// Tool Versions: Vivado 2023.1
// Description: Converts 4-bit input to 7-segment display output
// 
// Dependencies: None
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Active low segments (0 = ON, 1 = OFF)
// 
//////////////////////////////////////////////////////////////////////////////////

module DisplayOut #(
    parameter INPUT_WIDTH = 4,
    parameter SEGMENT_WIDTH = 7
)(
    input [INPUT_WIDTH-1:0] in,
    output reg [0:SEGMENT_WIDTH-1] out
);

    // Segment patterns for digits 0-5 (active low)
    always @(*) begin
        case (in)
            4'd0: out = 7'b1000000;  // 0
            4'd1: out = 7'b1111001;  // 1
            4'd2: out = 7'b0100100;  // 2
            4'd3: out = 7'b0110000;  // 3
            4'd4: out = 7'b0011001;  // 4
            4'd5: out = 7'b0010010;  // 5
            default: out = 7'b1111111;  // All segments off
        endcase
    end
endmodule
