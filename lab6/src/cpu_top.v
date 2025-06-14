module cpu_top(
    input wire clk,
    input wire rst,
    input wire control,
    output wire [6:0] seg1,
    output wire [6:0] seg2
);

    // Internal signals
    wire [31:0] pc;
    wire [31:0] instruction;
    wire [31:0] alu_result;
    wire [31:0] reg_data1;
    wire [31:0] reg_data2;
    wire [31:0] immediate;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [4:0] rd;
    wire [2:0] alu_control;
    wire reg_write;
    wire alu_src;
    wire branch;
    wire jump;
    wire [31:0] pc_next;
    wire [31:0] pc_plus_4;
    wire [31:0] branch_target;
    wire [31:0] jump_target;
    wire pc_src;
    wire [31:0] display_value;
    wire zero;

    // Program Counter
    reg [31:0] pc_reg;
    always @(posedge clk or posedge rst) begin
        if (rst)
            pc_reg <= 32'h0;
        else if (control)
            pc_reg <= pc_next;
    end
    assign pc = pc_reg;

    // Instruction Memory
    instruction_memory imem(
        .pc(pc),
        .instruction(instruction)
    );

    // Control Unit
    control_unit ctrl(
        .opcode(instruction[6:0]),
        .reg_write(reg_write),
        .alu_src(alu_src),
        .branch(branch),
        .jump(jump),
        .alu_control(alu_control)
    );

    // Register File
    assign rs1 = instruction[19:15];
    assign rs2 = instruction[24:20];
    assign rd = instruction[11:7];

    register_file rf(
        .clk(clk),
        .rst(rst),
        .reg_write(reg_write),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .write_data(alu_result),
        .read_data1(reg_data1),
        .read_data2(reg_data2)
    );

    // Immediate Generator
    immediate_generator imm_gen(
        .instruction(instruction),
        .immediate(immediate)
    );

    // ALU
    alu alu_unit(
        .a(reg_data1),
        .b(alu_src ? immediate : reg_data2),
        .alu_control(alu_control),
        .result(alu_result),
        .zero(zero)
    );

    // Branch and Jump Logic
    assign pc_plus_4 = pc + 4;
    assign branch_target = pc + immediate;
    assign jump_target = {pc[31:28], instruction[25:0], 2'b00};
    assign pc_src = (branch & ~zero) | jump;  // Fixed BEQ logic - branch when NOT equal
    assign pc_next = pc_src ? (jump ? jump_target : branch_target) : pc_plus_4;

    // Display Logic - Show last 8 bits of ALU result on 7-segment display
    assign display_value = {{24{1'b0}}, alu_result[7:0]};  // Only show last 8 bits

    // 7-segment display controller
    seg7_controller seg7_ctrl(
        .clk(clk),
        .rst(rst),
        .value(display_value),
        .seg1(seg1),
        .seg2(seg2)
    );

endmodule 