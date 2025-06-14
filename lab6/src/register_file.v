module register_file(
    input wire clk,
    input wire rst,
    input wire reg_write,
    input wire [4:0] rs1,
    input wire [4:0] rs2,
    input wire [4:0] rd,
    input wire [31:0] write_data,
    output reg [31:0] read_data1,
    output reg [31:0] read_data2
);

    // Register file
    reg [31:0] registers [0:31];

    // Write operation
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset all registers to 0
            for (integer i = 0; i < 32; i = i + 1) begin
                registers[i] <= 32'h0;
            end
        end else if (reg_write && rd != 0) begin
            // Write to register if not x0
            registers[rd] <= write_data;
        end
    end

    // Read operation
    always @(*) begin
        // Read from rs1
        if (rs1 == 0)
            read_data1 = 32'h0;  // x0 is always 0
        else
            read_data1 = registers[rs1];

        // Read from rs2
        if (rs2 == 0)
            read_data2 = 32'h0;  // x0 is always 0
        else
            read_data2 = registers[rs2];
    end

endmodule 