/* CSED273 lab6 experiments */
/* lab6_tb.v */

`timescale 1ps / 1fs

module lab6_tb();

    integer Passed;
    integer Failed;

    /* Define input, output and instantiate module */
    ////////////////////////
    reg reset_n, clk;
    reg [3:0] count_expected;
    wire [3:0] count;
    decade_counter counter(reset_n, clk, count);

    always begin
        #5
        clk = ~clk;
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars();

        clk = 0;
        reset_n = 0;
        #15
        reset_n = 1;
    end
    ////////////////////////

    initial begin
        Passed = 0;
        Failed = 0;

        lab6_1_test;
        lab6_2_test;
        lab6_3_test;

        $display("Lab6 Passed = %0d, Failed = %0d", Passed, Failed);
        $finish;
    end

    /* Implement test task for lab6_1 */
    task lab6_1_test;
        ////////////////////////
        integer i;

        begin
            $display("Testing decade_counter...");
            count_expected = 4'b0;
            #10
            for (i = 0; i < 20; i = i + 1) begin
                count_expected = i % 10;
                #10
                if (count === count_expected) begin
                    Passed = Passed + 1;
                end
                else begin
                    Failed = Failed + 1;
                    $display("lab6_1 error: i=%d, count_expected=%d, count=%d", i, count_expected, count);
                end
            end
            $display("Testing done.");
        end

        ////////////////////////
    endtask

    /* Implement test task for lab6_2 */
    task lab6_2_test;
        ////////////////////////
        /* Add your code here */
        ////////////////////////
    endtask

    /* Implement test task for lab6_3 */
    task lab6_3_test;
        ////////////////////////
        /* Add your code here */
        ////////////////////////
    endtask

endmodule