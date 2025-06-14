`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CSE224
// Engineer: Student
// 
// Create Date: 04/15/2025
// Design Name: Semi CPU
// Module Name: Main
// Project Name: Lab5
// Target Devices: FPGA
// Tool Versions: Vivado 2023.1
// Description: Simple CPU implementation with display output
// 
// Dependencies: Instruction_Memory, Instruction_Decoder, Control_Unit, ALU,
//              Register_File, Clock_Divider, Seven_Segment_Converter
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Implements a basic RISC-V like processor
// 
//////////////////////////////////////////////////////////////////////////////////

module Main #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 8,
    parameter OPCODE_WIDTH = 7,
    parameter FUNCT3_WIDTH = 3,
    parameter FUNCT7_WIDTH = 7,
    parameter REG_ADDR_WIDTH = 5,
    parameter IMM_WIDTH = 12,
    parameter DISPLAY_WIDTH = 8
)(
    input clk,
    input next,
    input rst,
    output [DISPLAY_WIDTH-1:0] an,
    output [DISPLAY_WIDTH-1:0] cx
);
    // Program Counter
    reg [ADDR_WIDTH-1:0] PC;
    
    // Instruction and data signals
    wire [DATA_WIDTH-1:0] RD, instr;
    wire [OPCODE_WIDTH-1:0] op;
    wire [FUNCT3_WIDTH-1:0] funct3;
    wire [FUNCT7_WIDTH-1:0] funct7;
    wire [REG_ADDR_WIDTH-1:0] A1, A2, A3;
    wire [IMM_WIDTH-1:0] imm;
    wire [DATA_WIDTH-1:0] immExt;
    
    // Register file signals
    wire [DATA_WIDTH-1:0] RD1, RD2;
    wire [DATA_WIDTH-1:0] srcB;
    
    // Control signals
    wire [2:0] ALUControl;
    wire ALUSrc, RegWrite;
    
    // ALU result
    wire [DATA_WIDTH-1:0] ALUResult;
    
    // Clock signals
    wire slow_clk;
    
    // Initialize Program Counter
    initial begin
        PC = 0;
    end
    
    // Program Counter logic
    always @(posedge next or negedge rst) begin
        if (!rst)
            PC <= {ADDR_WIDTH{1'b0}};
        else if (next)
            PC <= PC + 1'b1;
    end
    
    // Instruction Memory
    Instruction_Memory inst_mem(
        .PC(PC),
        .RD(RD)
    );
    
    // Instruction register
    assign instr = RD & {DATA_WIDTH{next}};
    
    // Instruction Decoder
    Instruction_Decoder inst_dec(
        .RD(RD),
        .op(op),
        .funct3(funct3),
        .funct7(funct7),
        .A1(A1),
        .A2(A2),
        .A3(A3),
        .imm(imm)
    );
    
    // Immediate extension
    assign immExt = {{20{imm[IMM_WIDTH-1]}}, imm};
    
    // Control Unit
    Control_Unit ctrl_unit(
        .clk(clk),
        .op(op),
        .funct3(funct3),
        .funct7(funct7),
        .ALUControl(ALUControl),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite)
    );
    
    // ALU source selection
    assign srcB = (immExt & {DATA_WIDTH{ALUSrc}}) | (RD2 & {DATA_WIDTH{~ALUSrc}});
    
    // ALU
    ALU alu(
        .RD1(RD1),
        .srcB(srcB),
        .ALUResult(ALUResult),
        .ALUControl(ALUControl)
    );
    
    // Register File
    Register_File reg_file(
        .clk(clk),
        .RegWrite(RegWrite),
        .A1(A1),
        .A2(A2),
        .A3(A3),
        .ALUResult(ALUResult),
        .RD1(RD1),
        .RD2(RD2)
    );
    
    // Clock Divider
    Clock_Divider clk_div(
        .clk(clk),
        .slow_clk(slow_clk)
    );
    
    // Seven Segment Display
    Seven_Segment_Converter seven_seg_conv(
        .clk(slow_clk),
        .data(ALUResult),
        .an(an),
        .cx(cx)
    );
endmodule
