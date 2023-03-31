/* CSED273 lab3 experiment 3 */
/* lab3_3_tb.v */
`timescale 1ns/1ps

/* Feel free to play around with this testbench. */
module lab3_3_tb();
    reg [4:0] in;
    wire out;
	
	lab3_3 majority (in, out);
	
	initial begin
		in <= 5'b0;
		
		#32 $finish;
	end
	
	/* Keep in mind that you must not use
	 * an arithmetic operation in the submission code */
	always begin
		#1 in <= in + 1;
	end
	
endmodule