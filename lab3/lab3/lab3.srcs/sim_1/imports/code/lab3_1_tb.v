/* CSED273 lab3 experiment 1 */
/* lab3_1_tb.v */
`timescale 1ns/1ps

/* Feel free to play around with this testbench. */
module lab3_1_tb();
    reg en;
    reg [3:0] in;
    wire [15:0] out;
	
	lab3_1 decoder (en, in, out);
	
	initial begin
		en <= 0;
		in <= 4'b0;
		
		#32 $finish;
	end
	
	/* Keep in mind that you must not use
	 * an arithmetic operation in the submission code */
	always begin
		#1 in <= in + 1;
	end
	
	initial begin
		#16 en <= ~en;
	end
	
endmodule