/* CSED273 lab3 experiment 2 */
/* lab3_2.v */


/* Implement Prime Number Indicator & Multiplier Indicator
 * You may use keword "assign" and operator "&","|","~",
 * or just implement with gate-level-modeling (and, or, not) */
 
/* 11: out_mul[4], 7: out_mul[3], 5: out_mul[2],
 * 3: out_mul[1], 1: out_mul[0] */
module lab3_2(
    input wire [3:0] in,
    output wire out_prime,
    output wire [4:0] out_mul
    );

    ////////////////////////
    assign out_prime = in[0] & in[1] & ~in[2] | in[0] & ~in[1] & in[2] | in[0] & in[1] & ~in[3] | in[1] & ~in[2] & ~in[3];
    
    // Multiples of 11 = 0b1011 : [11]
    wire min1011;
    assign min1011 =  in[3] & ~in[2] &  in[1] &  in[0];
    assign out_mul[4] = min1011;
    
    // Multiples of 7 = 0b0111 : [7, 14]
    wire min0111, min1110;
    assign min0111 = ~in[3] &  in[2] &  in[1] &  in[0];
    assign min1110 =  in[3] &  in[2] &  in[1] & ~in[0];
    assign out_mul[3] = min0111 | min1110;
    
    // Multiples of 5 = 0b0101 : [5, 10, 15]
    wire min0101, min1010, min1111;
    assign min0101 = ~in[3] &  in[2] & ~in[1] &  in[0];
    assign min1010 =  in[3] & ~in[2] &  in[1] & ~in[0];
    assign min1111 =  in[3] &  in[2] &  in[1] &  in[0];
    assign out_mul[2] = min0101 | min1010 | min1111;
    
    // Multiples of 3 = 0b0011 : [3, 6, 9, 12, 15]
    wire min0011, min0110, min1001, min1100;
    assign min0011 = ~in[3] & ~in[2] &  in[1] &  in[0];
    assign min0110 = ~in[3] &  in[2] &  in[1] & ~in[0];
    assign min1001 =  in[3] & ~in[2] & ~in[1] &  in[0];
    assign min1100 =  in[3] &  in[2] & ~in[1] & ~in[0];
    assign out_mul[1] = min0011 | min0110 | min1001 | min1100 | min1111;
    
    // Multiples of 2 = 0b0010 : [2, 4, 6, 8, 10, 12, 14]
    assign out_mul[0] = ~in[0] & in[1] | ~in[0] & in[3] | ~in[0] & in[2];
    ////////////////////////

endmodule