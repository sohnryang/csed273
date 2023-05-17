`timescale 1ns / 1ps

module lab5_fpga (
    input clk,
    input btnCenter,
    btnTop,
    btnBottom,
    btnLeft,
    btnRight,
    input [15:0] sw,
    output [3:0] ssSel,
    output [7:0] ssDisp,
    output [15:0] led
);
  parameter arg0_str = 16'b0000110010111010;
  parameter arg1_str = 16'b0001110010111010;
  parameter op_str = 16'b1110000111010101;
  parameter res_str = 16'b1110010111011011;

  reg [3:0] arg0, arg1, op;
  reg [31:0] counter;
  reg [15:0] gbuf;
  wire [3:0] res;
  wire c_out;
  reg [1:0] state;
  reg blinker;

  initial begin
    arg0 <= 0;
    arg1 <= 0;
    op <= 0;
    counter <= 0;
    gbuf <= 16'b1111111111111111;
    state <= 0;
    blinker <= 0;
  end

  assign led = 16'b0000100110011001;

  lab5_1 alu (
      .x(arg0),
      .y(arg1),
      .select(op),
      .out(res),
      .c_out(c_out)
  );

  led_renderer renderer (
      .graphics(gbuf),
      .clk(clk),
      .segSel(ssSel),
      .seg(ssDisp)
  );

  // state machine
  always @(posedge clk) begin
    counter = counter + 1;
    if (counter == 100000000) begin
      counter <= 0;
      blinker <= !blinker;
    end
    if (btnLeft && state != 0) begin
      state   <= 0;
      counter <= 0;
      blinker <= 0;
    end else if (btnCenter && state != 1) begin
      state   <= 1;
      counter <= 0;
      blinker <= 0;
    end else if (btnRight && state != 2) begin
      state   <= 2;
      counter <= 0;
      blinker <= 0;
    end else if (btnTop && state != 3) begin
      state   <= 3;
      counter <= 0;
      blinker <= 0;
    end
  end

  // value change
  always @(posedge clk) begin
    case (state)
      0: arg0 <= sw[3:0];
      1: arg1 <= sw[7:4];
      2: op <= sw[11:8];
    endcase
  end

  // graphics buffer
  always @(posedge clk) begin
    case (state)
      0:
      if (blinker) begin
        gbuf[3:0]   <= 4'b1111;
        gbuf[7:4]   <= 4'b1111;
        gbuf[11:8]  <= (arg0 / 10);
        gbuf[15:12] <= (arg0 % 10);
      end else begin
        gbuf <= arg0_str;
      end
      1:
      if (blinker) begin
        gbuf[3:0]   <= 4'b1111;
        gbuf[7:4]   <= 4'b1111;
        gbuf[11:8]  <= (arg1 / 10);
        gbuf[15:12] <= (arg1 % 10);
      end else begin
        gbuf <= arg1_str;
      end
      2:
      if (blinker) begin
        gbuf[3:0]   <= 4'b1111;
        gbuf[7:4]   <= 4'b1111;
        gbuf[11:8]  <= (op / 10);
        gbuf[15:12] <= (op % 10);
      end else begin
        gbuf <= op_str;
      end
      3:
      if (blinker) begin
        gbuf[3:0]   <= c_out;
        gbuf[7:4]   <= 4'b1111;
        gbuf[11:8]  <= (res / 10);
        gbuf[15:12] <= (res % 10);
      end else begin
        gbuf <= res_str;
      end
    endcase
  end
endmodule


module lab5_1 (
    input [3:0] x,
    y,
    input [3:0] select,
    output [3:0] out,
    output c_out
);
  assign c_out = (x + y) | select;
  assign out   = x + y;
endmodule


module led_renderer (
    input [15:0] graphics,
    input clk,
    output reg [3:0] segSel,
    output reg [7:0] seg
);
  integer counter;
  wire [7:0] res0, res1, res2, res3;

  initial begin
    counter <= 0;
    segSel <= 14;
    seg <= 8'b11111111;
  end

  bcd_to_7seg pos0 (
      .bcd(graphics[3:0]),
      .seg(res0)
  );
  bcd_to_7seg pos1 (
      .bcd(graphics[7:4]),
      .seg(res1)
  );
  bcd_to_7seg pos2 (
      .bcd(graphics[11:8]),
      .seg(res2)
  );
  bcd_to_7seg pos3 (
      .bcd(graphics[15:12]),
      .seg(res3)
  );

  always @(posedge clk) begin
    counter <= counter + 1;
    if (counter == 100000) begin
      counter <= 0;
      case (segSel)
        14: begin
          segSel <= 13;
          seg <= res1;
        end
        13: begin
          segSel <= 11;
          seg <= res2;
        end
        11: begin
          segSel <= 7;
          seg <= res3;
        end
        7: begin
          segSel <= 14;
          seg <= res0;
        end
      endcase
    end
  end
endmodule


module bcd_to_7seg (
    input [3:0] bcd,
    output reg [7:0] seg
);

  always @(*) begin
    // dot, center, tl, bl, b, br, tr, t
    case (bcd)
      4'b0000: seg = 8'b11000000;  // 0
      4'b0001: seg = 8'b11111001;  // 1
      4'b0010: seg = 8'b10100100;  // 2
      4'b0011: seg = 8'b10110000;  // 3
      4'b0100: seg = 8'b10011001;  // 4
      4'b0101: seg = 8'b10010010;  // 5
      4'b0110: seg = 8'b10000010;  // 6
      4'b0111: seg = 8'b11111000;  // 7
      4'b1000: seg = 8'b10000000;  // 8
      4'b1001: seg = 8'b10010000;  // 9
      4'b1010: seg = 8'b10001000;  // A
      4'b1011: seg = 8'b10101111;  // r
      4'b1100: seg = 8'b11000010;  // g
      4'b1101: seg = 8'b10000110;  // E
      4'b1110: seg = 8'b10110111;  // =
      4'b1111: seg = 8'b11111111;  // off
      default: seg = 8'b11111111;
    endcase
  end
endmodule
