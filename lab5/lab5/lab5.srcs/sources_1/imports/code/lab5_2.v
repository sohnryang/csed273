/* CSED273 lab5 experiment 2 */
/* lab5_2.v */

`timescale 1ns / 1ps

/* Implement srLatch */
module srLatch(
    input s, r, reset_n,
    output q, q_
    );

    ////////////////////////
    nand(q, s, q_);
    nand(q_, q, r, reset_n); // use reset_n for q-bar output
    ////////////////////////

endmodule

module lab5_2_simple(
    input reset_n, j, k, clk,
    output q, q_
    );
    wire master_s, master_r, master_q, master_q_; // input/outputs of master
    nand(master_s, j, clk);
    nand(master_r, clk, k);
    srLatch master(master_s, master_r, reset_n, master_q, master_q_);
    wire negclk, slave_s, slave_r, slave_q, slave_q_; // input/outputs of slave
    not(negclk, clk); // invert clock signal
    nand(slave_s, master_q, negclk);
    nand(slave_r, negclk, master_q_);
    srLatch slave(slave_s, slave_r, reset_n, slave_q, slave_q_);
    
    // slave output goes to module output
    assign q = slave_q;
    assign q_ = slave_q_;
endmodule

/* Implement master-slave JK flip-flop with srLatch module */
module lab5_2(
    input reset_n, j, k, clk,
    output q, q_
    );

    ////////////////////////
    wire master_s, master_r, master_q, master_q_; // input/outputs of master
    
    // add feedbacks inputs to master s, r input
    nand(master_s, j, clk, q_);
    nand(master_r, clk, k, q);
    srLatch master(master_s, master_r, reset_n, master_q, master_q_);
    wire negclk, slave_s, slave_r, slave_q, slave_q_; // input/outputs of slave
    not(negclk, clk); // invert clock signal
    nand(slave_s, master_q, negclk);
    nand(slave_r, negclk, master_q_);
    srLatch slave(slave_s, slave_r, reset_n, slave_q, slave_q_);
    
    // slave output goes to module output
    assign q = slave_q;
    assign q_ = slave_q_;
    ////////////////////////
    
endmodule