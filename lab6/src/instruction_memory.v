module instruction_memory(
    input wire [31:0] pc,
    output reg [31:0] instruction
);

    // Memory array
    reg [31:0] mem [0:31];

    // Initialize memory with the example program
    initial begin
        // ADDI reg10, reg0, 10
        mem[0] = 32'h00A00513;  // addi x10, x0, 10
        
        // ADDI reg15, reg0, 15
        mem[1] = 32'h00F00793;  // addi x15, x0, 15
        
        // ADD reg25, reg10, reg15
        mem[2] = 32'h00F50CB3;  // add x25, x10, x15
        
        // SUBI reg20, reg25, 5
        mem[3] = 32'hFF5C8A13;  // addi x20, x25, -5
        
        // ADDI reg21, reg0, 2
        mem[4] = 32'h00200A93;  // addi x21, x0, 2
        
        // J 12
        mem[5] = 32'h00C0006F;  // jal x0, 12
        
        // SHIFTL reg30, reg7, reg21
        mem[6] = 32'h01539F33;  // sll x30, x7, x21
        
        // NOP
        mem[7] = 32'h00000013;  // addi x0, x0, 0
        
        // NOP
        mem[8] = 32'h00000013;  // addi x0, x0, 0
        
        // NOP
        mem[9] = 32'h00000013;  // addi x0, x0, 0
        
        // NOP
        mem[10] = 32'h00000013;  // addi x0, x0, 0
        
        // NOP
        mem[11] = 32'h00000013;  // addi x0, x0, 0
        
        // ADDI reg4, reg0, 4
        mem[12] = 32'h00400213;  // addi x4, x0, 4
        
        // ADD reg5, reg0, reg0
        mem[13] = 32'h000002B3;  // add x5, x0, x0
        
        // BEQ reg4, reg5, 7
        mem[14] = 32'h00520263;  // beq x4, x5, 7
        
        // ADDI reg6, reg0, 1
        mem[15] = 32'h00100313;  // addi x6, x0, 1
        
        // ADDI reg7, reg0, 1
        mem[16] = 32'h00100393;  // addi x7, x0, 1
        
        // ADD reg8, reg6, reg7
        mem[17] = 32'h00730433;  // add x8, x6, x7
        
        // ADD reg6, reg7, reg0
        mem[18] = 32'h00038333;  // add x6, x7, x0
        
        // ADD reg7, reg8, reg0
        mem[19] = 32'h000403B3;  // add x7, x8, x0
        
        // ADDI reg5, reg5, 1
        mem[20] = 32'h00128293;  // addi x5, x5, 1
        
        // J 14
        mem[21] = 32'hFEDFF06F;  // jal x0, -20
    end

    // Read instruction
    always @(*) begin
        instruction = mem[pc[6:2]];  // Divide by 4 to get word address
    end

endmodule 