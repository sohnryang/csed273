`timescale 1ns / 1ps

module lab2_tb();
    wire outGT1, outEQ1, outLT1, outGT2, outEQ2, outLT2;
    reg [1:0] A, B;
	
    lab2_1 cmp1(outGT1, outEQ1, outLT1, A, B);
    lab2_2 cmp2(outGT2, outEQ2, outLT2, A, B);

    initial begin
        A = 2'b00;
        B = 2'b00;
        #16 $finish;
    end

    always begin
        #8 A[1] <= !A[1];
    end

    always begin
        #4 A[0] <= !A[0];
    end

    always begin
        #2 B[1] <= !B[1];
    end

    always begin
        #1 B[0] <= !B[0];
    end
endmodule