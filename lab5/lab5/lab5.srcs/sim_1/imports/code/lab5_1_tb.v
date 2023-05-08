/* CSED273 lab5 experiment 1 */
/* lab5_1_tb.v */

`timescale 1ps / 1fs

module lab5_1_tb();
    reg [3:0] x;
    reg [3:0] y;
    reg [3:0] select;

    wire [3:0] out;
    wire c_out;

    integer correct;
    integer wrong;

    lab5_1 ALU(
        .x(x),
        .y(y),
        .select(select),
        .out(out),
        .c_out(c_out)
    );

    initial begin
        correct = 0;
        wrong = 0;
        
        arithmetic_test;    // 8 * 16 * 16 tests in total
        logic_test;         // 4 * 16 * 16 tests in total

        $display("lab5_1: Passed (%0d / %0d) tests.", correct, correct + wrong);
        $finish;
    end


    //////////////////////
    /* Arithmetic Tests */
    //////////////////////
    task arithmetic_test;
        begin
            $display("===================");
            $display("  Arithmetic Test  ");
            $display("===================");

            arithmetic_transfer_test;                   // select=0000
            arithmetic_increment_test;                  // select=0001
            arithmetic_add_test;                        // select=0010
            arithmetic_add_increment_test;              // select=0011
            arithmetic_1s_complement_subtract_test;     // select=0100
            arithmetic_2s_complement_subtract_test;     // select=0101
            arithmetic_decrement_test;                  // select=0110
            arithmetic_decrement_transfer_test;         // select=0111
        end
    endtask

    task arithmetic_transfer_test;
        integer i, j;
        reg [3:0] out_expected;
        reg c_out_expected;
        begin
            $display("arithmetic_transfer_test");
            select = 4'h0;
            for (i=0; i < 16; i = i + 1) begin
                for (j=0; j < 16; j = j + 1) begin
                    x = i;
                    y = j;
                    out_expected = i;
                    c_out_expected = 1'b0;

                    #1;
                    if (out === out_expected && c_out === c_out_expected) begin
                        correct = correct + 1;
                    end
                    else begin
                        $display("Error) x: %0b, y: %0b, out: %0b (Ans: %0b), c_out: %0b (Ans: %0b)", 
                                        x, y, out, out_expected, c_out, c_out_expected);
                        wrong = wrong + 1;
                    end
                end
            end
        end
    endtask

    
    task arithmetic_increment_test;
        integer i, j;
        reg [3:0] out_expected;
        reg c_out_expected;
        begin
            $display("arithmetic_increment_test");
            select = 4'h1;
            for (i=0; i < 16; i = i + 1) begin
                for (j=0; j < 16; j = j + 1) begin

                    /* Set module inputs and expected outputs*/

                    ////////////////////////
                    x = i;
                    y = j;
                    {c_out_expected, out_expected} = x + 4'b0001;
                    ////////////////////////

                    #1;
                    if (out === out_expected && c_out === c_out_expected) begin
                        correct = correct + 1;
                    end
                    else begin
                        $display("Error) x: %0b, y: %0b, out: %0b (Ans: %0b), c_out: %0b (Ans: %0b)", 
                                        x, y, out, out_expected, c_out, c_out_expected);
                        wrong = wrong + 1;
                    end
                end
            end
        end
    endtask

    task arithmetic_add_test;
        integer i, j;
        reg [3:0] out_expected;
        reg c_out_expected;
        begin
            $display("arithmetic_add_test");
            select = 4'h2;
            for (i=0; i < 16; i = i + 1) begin
                for (j=0; j < 16; j = j + 1) begin

                    /* Set module inputs and expected outputs*/
                    
                    ////////////////////////
                    x = i;
                    y = j;
                    {c_out_expected, out_expected} = x + y;
                    ////////////////////////

                    #1;
                    if (out === out_expected && c_out === c_out_expected) begin
                        correct = correct + 1;
                    end
                    else begin
                        $display("Error) x: %0b, y: %0b, out: %0b (Ans: %0b), c_out: %0b (Ans: %0b)", 
                                        x, y, out, out_expected, c_out, c_out_expected);
                        wrong = wrong + 1;
                    end
                end
            end
        end
    endtask

    task arithmetic_add_increment_test;
        integer i, j;
        reg [3:0] out_expected;
        reg c_out_expected;
        begin
            $display("arithmetic_add_increment_test");
            select = 4'h3;
            for (i=0; i < 16; i = i + 1) begin
                for (j=0; j < 16; j = j + 1) begin

                    /* Set module inputs and expected outputs*/
                    
                    ////////////////////////
                    x = i;
                    y = j;
                    {c_out_expected, out_expected}= x + y + 4'b0001;
                    ////////////////////////

                    #1;
                    if (out === out_expected && c_out === c_out_expected) begin
                        correct = correct + 1;
                    end
                    else begin
                        $display("Error) x: %0b, y: %0b, out: %0b (Ans: %0b), c_out: %0b (Ans: %0b)", 
                                        x, y, out, out_expected, c_out, c_out_expected);
                        wrong = wrong + 1;
                    end
                end
            end
        end
    endtask

    task arithmetic_1s_complement_subtract_test;
        integer i, j;
        reg [3:0] out_expected;
        reg c_out_expected;
        begin
            $display("arithmetic_1s_complement_subtract_test");
            select = 4'h4;
            for (i=0; i < 16; i = i + 1) begin
                for (j=0; j < 16; j = j + 1) begin

                    /* Set module inputs and expected outputs*/
                    
                    ////////////////////////
                    x = i;
                    y = j;
                    {c_out_expected, out_expected} = x + 5'b1111 - y;
                    ////////////////////////

                    #1;
                    if (out === out_expected && c_out === c_out_expected) begin
                        correct = correct + 1;
                    end
                    else begin
                        $display("Error) x: %0b, y: %0b, out: %0b (Ans: %0b), c_out: %0b (Ans: %0b)", 
                                        x, y, out, out_expected, c_out, c_out_expected);
                        wrong = wrong + 1;
                    end
                end
            end
        end
    endtask

    task arithmetic_2s_complement_subtract_test;
        integer i, j;
        reg [3:0] out_expected;
        reg c_out_expected;
        begin
            $display("arithmetic_2s_complement_subtract_test");
            select = 4'h5;
            for (i=0; i < 16; i = i + 1) begin
                for (j=0; j < 16; j = j + 1) begin

                    /* Set module inputs and expected outputs*/
                    
                    ////////////////////////
                    x = i;
                    y = j;
                    {c_out_expected, out_expected} = x + 5'b10000 - y;
                    ////////////////////////

                    #1;
                    if (out === out_expected && c_out === c_out_expected) begin
                        correct = correct + 1;
                    end
                    else begin
                        $display("Error) x: %0b, y: %0b, out: %0b (Ans: %0b), c_out: %0b (Ans: %0b)", 
                                        x, y, out, out_expected, c_out, c_out_expected);
                        wrong = wrong + 1;
                    end
                end
            end
        end
    endtask

    task arithmetic_decrement_test;
        integer i, j;
        reg [3:0] out_expected;
        reg c_out_expected;
        begin
            $display("arithmetic_decrement_test");
            select = 4'h6;
            for (i=0; i < 16; i = i + 1) begin
                for (j=0; j < 16; j = j + 1) begin

                    /* Set module inputs and expected outputs*/
                    
                    ////////////////////////
                    x = i;
                    y = j;
                    {c_out_expected, out_expected}= x + 5'b1111;
                    ////////////////////////

                    #1;
                    if (out === out_expected && c_out === c_out_expected) begin
                        correct = correct + 1;
                    end
                    else begin
                        $display("Error) x: %0b, y: %0b, out: %0b (Ans: %0b), c_out: %0b (Ans: %0b)", 
                                        x, y, out, out_expected, c_out, c_out_expected);
                        wrong = wrong + 1;
                    end
                end
            end
        end
    endtask

    task arithmetic_decrement_transfer_test;
        integer i, j;
        reg [3:0] out_expected;
        reg c_out_expected;
        begin
            $display("arithmetic_decrement_transfer_test");
            select = 4'h7;
            for (i=0; i < 16; i = i + 1) begin
                for (j=0; j < 16; j = j + 1) begin

                    /* Set module inputs and expected outputs*/
                    
                    ////////////////////////
                    x = i;
                    y = j;
                    {c_out_expected, out_expected}= x + 5'b10000;
                    ////////////////////////

                    #1;
                    if (out === out_expected && c_out === c_out_expected) begin
                        correct = correct + 1;
                    end
                    else begin
                        $display("Error) x: %0b, y: %0b, out: %0b (Ans: %0b), c_out: %0b (Ans: %0b)", 
                                        x, y, out, out_expected, c_out, c_out_expected);
                        wrong = wrong + 1;
                    end
                end
            end
        end
    endtask


    /////////////////
    /* Logic Tests */
    /////////////////
    task logic_test;
        begin
            $display("==============");
            $display("  Logic Test  ");
            $display("==============");

            logic_and_test;     //select=1000
            logic_or_test;      //select=1001
            logic_xor_test;     //select=1010
            logic_not_test;     //select=1011
        end
    endtask

    task logic_and_test;
        integer i, j;
        reg [3:0] out_expected;
        begin
            $display("logic_and_test");
            select = 4'h8;
            for (i=0; i < 16; i = i + 1) begin
                for (j=0; j < 16; j = j + 1) begin

                    /* Set module inputs and expected outputs*/
                    
                    ////////////////////////
                    x = i;
                    y = j;
                    out_expected = x & y;
                    ////////////////////////

                    #1;
                    if (out === out_expected) begin
                        correct = correct + 1;
                    end
                    else begin
                        $display("Error) x: %0b, y: %0b, out: %0b (Ans: %0b)", x, y, out, out_expected);
                        wrong = wrong + 1;
                    end
                end
            end
        end
    endtask

    task logic_or_test;
        integer i, j;
        reg [3:0] out_expected;
        begin
            $display("logic_or_test");
            select = 4'h9;
            for (i=0; i < 16; i = i + 1) begin
                for (j=0; j < 16; j = j + 1) begin

                    /* Set module inputs and expected outputs*/
                    
                    ////////////////////////
                    x = i;
                    y = j;
                    out_expected = x | y;
                    ////////////////////////

                    #1;
                    if (out === out_expected) begin
                        correct = correct + 1;
                    end
                    else begin
                        $display("Error) x: %0b, y: %0b, out: %0b (Ans: %0b)", x, y, out, out_expected);
                        wrong = wrong + 1;
                    end
                end
            end
        end
    endtask

    task logic_xor_test;
        integer i, j;
        reg [3:0] out_expected;
        begin
            $display("logic_xor_test");
            select = 4'ha;
            for (i=0; i < 16; i = i + 1) begin
                for (j=0; j < 16; j = j + 1) begin

                    /* Set module inputs and expected outputs*/
                    
                    ////////////////////////
                    x = i;
                    y = j;
                    out_expected = x ^ y;
                    ////////////////////////

                    #1;
                    if (out === out_expected) begin
                        correct = correct + 1;
                    end
                    else begin
                        $display("Error) x: %0b, y: %0b, out: %0b (Ans: %0b)", x, y, out, out_expected);
                        wrong = wrong + 1;
                    end
                end
            end
        end
    endtask

    task logic_not_test;
        integer i, j;
        reg [3:0] out_expected;
        begin
            $display("logic_not_test");
            select = 4'hb;
            for (i=0; i < 16; i = i + 1) begin
                for (j=0; j < 16; j = j + 1) begin

                    /* Set module inputs and expected outputs*/
                    
                    ////////////////////////
                    x = i;
                    y = j;
                    out_expected = ~x;
                    ////////////////////////

                    #1;
                    if (out === out_expected) begin
                        correct = correct + 1;
                    end
                    else begin
                        $display("Error) x: %0b, y: %0b, out: %0b (Ans: %0b)", x, y, out, out_expected);
                        wrong = wrong + 1;
                    end
                end
            end
        end
    endtask

endmodule