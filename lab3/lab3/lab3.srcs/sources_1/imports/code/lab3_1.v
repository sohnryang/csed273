/* CSED273 lab3 experiment 1 */
/* lab3_1.v */


/* Active Low 2-to-4 Decoder
 * You must use this module to implement Active Low 4-to-16 decoder */
module decoder(
    input wire en,
    input wire [1:0] in,
    output wire [3:0] out 
    );

    nand(out[0], ~in[0], ~in[1], ~en);
    nand(out[1],  in[0], ~in[1], ~en);
    nand(out[2], ~in[0],  in[1], ~en);
    nand(out[3],  in[0],  in[1], ~en);

endmodule


/* Implement Active Low 4-to-16 Decoder
 * You may use keword "assign" and operator "&","|","~",
 * or just implement with gate-level modeling (and, or, not) */
module lab3_1(
    input wire en,
    input wire [3:0] in,
    output wire [15:0] out
    );

    ////////////////////////
    wire [3:0] out0, out1, out2, out3; // use wires for 2-to-4 decoder outputs
    decoder dec0(en |  in[3] |  in[2], in[1:0], out0); // enable decoder for [3:0] only when in[3:2] = 00
    decoder dec1(en |  in[3] | ~in[2], in[1:0], out1); // enable decoder for [7:4] only when in[3:2] = 01
    decoder dec2(en | ~in[3] |  in[2], in[1:0], out2); // enable decoder for [11:8] only when in[3:2] = 10
    decoder dec3(en | ~in[3] | ~in[2], in[1:0], out3); // enable decoder for [15:12] only when in[3:2] = 11
    // Assign outputs according to appropriate range
    assign out[ 3: 0] = out0;
    assign out[ 7: 4] = out1;
    assign out[11: 8] = out2;
    assign out[15:12] = out3;
    ////////////////////////

endmodule
