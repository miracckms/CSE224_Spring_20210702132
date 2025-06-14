module immediate_generator(
    input wire [31:0] instruction,
    output reg [31:0] immediate
);

    // Extract opcode
    wire [6:0] opcode = instruction[6:0];

    // Opcode definitions
    localparam I_TYPE = 7'b0010011;  // ADDI, SUBI
    localparam S_TYPE = 7'b0100011;  // SHIFTL
    localparam B_TYPE = 7'b1100011;  // BEQ
    localparam J_TYPE = 7'b1101111;  // J

    always @(*) begin
        case (opcode)
            I_TYPE: begin
                // I-type: sign-extend 12-bit immediate
                immediate = {{20{instruction[31]}}, instruction[31:20]};
            end

            S_TYPE: begin
                // S-type: sign-extend 12-bit immediate
                immediate = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
            end

            B_TYPE: begin
                // B-type: sign-extend 13-bit immediate
                immediate = {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};
            end

            J_TYPE: begin
                // J-type: sign-extend 21-bit immediate
                immediate = {{12{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:21], 1'b0};
            end

            default: immediate = 32'h0;
        endcase
    end

endmodule 