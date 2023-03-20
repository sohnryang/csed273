/* CSED273 lab1 experiment 1 */
/* lab1_1.v */


/* Implement AND */
module lab1_1(outAND, inA, inB);
    output wire outAND;
    input wire inA, inB;

    ////////////////////////
    and(outAND, inA, inB);
    ////////////////////////

endmodule