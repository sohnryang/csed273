/* CSED273 lab2 experiment 1 */
/* lab2_1.v */

/* Unsimplifed equation
 * You are allowed to use keword "assign" and operator "&","|","~",
 * or just implement with gate-level-modeling (and, or, not) */
module lab2_1(
    output wire outGT, outEQ, outLT,
    input wire [1:0] inA,
    input wire [1:0] inB
    );

    CAL_GT cal_gt(outGT, inA, inB);
    CAL_EQ cal_eq(outEQ, inA, inB);
    CAL_LT cal_lt(outLT, inA, inB);
    
endmodule

/* Implement output about "A>B" */
module CAL_GT(
    output wire outGT,
    input wire [1:0] inA,
    input wire [1:0] inB
    );

    ////////////////////////
    wire min0100, min0110, min1000, min1100, min1101, min1110;
    assign min0100 = ~inA[0] &  inA[1] & ~inB[0] & ~inB[1];
    assign min0110 = ~inA[0] &  inA[1] &  inB[0] & ~inB[1];
    assign min1000 =  inA[0] & ~inA[1] & ~inB[0] & ~inB[1];
    assign min1100 =  inA[0] &  inA[1] & ~inB[0] & ~inB[1];
    assign min1101 =  inA[0] &  inA[1] & ~inB[0] &  inB[1];
    assign min1110 =  inA[0] &  inA[1] &  inB[0] & ~inB[1];
    assign outGT = min0100 | min0110 | min1000 | min1100 | min1101 | min1110;
    ////////////////////////

endmodule

/* Implement output about "A=B" */
module CAL_EQ(
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
module CAL_LT(
    output wire outLT,
    input wire [1:0] inA, 
    input wire [1:0] inB
    );

    ////////////////////////
    wire min0001, min0010, min0011, min0111, min1001, min1011;
    assign min0001 = ~inA[0] & ~inA[1] & ~inB[0] &  inB[1];
    assign min0010 = ~inA[0] & ~inA[1] &  inB[0] & ~inB[1];
    assign min0011 = ~inA[0] & ~inA[1] &  inB[0] &  inB[1];
    assign min0111 = ~inA[0] &  inA[1] &  inB[0] &  inB[1];
    assign min1001 =  inA[0] & ~inA[1] & ~inB[0] &  inB[1];
    assign min1011 =  inA[0] & ~inA[1] &  inB[0] &  inB[1];;
    assign outLT = min0001 | min0010 | min0011 | min0111 | min1001 | min1011;
    ////////////////////////

endmodule