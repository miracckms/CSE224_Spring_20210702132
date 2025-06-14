module cpu_tb;
    reg clk;
    reg rst;
    reg control;
    wire [6:0] seg1;
    wire [6:0] seg2;

    // Instantiate the CPU
    cpu_top dut(
        .clk(clk),
        .rst(rst),
        .control(control),
        .seg1(seg1),
        .seg2(seg2)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test stimulus
    initial begin
        // Initialize
        rst = 1;
        control = 0;
        #20;
        rst = 0;
        #20;

        // Run through the example program
        // ADDI reg10, reg0, 10
        control = 1;
        #10;
        control = 0;
        #10;

        // ADDI reg15, reg0, 15
        control = 1;
        #10;
        control = 0;
        #10;

        // ADD reg25, reg10, reg15
        control = 1;
        #10;
        control = 0;
        #10;

        // SUBI reg20, reg25, 5
        control = 1;
        #10;
        control = 0;
        #10;

        // ADDI reg21, reg0, 2
        control = 1;
        #10;
        control = 0;
        #10;

        // J 12
        control = 1;
        #10;
        control = 0;
        #10;

        // Continue with remaining instructions...
        // Add more control pulses for remaining instructions

        // End simulation
        #100;
        $finish;
    end

    // Monitor
    initial begin
        $monitor("Time=%t rst=%b control=%b seg1=%b seg2=%b",
                 $time, rst, control, seg1, seg2);
    end

endmodule 