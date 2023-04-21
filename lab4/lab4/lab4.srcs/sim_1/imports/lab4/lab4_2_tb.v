`timescale 1ns / 1ps

module lab4_2_tb();

	integer i,j;
	integer Pass;
	integer Fail;

	reg [4:0] A;
	reg [4:0] B;

	wire CARRY;
	wire [4:0] OUT;

	lab4_2 ripple_adder(
		.in_a(A),
		.in_b(B),
		.in_c(1'b0),
		.out_s(OUT),
		.out_c(CARRY)
	);

	wire carry;
	wire [4:0] result;
	assign {carry, result} = A + B;

	initial begin
	    A = 5'b00000;
	    B = 5'b00000;
	    Pass = 0;
	    Fail = 0;
		for(i=0; i<=5'b11111; i=i+1) begin
		   for(j=0; j<=5'b11111; j=j+1) begin
		       #1 
		       if(OUT === result && CARRY == carry) Pass = Pass + 1;
		       else Fail = Fail + 1;
		       B = B + 5'b00001;
		   end
		   #1 A = A + 5'b00001;
		end

	    #1 $finish;
	end

endmodule
