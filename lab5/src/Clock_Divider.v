`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CSE224
// Engineer: Student
// 
// Create Date: 04/15/2025
// Design Name: Clock Divider
// Module Name: Clock_Divider
// Project Name: Lab5
// Target Devices: FPGA
// Tool Versions: Vivado 2023.1
// Description: Divides input clock frequency for display refresh
// 
// Dependencies: None
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Creates a slower clock for display multiplexing
// 
//////////////////////////////////////////////////////////////////////////////////

module Clock_Divider #(
    parameter COUNTER_WIDTH = 20,
    parameter DIVIDE_FACTOR = 20'd12_500  // Adjust for desired frequency
)(
    input clk,
    output reg slow_clk
);

    // Counter register
    reg [COUNTER_WIDTH-1:0] counter;

    // Initialize registers
    initial begin
        counter = {COUNTER_WIDTH{1'b0}};
        slow_clk = 1'b0;
    end

    // Clock division logic
    always @(posedge clk) begin
        if (counter == DIVIDE_FACTOR) begin
            slow_clk <= ~slow_clk;  // Toggle output clock
            counter <= {COUNTER_WIDTH{1'b0}};  // Reset counter
        end
        else begin
            counter <= counter + 1'b1;  // Increment counter
        end
    end
endmodule
