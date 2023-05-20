/* CSED273 lab6 experiment 3 */
/* lab6_3.v */

`timescale 1ps / 1fs

/* Implement 369 game counter (0, 3, 6, 9, 13, 6, 9, 13, 6 ...)
 * You must first implement D flip-flop in lab6_ff.v
 * then you use D flip-flop of lab6_ff.v */
module counter_369(input reset_n, input clk, output [3:0] count);

    ////////////////////////
    wire d0, d1, d2, d3;
    assign d0 = ~count[0] | ~count[2] & count[3];
    assign d1 = ~count[2] & ~count[3] | count[2] & count[3];
    assign d2 = count[0];
    assign d3 = ~count[0] & count[1] | ~count[2] & count[3];
    edge_trigger_D_FF dff0(reset_n, d0, clk, count[0]);
    edge_trigger_D_FF dff1(reset_n, d1, clk, count[1]);
    edge_trigger_D_FF dff2(reset_n, d2, clk, count[2]);
    edge_trigger_D_FF dff3(reset_n, d3, clk, count[3]);
    ////////////////////////
	
endmodule
