/* CSED273 lab1 experiment 2_i */
/* lab1_2_i.v */


/* Implement AND with {OR, NOT}
 * You are only allowed to wire modules together */
module lab1_2_i(outAND, inA, inB);
    output wire outAND;
    input wire inA, inB;

    ////////////////////////
    wire notA, notB, orNotANotB;
    not(notA, inA);
    not(notB, inB);
    or(orNotANotB, notA, notB);
    not(outAND, orNotANotB);
    ////////////////////////

endmodule