/* CSED273 lab2 experiment 2 */
/* lab2_2.v */

/* Simplifed equation by K-Map method
 * You are allowed to use keword "assign" and operator "&","|","~",
 * or just implement with gate-level-modeling (and, or, not) */
module lab2_2(
    output wire outGT, outEQ, outLT,
    input wire [1:0] inA,
    input wire [1:0] inB
    );

    CAL_GT_2 cal_gt2(outGT, inA, inB);
    CAL_EQ_2 cal_eq2(outEQ, inA, inB);
    CAL_LT_2 cal_lt2(outLT, inA, inB);

endmodule

/* Implement output about "A>B" */
module CAL_GT_2(
    output wire outGT,
    input wire [1:0] inA,
    input wire [1:0] inB
    );

    ////////////////////////
    assign outGT = inA[1] & ~inB[1] | inA[0] & ~inB[0] & ~inB[1] | inA[0] & inA[1] & ~inB[0];
    ////////////////////////

endmodule

/* Implement output about "A=B" */
module CAL_EQ_2(
    output wire outEQ,
    input wire [1:0] inA, 
    input wire [1:0] inB
    );

    ////////////////////////
    wire zeroEQ, oneEQ, twoEQ, threeEQ;
    assign zeroEQ  = ~inA[0] & ~inA[1] & ~inB[0] & ~inB[1];
    assign oneEQ   = ~inA[0] &  inA[1] & ~inB[0] &  inB[1];
    assign twoEQ   =  inA[0] & ~inA[1] &  inB[0] & ~inB[1];
    assign threeEQ =  inA[0] &  inA[1] &  inB[0] &  inB[1];
    assign outEQ = zeroEQ | oneEQ | twoEQ | threeEQ;
    ////////////////////////

endmodule

/* Implement output about "A<B" */
module CAL_LT_2(
    output wire outLT,
    input wire [1:0] inA, 
    input wire [1:0] inB
    );

    ////////////////////////
    assign outLT = ~inA[1] & inB[1] | ~inA[0] & inB[0] & inB[1] | ~inA[0] & ~inA[1] & inB[0];
    ////////////////////////

endmodule