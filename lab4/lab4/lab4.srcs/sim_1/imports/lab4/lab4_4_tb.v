`timescale 1ns / 1ps

module lab4_4_tb();

	integer i,j;
	integer Pass;
	integer Fail;

	reg [4:0] A;
	reg [2:0] B;

	wire [7:0] OUT;

	lab4_4 multiplier(
	   .in_a(A),
	   .in_b(B),
	   .out_m(OUT)
	);

	wire [7:0] result;
	assign result = A*B;

	initial begin
	    A = 5'b0000;
	    B = 3'b000;
	    Pass = 0;
	    Fail = 0;
		for(i=0; i<=5'b11111; i=i+1) begin
		   for(j=0; j<=3'b111; j=j+1) begin
		       #1 
		       if(OUT === result) Pass = Pass + 1;
		       else Fail = Fail + 1;
		       B = B + 3'b001;
		   end
		   #1 A = A + 5'b0001;
		end
	    #1 $finish;
	end
endmodule
