/* CSED273 lab5 experiment 1 */
/* lab5_1.v */

`timescale 1ps / 1fs

/* Implement adder 
 * You must not use Verilog arithmetic operators */
module adder(
    input [3:0] x,
    input [3:0] y,
    input c_in,             // Carry in
    output [3:0] out,
    output c_out            // Carry out
); 

    ////////////////////////
    wire [3:0] sum, half_carry1, half_carry2; // wires to hold intermediate results
    wire [4:0] intermediate_carrys; // intermediate carry outputs of full adders
    assign intermediate_carrys[0] = c_in; // first carry is carry input
    assign sum = x ^ y; // carryless sums are just xor
    assign half_carry1 = x & y; // carry outputs of first half adders

    // second half adder run for bit 0
    assign out[0] = sum[0] ^ intermediate_carrys[0];
    assign half_carry2[0] = sum[0] & intermediate_carrys[0];
    assign intermediate_carrys[1] = half_carry1[0] | half_carry2[0];

    // second half adder run for bit 1
    assign out[1] = sum[1] ^ intermediate_carrys[1];
    assign half_carry2[1] = sum[1] & intermediate_carrys[1];
    assign intermediate_carrys[2] = half_carry1[1] | half_carry2[1];

    // second half adder run for bit 2
    assign out[2] = sum[2] ^ intermediate_carrys[2];
    assign half_carry2[2] = sum[2] & intermediate_carrys[2];
    assign intermediate_carrys[3] = half_carry1[2] | half_carry2[2];

    // second half adder run for bit 3
    assign out[3] = sum[3] ^ intermediate_carrys[3];
    assign half_carry2[3] = sum[3] & intermediate_carrys[3];
    assign intermediate_carrys[4] = half_carry1[3] | half_carry2[3];

    // carry out
    assign c_out = intermediate_carrys[4];
    ////////////////////////

endmodule

/* Implement arithmeticUnit with adder module
 * You must use one adder module.
 * You must not use Verilog arithmetic operators */
module arithmeticUnit(
    input [3:0] x,
    input [3:0] y,
    input [2:0] select,
    output [3:0] out,
    output c_out            // Carry out
);

    ////////////////////////
    wire [1:0] carry_mux_in;
    assign carry_mux_in[0] = 0;
    assign carry_mux_in[1] = 1;
    wire c_in;
    mux2to1 carry_mux(carry_mux_in, select[0], c_in);

    wire [3:0] a_mux_in0, a_mux_in1, a_mux_in2, a_mux_in3, a_mux_out;
    // bit 0 of a input
    assign a_mux_in0[0] = 0;
    assign a_mux_in0[1] = y[0];
    assign a_mux_in0[2] = ~y[0];
    assign a_mux_in0[3] = 1;
    mux4to1 a_mux0(a_mux_in0, select[2:1], a_mux_out[0]);
    
    // bit 1 of a input
    assign a_mux_in1[0] = 0;
    assign a_mux_in1[1] = y[1];
    assign a_mux_in1[2] = ~y[1];
    assign a_mux_in1[3] = 1;
    mux4to1 a_mux1(a_mux_in1, select[2:1], a_mux_out[1]);
    
    // bit 2 of a input
    assign a_mux_in2[0] = 0;
    assign a_mux_in2[1] = y[2];
    assign a_mux_in2[2] = ~y[2];
    assign a_mux_in2[3] = 1;
    mux4to1 a_mux2(a_mux_in2, select[2:1], a_mux_out[2]);
    
    // bit 3 of a input
    assign a_mux_in3[0] = 0;
    assign a_mux_in3[1] = y[3];
    assign a_mux_in3[2] = ~y[3];
    assign a_mux_in3[3] = 1;
    mux4to1 a_mux3(a_mux_in3, select[2:1], a_mux_out[3]);

    wire [3:0] b_input;
    assign b_input = x; // b input is just x
    adder add(a_mux_out, b_input, c_in, out, c_out); // run the adder
    ////////////////////////

endmodule

/* Implement 4:1 mux */
module mux4to1(
    input [3:0] in,
    input [1:0] select,
    output out
);

    ////////////////////////
    wire [1:0] mout;
    // two muxes for lower bits
    mux2to1 mux01(in[1:0], select[0], mout[0]);
    mux2to1 mux23(in[3:2], select[0], mout[1]);
    // selection mux for output selection
    mux2to1 sel(mout, select[1], out);
    ////////////////////////

endmodule

/* Implement logicUnit with mux4to1 */
module logicUnit(
    input [3:0] x,
    input [3:0] y,
    input [1:0] select,
    output [3:0] out
);

    ////////////////////////
    // mux input/outputs for bit 0
    wire [3:0] mux_in0;
    assign mux_in0[0] = x[0] & y[0];
    assign mux_in0[1] = x[0] | y[0];
    assign mux_in0[2] = x[0] ^ y[0];
    assign mux_in0[3] = ~x[0];
    mux4to1 mux0(mux_in0, select, out[0]);
    
    // mux input/outputs for bit 1
    wire [3:0] mux_in1;
    assign mux_in1[0] = x[1] & y[1];
    assign mux_in1[1] = x[1] | y[1];
    assign mux_in1[2] = x[1] ^ y[1];
    assign mux_in1[3] = ~x[1];
    mux4to1 mux1(mux_in1, select, out[1]);
    
    // mux input/outputs for bit 2
    wire [3:0] mux_in2;
    assign mux_in2[0] = x[2] & y[2];
    assign mux_in2[1] = x[2] | y[2];
    assign mux_in2[2] = x[2] ^ y[2];
    assign mux_in2[3] = ~x[2];
    mux4to1 mux2(mux_in2, select, out[2]);
    
    // mux input/outputs for bit 3
    wire [3:0] mux_in3;
    assign mux_in3[0] = x[3] & y[3];
    assign mux_in3[1] = x[3] | y[3];
    assign mux_in3[2] = x[3] ^ y[3];
    assign mux_in3[3] = ~x[3];
    mux4to1 mux3(mux_in3, select, out[3]);
    ////////////////////////

endmodule

/* Implement 2:1 mux */
module mux2to1(
    input [1:0] in,
    input  select,
    output out
);

    ////////////////////////
    assign out = ~select & in[0] | select & in[1];
    ////////////////////////

endmodule

/* Implement ALU with mux2to1 */
module lab5_1(
    input [3:0] x,
    input [3:0] y,
    input [3:0] select,
    output [3:0] out,
    output c_out            // Carry out
);

    ////////////////////////
    wire [3:0] arith_out, logic_out; // arithmetic output and logic output
    wire arith_c_out; // carry output for arithmetic result
    
    // run the modules
    arithmeticUnit arith(x, y, select[2:0], arith_out, arith_c_out);
    logicUnit logic(x, y, select[1:0], logic_out);

    // populate mux inputs and outputs for all bits
    wire [1:0] mux_in0, mux_in1, mux_in2, mux_in3, carry_mux_in;
    
    // mux for bit 0
    assign mux_in0[0] = arith_out[0];
    assign mux_in0[1] = logic_out[0];
    mux2to1 mux0(mux_in0, select[3], out[0]);
    
    // mux for bit 1
    assign mux_in1[0] = arith_out[1];
    assign mux_in1[1] = logic_out[1];
    mux2to1 mux1(mux_in1, select[3], out[1]);
    
    // mux for bit 2
    assign mux_in2[0] = arith_out[2];
    assign mux_in2[1] = logic_out[2];
    mux2to1 mux2(mux_in2, select[3], out[2]);
    
    // mux for bit 3
    assign mux_in3[0] = arith_out[3];
    assign mux_in3[1] = logic_out[3];
    mux2to1 mux3(mux_in3, select[3], out[3]);
    
    // populate mux input and output for carry out
    assign carry_mux_in[0] = arith_c_out;
    assign carry_mux_in[1] = 0;
    mux2to1 carry_mux(carry_mux_in, select[3], c_out);
    ////////////////////////

endmodule
