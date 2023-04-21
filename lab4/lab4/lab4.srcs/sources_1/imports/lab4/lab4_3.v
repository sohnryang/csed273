/* CSED273 lab4 experiment 3 */
/* lab4_3.v */

/* Implement 5-Bit Ripple Subtractor
 * You must use lab4_2 module in lab4_2.v
 * You may use keword "assign" and bitwise operator
 * or just implement with gate-level modeling*/
module lab4_3(
    input [4:0] in_a,
    input [4:0] in_b,
    input in_c,
    output [4:0] out_s,
    output out_c
    );

    ////////////////////////
    wire c0, c1, c2, c3, c4, c5; // wires for intermediate carry results
    assign c0 = in_c; // assign in_c to c0 for consistency
    fullAdder fa0(in_a[0], ~in_b[0], c0, out_s[0], c1); // full adder for bit 0
    fullAdder fa1(in_a[1], ~in_b[1], c1, out_s[1], c2); // full adder for bit 1
    fullAdder fa2(in_a[2], ~in_b[2], c2, out_s[2], c3); // full adder for bit 2
    fullAdder fa3(in_a[3], ~in_b[3], c3, out_s[3], c4); // full adder for bit 3
    fullAdder fa4(in_a[4], ~in_b[4], c4, out_s[4], c5); // full adder for bit 4
    assign out_c = c5; // carry output for ripple carry adder
    ////////////////////////

endmodule