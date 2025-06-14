module control_unit(
    input wire [6:0] opcode,
    output reg reg_write,
    output reg alu_src,
    output reg branch,
    output reg jump,
    output reg [2:0] alu_control
);

    // Opcode definitions
    localparam R_TYPE = 7'b0110011;  // ADD, SUB
    localparam I_TYPE = 7'b0010011;  // ADDI, SUBI
    localparam S_TYPE = 7'b0100011;  // SHIFTL
    localparam B_TYPE = 7'b1100011;  // BEQ
    localparam J_TYPE = 7'b1101111;  // J

    // ALU control codes
    localparam ADD  = 3'b000;
    localparam SUB  = 3'b001;
    localparam SLL  = 3'b010;
    localparam SLT  = 3'b011;
    localparam SLTU = 3'b100;
    localparam XOR  = 3'b101;
    localparam SRL  = 3'b110;
    localparam OR   = 3'b111;

    always @(*) begin
        // Default values
        reg_write = 1'b0;
        alu_src = 1'b0;
        branch = 1'b0;
        jump = 1'b0;
        alu_control = ADD;

        case (opcode)
            R_TYPE: begin
                reg_write = 1'b1;
                alu_src = 1'b0;
                branch = 1'b0;
                jump = 1'b0;
                alu_control = ADD;  // Default to ADD, funct3 will modify this
            end

            I_TYPE: begin
                reg_write = 1'b1;
                alu_src = 1'b1;
                branch = 1'b0;
                jump = 1'b0;
                alu_control = ADD;  // Default to ADD, funct3 will modify this
            end

            S_TYPE: begin
                reg_write = 1'b1;
                alu_src = 1'b0;
                branch = 1'b0;
                jump = 1'b0;
                alu_control = SLL;
            end

            B_TYPE: begin
                reg_write = 1'b0;
                alu_src = 1'b0;
                branch = 1'b1;
                jump = 1'b0;
                alu_control = SUB;  // For comparison
            end

            J_TYPE: begin
                reg_write = 1'b0;
                alu_src = 1'b0;
                branch = 1'b0;
                jump = 1'b1;
                alu_control = ADD;  // Not used for jump
            end

            default: begin
                reg_write = 1'b0;
                alu_src = 1'b0;
                branch = 1'b0;
                jump = 1'b0;
                alu_control = ADD;
            end
        endcase
    end

endmodule 