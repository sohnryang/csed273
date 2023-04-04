/* CSED273 lab3 experiment 3 */
/* lab3_3.v */


/* 8-to-1 Multiplexer
 * You must use this module to implement 5-bit Majority Function */
module mux(
    input wire [7:0] data_input,
    input wire [2:0] select_input,
    output wire out
    );

    wire i0, i1, i2, i3, i4, i5, i6, i7;
    and(i0, ~select_input[2], ~select_input[1], ~select_input[0], data_input[0]);
    and(i1, ~select_input[2], ~select_input[1],  select_input[0], data_input[1]);
    and(i2, ~select_input[2],  select_input[1], ~select_input[0], data_input[2]);
    and(i3, ~select_input[2],  select_input[1],  select_input[0], data_input[3]);
    and(i4,  select_input[2], ~select_input[1], ~select_input[0], data_input[4]);
    and(i5,  select_input[2], ~select_input[1],  select_input[0], data_input[5]);
    and(i6,  select_input[2],  select_input[1], ~select_input[0], data_input[6]);
    and(i7,  select_input[2],  select_input[1],  select_input[0], data_input[7]);
    or(out, i0, i1, i2, i3, i4, i5, i6, i7);

endmodule


/* Implement 5-bit Majority Function
 * You are allowed to use keword "assign" and operator "&","|","~",
 * or just implement with gate-level-modeling (and, or, not) */
module lab3_3(
    input wire [4:0] in,
    output wire out
    );

    ////////////////////////
    wire [7:0] mux_data_input; // data inputs for mux
    
    // Assign data inputs
    assign mux_data_input[0] = 0;
    assign mux_data_input[1] = in[0] & in[1];
    assign mux_data_input[2] = in[0] & in[1];
    assign mux_data_input[3] = in[0] | in[1];
    assign mux_data_input[4] = in[0] & in[1];
    assign mux_data_input[5] = in[0] | in[1];
    assign mux_data_input[6] = in[0] | in[1];
    assign mux_data_input[7] = 1;
    wire [3:0] mux_select_input; // selection input for mux
    assign mux_select_input[3:0] = in[4:2]; // high 3 bits are used for selection
    mux mux0(mux_data_input, mux_select_input, out);
    ////////////////////////

endmodule
