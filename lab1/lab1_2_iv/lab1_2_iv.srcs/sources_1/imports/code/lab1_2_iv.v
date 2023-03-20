/* CSED273 lab1 experiment 2_iv */
/* lab1_2_iv.v */


module lab1_2_iv(outAND, outOR, outNOT, inA, inB);
    output wire outAND, outOR, outNOT;
    input wire inA, inB;

    AND _AND(outAND, inA, inB);
    OR _OR(outOR, inA, inB);
    NOT _NOT(outNOT, inA);
endmodule


/* Implement AND, OR, and NOT modules with {NOR}
 * You are only allowed to wire modules below
 * i.e.) No and, or, not, etc. Only nor, AND, OR, NOT are available*/
module AND(outAND, inA, inB);
    output wire outAND;
    input wire inA, inB; 

    ////////////////////////
    wire notA, notB;
    nor(notA, inA, inA);
    nor(notB, inB, inB);
    nor(outAND, notA, notB);
    ////////////////////////

endmodule

module OR(outOR, inA, inB); 
    output wire outOR;
    input wire inA, inB;

    ////////////////////////
    wire norAB;
    nor(norAB, inA, inB);
    nor(outOR, norAB, norAB);
    ////////////////////////

endmodule

module NOT(outNOT, inA);
    output wire outNOT;
    input wire inA; 

    ////////////////////////
    nor(outNOT, inA, inA);
    ////////////////////////

endmodule