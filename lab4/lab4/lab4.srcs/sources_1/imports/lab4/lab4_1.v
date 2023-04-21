/* CSED273 lab4 experiment 1 */
/* lab4_1.v */


/* Implement Half Adder
 * You may use keword "assign" and bitwise operator
 * or just implement with gate-level modeling*/
module halfAdder(
    input in_a,
    input in_b,
    output out_s,
    output out_c
    );

    ////////////////////////
    assign out_s = in_a ^ in_b; // add without carry is equivalent to XOR
    assign out_c = in_a & in_b; // carry is 1 iff both A and B are 1
    ////////////////////////

endmodule

/* Implement Full Adder
 * You must use halfAdder module
 * You may use keword "assign" and bitwise operator
 * or just implement with gate-level modeling*/
module fullAdder(
    input in_a,
    input in_b,
    input in_c,
    output out_s,
    output out_c
    );

    ////////////////////////
    wire s_ab, c_ab; // wire for intermediate outputs
    halfAdder ha1(in_a, in_b, s_ab, c_ab); // first half adder
    wire ha2_carry; // wire for carry out of second half adder
    halfAdder ha2(s_ab, in_c, out_s, ha2_carry); // second half adder
    assign out_c = c_ab | ha2_carry; // carry out if one of the carry out of two half adders is one
    ////////////////////////

endmodule