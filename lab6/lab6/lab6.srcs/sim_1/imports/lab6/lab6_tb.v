/* CSED273 lab6 experiments */
/* lab6_tb.v */

`timescale 1ps / 1fs

module lab6_tb();

    integer Passed;
    integer Failed;

    /* Define input, output and instantiate module */
    ////////////////////////
    reg reset_n, clk; // registers for reset input and clock
    reg [3:0] count_expected_1digit; // expected result for 1 digit BCD counter
    wire [3:0] count; // result of 1 digit BCD counter
    decade_counter counter(reset_n, clk, count); // 1 digit BCD counter

    // Expected results for 2 digit BCD counter.
    // count_expected_2digits_0 saves lowest digit, and count_expected_2digits_1 saves highest digit.
    reg [3:0] count_expected_2digits_0, count_expected_2digits_1;
    wire [7:0] count_2digits; // result of 2 digit BCD counter
    decade_counter_2digits counter2d(reset_n, clk, count_2digits); // 2 digit BCD counter
    
    reg [3:0] count_expected_369; // expected result for 369 counter
    wire [3:0] count_369; // result of 369 counter
    counter_369 counter369(reset_n, clk, count_369); // 369 counter

    always begin
        #5 // invert clock every 5 timesteps
        clk = ~clk;
    end

    initial begin
        clk = 0; // clock starts from zero
        reset_n = 0; // reset all circuits
        #15 // wait for circuits to reset
        reset_n = 1;

        #195 // lab6_1_test takes 210 timesteps, so wait 195 timesteps to synchronize.
        reset_n = 0; // reset all circuits
        #15 // wait for circuits to reset
        reset_n = 1;
        
        #1995 // lab6_2_test takes 2010 timesteps, so wait 1995 timesteps to synchronize.
        reset_n = 0; // reset all circuits
        #15 // wait for circuits to reset
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
            count_expected_1digit = 4'b0; // start from zero
            #10 // wait for circuit reset
            // Loop 20 = 10 * 2 times to test highest digit wrap-around.
            for (i = 0; i < 20; i = i + 1) begin
                count_expected_1digit = i % 10; // expected result is i mod 10
                #10 // wait for clock
                if (count === count_expected_1digit) begin
                    // Success.
                    Passed = Passed + 1;
                end
                else begin
                    // Failure.
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
            count_expected_2digits_0 = 4'b0; // start from zero
            count_expected_2digits_1 = 4'b0; // start from zero
            #10 // wait for circuit reset
            // Loop 200 = 100 * 2 times to test highest digit wrap-around.
            for (i = 0; i < 200; i = i + 1) begin
                count_expected_2digits_0 = i % 10; // expected result is i mod 10
                count_expected_2digits_1 = (i / 10) % 10; // expected result is [highest digit of i] mod 10
                #10 // wait for clock
                if (count_2digits[7:4] === count_expected_2digits_1 && count_2digits[3:0] === count_expected_2digits_0) begin
                    // Success.
                    Passed = Passed + 1;
                end
                else begin
                    // Failure.
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
        integer i;
        
        begin
            $display("Testing counter_369...");
            count_expected_369 = 4'b0; // start from zero.
            #10 // wait for circuit reset
            // Loop 8 = 2 + 3 * 2 times to test the cycle.
            for (i = 0; i < 8; i = i + 1) begin
                if (i === 0) begin
                    // If i = 0, counter is in initial state.
                    count_expected_369 = 4'd0;
                end
                else if (i === 1) begin
                    // If i = 1, counter is in 3 state.
                    count_expected_369 = 4'd3;
                end
                else begin
                    // Counter cycles through 6 -> 9 -> 13, so we can implement its behavior using modulo 3 arithmetic.
                    if (i % 3 === 0) begin
                        count_expected_369 = 4'd9;
                    end
                    else if (i % 3 === 1) begin
                        count_expected_369 = 4'd13;
                    end
                    else begin
                        count_expected_369 = 4'd6;
                    end
                end
                #10 // wait for clock
                if (count_expected_369 === count_369) begin
                    // Success.
                    Passed = Passed + 1;
                end
                else begin
                    // Failure.
                    Failed = Failed + 1;
                    $display("lab6_3 error: i=%d, count_expected_369=%d, count_369=%d", i, count_expected_369, count_369);
                end
            end
            $display("Testing done.");
        end
        ////////////////////////
    endtask

endmodule