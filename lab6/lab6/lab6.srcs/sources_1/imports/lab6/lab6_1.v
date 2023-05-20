/* CSED273 lab6 experiment 1 */
/* lab6_1.v */

`timescale 1ps / 1fs

/* Implement synchronous BCD decade counter (0-9)
 * You must use JK flip-flop of lab6_ff.v */
module decade_counter(input reset_n, input clk, output [3:0] count);

    ////////////////////////
    // Bit outputs of JK flip-flops
    wire bit0, bit0_, bit1, bit1_, bit2, bit2_, bit3, bit3_;

    edge_trigger_JKFF jkff_bit0(reset_n, 1'b1, 1'b1, clk, bit0, bit0_); // JK flip-flop for bit 0
    edge_trigger_JKFF jkff_bit1(reset_n, bit3_, 1'b1, bit0, bit1, bit1_); // JK flip-flop for bit 1
    edge_trigger_JKFF jkff_bit2(reset_n, 1'b1, 1'b1, bit1, bit2, bit2_); // JK flip-flop for bit 2
    edge_trigger_JKFF jkff_bit3(reset_n, bit1 & bit2, 1'b1, bit0, bit3, bit3_); // JK flip-flop for bit 3
    assign count = {bit3, bit2, bit1, bit0}; // assign to output
    ////////////////////////
	
endmodule
