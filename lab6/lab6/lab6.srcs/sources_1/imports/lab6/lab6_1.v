/* CSED273 lab6 experiment 1 */
/* lab6_1.v */

`timescale 1ps / 1fs

/* Implement synchronous BCD decade counter (0-9)
 * You must use JK flip-flop of lab6_ff.v */
module decade_counter(input reset_n, input clk, output [3:0] count);

    ////////////////////////
    // Bit outputs of JK flip-flops
    wire bit0, bit0_, bit1, bit1_, bit2, bit2_, bit3, bit3_;
    wire j3, k3, j2, k2, j1, k1, j0, k0;
    assign j3 = bit0 & bit1 & bit2;
    assign k3 = bit0;
    assign j2 = bit0 & bit1;
    assign k2 = bit0 & bit1;
    assign j1 = bit0 & bit3_;
    assign k1 = bit0;
    assign j0 = 1;
    assign k0 = 1;
    edge_trigger_JKFF jkff_bit0(reset_n, j0, k0, clk, bit0, bit0_); // JK flip-flop for bit 0
    edge_trigger_JKFF jkff_bit1(reset_n, j1, k1, clk, bit1, bit1_); // JK flip-flop for bit 1
    edge_trigger_JKFF jkff_bit2(reset_n, j2, k2, clk, bit2, bit2_); // JK flip-flop for bit 2
    edge_trigger_JKFF jkff_bit3(reset_n, j3, k3, clk, bit3, bit3_); // JK flip-flop for bit 3
    assign count = {bit3, bit2, bit1, bit0}; // assign to output
    ////////////////////////
	
endmodule
