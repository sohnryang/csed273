// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.2 (win64) Build 3367213 Tue Oct 19 02:48:09 MDT 2021
// Date        : Tue May  9 23:47:20 2023
// Host        : DESKTOP-3IO4RSP running 64-bit major release  (build 9200)
// Command     : write_verilog -mode timesim -nolib -sdf_anno true -force -file
//               C:/Users/PLUS/curling_grad/csed273/lab5/lab5/lab5.sim/sim_1/synth/timing/xsim/lab5_2_tb_time_synth.v
// Design      : lab5_2
// Purpose     : This verilog netlist is a timing simulation representation of the design and should not be modified or
//               synthesized. Please ensure that this netlist is used with the corresponding SDF file.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps
`define XIL_TIMING

(* NotValidForBitStream *)
module lab5_2
   (reset_n,
    j,
    k,
    clk,
    q,
    q_);
  input reset_n;
  input j;
  input k;
  input clk;
  output q;
  output q_;

  wire clk;
  wire clk_IBUF;
  wire j;
  wire j_IBUF;
  wire k;
  wire k_IBUF;
  wire master_q_;
  wire q;
  wire q_;
  wire q_OBUF;
  wire q__OBUF;
  wire reset_n;
  wire reset_n_IBUF;

initial begin
 $sdf_annotate("lab5_2_tb_time_synth.sdf",,,,"tool_control");
end
  IBUF clk_IBUF_inst
       (.I(clk),
        .O(clk_IBUF));
  IBUF j_IBUF_inst
       (.I(j),
        .O(j_IBUF));
  IBUF k_IBUF_inst
       (.I(k),
        .O(k_IBUF));
  OBUF q_OBUF_inst
       (.I(q_OBUF),
        .O(q));
  LUT3 #(
    .INIT(8'h37)) 
    q_OBUF_inst_i_1
       (.I0(clk_IBUF),
        .I1(q__OBUF),
        .I2(master_q_),
        .O(q_OBUF));
  LUT6 #(
    .INIT(64'h7F7F0C00FFFFFFFF)) 
    q_OBUF_inst_i_2
       (.I0(j_IBUF),
        .I1(clk_IBUF),
        .I2(q__OBUF),
        .I3(k_IBUF),
        .I4(master_q_),
        .I5(reset_n_IBUF),
        .O(master_q_));
  OBUF q__OBUF_inst
       (.I(q__OBUF),
        .O(q_));
  LUT4 #(
    .INIT(16'hDF8F)) 
    q__OBUF_inst_i_1
       (.I0(clk_IBUF),
        .I1(q__OBUF),
        .I2(reset_n_IBUF),
        .I3(master_q_),
        .O(q__OBUF));
  IBUF reset_n_IBUF_inst
       (.I(reset_n),
        .O(reset_n_IBUF));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
