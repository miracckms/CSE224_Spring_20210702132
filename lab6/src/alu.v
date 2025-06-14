module alu(
    input wire [31:0] a,
    input wire [31:0] b,
    input wire [2:0] alu_control,
    output reg [31:0] result,
    output reg zero
);

    // ALU control codes
    localparam ADD  = 3'b000;
    localparam SUB  = 3'b001;
    localparam SLL  = 3'b010;
    localparam SLT  = 3'b011;
    localparam SLTU = 3'b100;
    localparam XOR  = 3'b101;
    localparam SRL  = 3'b110;
    localparam OR   = 3'b111;

    // ALU operation
    always @(*) begin
        case (alu_control)
            ADD:  result = a + b;
            SUB:  result = a - b;
            SLL:  result = a << b[4:0];  // Shift left by b[4:0]
            SLT:  result = ($signed(a) < $signed(b)) ? 32'h1 : 32'h0;
            SLTU: result = (a < b) ? 32'h1 : 32'h0;
            XOR:  result = a ^ b;
            SRL:  result = a >> b[4:0];  // Shift right by b[4:0]
            OR:   result = a | b;
            default: result = 32'h0;
        endcase

        // Zero flag
        zero = (result == 32'h0);
    end

endmodule 