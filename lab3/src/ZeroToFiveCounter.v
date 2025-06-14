`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CSE224
// Engineer: Student
// 
// Create Date: 04/15/2025 12:03:43 PM
// Design Name: 0 to 5 Counter
// Module Name: ZeroToFiveCounter
// Project Name: Lab3
// Target Devices: FPGA
// Tool Versions: Vivado 2023.1
// Description: Synchronous counter that counts from 0 to 5 and resets
// 
// Dependencies: None
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Uses synchronous reset and positive edge clock
// 
//////////////////////////////////////////////////////////////////////////////////

module ZeroToFiveCounter #(
    parameter MAX_COUNT = 4'd5,
    parameter COUNT_WIDTH = 4
)(
    input clk,
    input rst,
    output reg [COUNT_WIDTH-1:0] count
);

    // Counter logic
    always @(posedge clk) begin
        if (count == MAX_COUNT || rst == 1'b1) begin
            count <= {COUNT_WIDTH{1'b0}};  // Reset the counter
        end
        else begin
            count <= count + 1'b1;  // Increment the counter
        end
    end
endmodule
