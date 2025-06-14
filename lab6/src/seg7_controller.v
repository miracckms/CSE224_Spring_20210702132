module seg7_controller(
    input wire clk,
    input wire rst,
    input wire [31:0] value,
    output reg [6:0] seg1,
    output reg [6:0] seg2
);

    // Convert 32-bit value to two 4-bit values for display
    wire [3:0] digit1 = value[3:0];
    wire [3:0] digit2 = value[7:4];

    // 7-segment display patterns (active low)
    // Format: gfedcba
    always @(*) begin
        case (digit1)
            4'h0: seg1 = 7'b1000000;
            4'h1: seg1 = 7'b1111001;
            4'h2: seg1 = 7'b0100100;
            4'h3: seg1 = 7'b0110000;
            4'h4: seg1 = 7'b0011001;
            4'h5: seg1 = 7'b0010010;
            4'h6: seg1 = 7'b0000010;
            4'h7: seg1 = 7'b1111000;
            4'h8: seg1 = 7'b0000000;
            4'h9: seg1 = 7'b0010000;
            4'hA: seg1 = 7'b0001000;
            4'hB: seg1 = 7'b0000011;
            4'hC: seg1 = 7'b1000110;
            4'hD: seg1 = 7'b0100001;
            4'hE: seg1 = 7'b0000110;
            4'hF: seg1 = 7'b0001110;
            default: seg1 = 7'b1111111;
        endcase

        case (digit2)
            4'h0: seg2 = 7'b1000000;
            4'h1: seg2 = 7'b1111001;
            4'h2: seg2 = 7'b0100100;
            4'h3: seg2 = 7'b0110000;
            4'h4: seg2 = 7'b0011001;
            4'h5: seg2 = 7'b0010010;
            4'h6: seg2 = 7'b0000010;
            4'h7: seg2 = 7'b1111000;
            4'h8: seg2 = 7'b0000000;
            4'h9: seg2 = 7'b0010000;
            4'hA: seg2 = 7'b0001000;
            4'hB: seg2 = 7'b0000011;
            4'hC: seg2 = 7'b1000110;
            4'hD: seg2 = 7'b0100001;
            4'hE: seg2 = 7'b0000110;
            4'hF: seg2 = 7'b0001110;
            default: seg2 = 7'b1111111;
        endcase
    end

endmodule 