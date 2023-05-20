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
    
    reg [3:0] count_expected_369;
    wire [3:0] count_369;
    counter_369 counter369(reset_n, clk, count_369);

    always begin
        #5
        clk = ~clk;
    end

    initial begin
        clk = 0;
        reset_n = 0;
        #15
        reset_n = 1;

        #195 // lab6_1_test takes 210 timesteps, so wait 195 timesteps to synchronize.
        reset_n = 0;
        #15
        reset_n = 1;
        
        #1995 // lab6_2_test takes 2010 timesteps, so wait 1995 timesteps to synchronize.
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
        integer i;
        
        begin
            $display("Testing counter_369...");
            count_expected_369 = 4'b0;
            #10
            for (i = 0; i < 8; i = i + 1) begin
                if (i === 0) begin
                    count_expected_369 = 4'd0;
                end
                else if (i === 1) begin
                    count_expected_369 = 4'd3;
                end
                else begin
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
                #10
                if (count_expected_369 === count_369) begin
                    Passed = Passed + 1;
                end
                else begin
                    Failed = Failed + 1;
                    $display("lab6_3 error: i=%d, count_expected_369=%d, count_369=%d", i, count_expected_369, count_369);
                end
            end
            $display("Testing done.");
        end
        ////////////////////////
    endtask

endmodule