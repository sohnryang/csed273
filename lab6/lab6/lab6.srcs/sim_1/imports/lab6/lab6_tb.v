/* CSED273 lab6 experiments */
/* lab6_tb.v */

`timescale 1ps / 1fs

module lab6_tb();

    integer Passed;
    integer Failed;

    /* Define input, output and instantiate module */
    ////////////////////////
    reg reset_n, clk;
    reg [3:0] count_expected_1digit;
    wire [3:0] count;
    decade_counter counter(reset_n, clk, count);

    reg [3:0] count_expected_2digits_0, count_expected_2digits_1;
    wire [7:0] count_2digits;
    decade_counter_2digits counter2d(reset_n, clk, count_2digits);

    always begin
        #5
        clk = ~clk;
    end

    initial begin
        clk = 0;
        reset_n = 0;
        #15
        reset_n = 1;

        #195
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
            count_expected_1digit = 4'b0;
            #10
            for (i = 0; i < 20; i = i + 1) begin
                count_expected_1digit = i % 10;
                #10
                if (count === count_expected_1digit) begin
                    Passed = Passed + 1;
                end
                else begin
                    Failed = Failed + 1;
                    $display("lab6_1 error: i=%d, count_expected_1digit=%d, count=%d", i, count_expected_1digit, count);
                end
            end
            $display("Testing done.");
        end

        ////////////////////////
    endtask

    /* Implement test task for lab6_2 */
    task lab6_2_test;
        ////////////////////////
        integer i;
        
        begin
            $display("Testing decade_counter_2digits...");
            count_expected_2digits_0 = 4'b0;
            count_expected_2digits_1 = 4'b0;
            #10
            for (i = 0; i < 200; i = i + 1) begin
                count_expected_2digits_0 = i % 10;
                count_expected_2digits_1 = (i / 10) % 10;
                #10
                if (count_2digits[7:4] === count_expected_2digits_1 && count_2digits[3:0] === count_expected_2digits_0) begin
                    Passed = Passed + 1;
                end
                else begin
                    Failed = Failed + 1;
                    $display("lab6_2 error: i=%d, count_expected_2digits_0=%d, count_expected_2digits_1=%d, count_2digits=%d",
                        i, count_expected_2digits_0, count_expected_2digits_1, count_2digits);
                end
            end
            $display("Testing done.");
        end
        ////////////////////////
    endtask

    /* Implement test task for lab6_3 */
    task lab6_3_test;
        ////////////////////////
        /* Add your code here */
        ////////////////////////
    endtask

endmodule