/* CSED273 lab1 experiment 2_iii */
/* lab1_2_iii.v */


module lab1_2_iii(outAND, outOR, outNOT, inA, inB);
	output wire outAND, outOR, outNOT;
	input wire inA, inB;

	AND _AND(outAND, inA, inB);
	OR _OR(outOR, inA, inB);
	NOT _NOT(outNOT, inA);
endmodule


/* Implement AND, OR, and NOT modules with {NAND}
 * You are only allowed to wire modules below
 * i.e.) No and, or, not, etc. Only nand, AND, OR, NOT are available*/
module AND(outAND, inA, inB);
	output wire outAND;
	input wire inA, inB;

	////////////////////////
	wire nandAB;
	nand(nandAB, inA, inB);
	nand(outAND, nandAB, nandAB);
	////////////////////////

endmodule

module OR(outOR, inA, inB);
	output wire outOR;
	input wire inA, inB;

	//////////////////////// 
	wire notA, notB;
	nand(notA, inA, inA);
	nand(notB, inB, inB);
	nand(outOR, notA, notB);
	////////////////////////

endmodule

module NOT(outNOT, inA);
	output wire outNOT;
	input wire inA;

	////////////////////////
	nand(outNOT, inA, inA);
	////////////////////////

endmodule
