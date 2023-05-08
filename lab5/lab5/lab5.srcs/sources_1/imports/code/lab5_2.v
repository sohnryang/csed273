/* CSED273 lab5 experiment 2 */
/* lab5_2.v */

`timescale 1ns / 1ps

/* Implement srLatch */
module srLatch(
    input s, r,
    output q, q_
    );

    ////////////////////////
    nor(q, r, q_);
    nor(q_, q, s);
    ////////////////////////

endmodule

/* Implement master-slave JK flip-flop with srLatch module */
module lab5_2(
    input reset_n, j, k, clk,
    output q, q_
    );

    ////////////////////////
    wire neg_reset_n, r_with_reset, s_with_reset, r1, s1, p_, p, r2, s2, negclk;
    and(r1, q, k, clk);
    and(s1, clk, j, q_);
    not(neg_reset_n, reset_n);
    and(s_with_reset, s1, reset_n);
    or(r_with_reset, r1, neg_reset_n);
    srLatch sr1(s_with_reset, r_with_reset, p, p_);
    not(negclk, clk);
    and(r2, p_, negclk);
    and(s2, p, negclk);
    srLatch sr2(s2, r2, q, q_);
    ////////////////////////
    
endmodule