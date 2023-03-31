/* CSED273 lab3 experiment 2 */
/* lab3_2_tb.v */
`timescale 1ns/1ps

/* Feel free to play around with this testbench. */
module lab3_2_tb();
    reg [3:0] in;
    wire out_prime;
    wire [4:0] out_mul;
	
	lab3_2 special_decoder (in, out_prime, out_mul);
	
	initial begin
		in <= 4'b0;
		
		#16 $finish;
	end
	
	/* Keep in mind that you must not use
	 * an arithmetic operation in the submission code */
	always begin
		#1 in <= in + 1;
	end
	
endmodule