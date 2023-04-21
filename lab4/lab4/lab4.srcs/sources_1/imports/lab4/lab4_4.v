/* CSED273 lab4 experiment 4 */
/* lab4_4.v */

/* Implement 5x3 Binary Mutliplier
 * You must use lab4_2 module in lab4_2.v
 * You cannot use fullAdder or halfAdder module directly
 * You may use keword "assign" and bitwise operator
 * or just implement with gate-level modeling*/
    module lab4_4(
    input [4:0]in_a,
    input [2:0]in_b,
    output [7:0]out_m
    );

    ////////////////////////
    wire[4:0] mul_partial0, mul_partial1, mul_partial2; // wires for partial multiplication results
    // Populate partial results (the code can be simplified if for is allowed)
    assign mul_partial0[0] = in_b[0] & in_a[0];
    assign mul_partial0[1] = in_b[0] & in_a[1];
    assign mul_partial0[2] = in_b[0] & in_a[2];
    assign mul_partial0[3] = in_b[0] & in_a[3];
    assign mul_partial0[4] = in_b[0] & in_a[4];
    assign mul_partial1[0] = in_b[1] & in_a[0];
    assign mul_partial1[1] = in_b[1] & in_a[1];
    assign mul_partial1[2] = in_b[1] & in_a[2];
    assign mul_partial1[3] = in_b[1] & in_a[3];
    assign mul_partial1[4] = in_b[1] & in_a[4];
    assign mul_partial2[0] = in_b[2] & in_a[0];
    assign mul_partial2[1] = in_b[2] & in_a[1];
    assign mul_partial2[2] = in_b[2] & in_a[2];
    assign mul_partial2[3] = in_b[2] & in_a[3];
    assign mul_partial2[4] = in_b[2] & in_a[4];

    wire[4:0] adder0_in_a, adder0_in_b, adder0_out; // intermediate variables for adder 0
    wire adder0_carry; // carry output of adder 0
    // Populate A input of adder 0
    assign adder0_in_a[3:0] = mul_partial0[4:1];
    assign adder0_in_a[4] = 0;
    // Populate B input of adder 0
    assign adder0_in_b = mul_partial1;
    lab4_2 adder0(adder0_in_a, adder0_in_b, 0, adder0_out, adder0_carry); // run the addition

    wire[4:0] adder1_in_a, adder1_in_b, adder1_out; // intermediate variables for adder 1
    wire adder1_carry; // carry output of adder 1
    // Populate A input of adder 1
    assign adder1_in_a[3:0] = adder0_out[4:1];
    assign adder1_in_a[4] = adder0_carry;
    // Populate B input of adder 1
    assign adder1_in_b = mul_partial2;
    lab4_2 adder1(adder1_in_a, adder1_in_b, 0, adder1_out, adder1_carry); // run the addition

    // Populate output pins
    assign out_m[7] = adder1_carry;
    assign out_m[6:2] = adder1_out;
    assign out_m[1] = adder0_out[0];
    assign out_m[0] = mul_partial0[0];
    ////////////////////////
    
endmodule