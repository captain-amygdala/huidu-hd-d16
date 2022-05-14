// Verilog netlist created by TD v5.0.30786
// Thu Apr 28 10:23:29 2022

`timescale 1ns / 1ps
module spi_rx_fifo  // spi_rx_fifo.v(14)
  (
  clkr,
  clkw,
  di,
  re,
  rst,
  we,
  do,
  empty_flag,
  full_flag
  );

  input clkr;  // spi_rx_fifo.v(25)
  input clkw;  // spi_rx_fifo.v(24)
  input [15:0] di;  // spi_rx_fifo.v(23)
  input re;  // spi_rx_fifo.v(25)
  input rst;  // spi_rx_fifo.v(22)
  input we;  // spi_rx_fifo.v(24)
  output [15:0] do;  // spi_rx_fifo.v(27)
  output empty_flag;  // spi_rx_fifo.v(28)
  output full_flag;  // spi_rx_fifo.v(29)

  wire empty_flag_neg;
  wire full_flag_neg;

  EG_PHY_CONFIG #(
    .DONE_PERSISTN("ENABLE"),
    .INIT_PERSISTN("ENABLE"),
    .JTAG_PERSISTN("DISABLE"),
    .PROGRAMN_PERSISTN("DISABLE"))
    config_inst ();
  not empty_flag_inv (empty_flag_neg, empty_flag);
  EG_PHY_FIFO #(
    .AE(32'b00000000000000000000000000011000),
    .AEP1(32'b00000000000000000000000000011100),
    .AF(32'b00000000000000000001111111101000),
    .AFM1(32'b00000000000000000001111111100100),
    .ASYNC_RESET_RELEASE("SYNC"),
    .DATA_WIDTH_A("4"),
    .DATA_WIDTH_B("4"),
    .E(32'b00000000000000000000000000000000),
    .EP1(32'b00000000000000000000000000000100),
    .F(32'b00000000000000000010000000000000),
    .FM1(32'b00000000000000000001111111111100),
    .GSR("DISABLE"),
    .MODE("FIFO8K"),
    .REGMODE_A("OUTREG"),
    .REGMODE_B("OUTREG"),
    .RESETMODE("ASYNC"))
    fifo_inst_0_ (
    .clkr(clkr),
    .clkw(clkw),
    .csr({2'b11,empty_flag_neg}),
    .csw({2'b11,full_flag_neg}),
    .dia({open_n47,open_n48,open_n49,open_n50,open_n51,di[3:0]}),
    .orea(1'b1),
    .oreb(1'b1),
    .re(re),
    .rprst(rst),
    .rst(rst),
    .we(we),
    .dob({open_n72,open_n73,open_n74,open_n75,open_n76,do[3:0]}),
    .empty_flag(empty_flag),
    .full_flag(full_flag));  // spi_rx_fifo.v(42)
  EG_PHY_FIFO #(
    .AE(32'b00000000000000000000000000011000),
    .AEP1(32'b00000000000000000000000000011100),
    .AF(32'b00000000000000000001111111101000),
    .AFM1(32'b00000000000000000001111111100100),
    .ASYNC_RESET_RELEASE("SYNC"),
    .DATA_WIDTH_A("4"),
    .DATA_WIDTH_B("4"),
    .E(32'b00000000000000000000000000000000),
    .EP1(32'b00000000000000000000000000000100),
    .F(32'b00000000000000000010000000000000),
    .FM1(32'b00000000000000000001111111111100),
    .GSR("DISABLE"),
    .MODE("FIFO8K"),
    .REGMODE_A("OUTREG"),
    .REGMODE_B("OUTREG"),
    .RESETMODE("ASYNC"))
    fifo_inst_1_ (
    .clkr(clkr),
    .clkw(clkw),
    .csr({2'b11,empty_flag_neg}),
    .csw({2'b11,full_flag_neg}),
    .dia({open_n77,open_n78,open_n79,open_n80,open_n81,di[7:4]}),
    .orea(1'b1),
    .oreb(1'b1),
    .re(re),
    .rprst(rst),
    .rst(rst),
    .we(we),
    .dob({open_n102,open_n103,open_n104,open_n105,open_n106,do[7:4]}));  // spi_rx_fifo.v(42)
  EG_PHY_FIFO #(
    .AE(32'b00000000000000000000000000011000),
    .AEP1(32'b00000000000000000000000000011100),
    .AF(32'b00000000000000000001111111101000),
    .AFM1(32'b00000000000000000001111111100100),
    .ASYNC_RESET_RELEASE("SYNC"),
    .DATA_WIDTH_A("4"),
    .DATA_WIDTH_B("4"),
    .E(32'b00000000000000000000000000000000),
    .EP1(32'b00000000000000000000000000000100),
    .F(32'b00000000000000000010000000000000),
    .FM1(32'b00000000000000000001111111111100),
    .GSR("DISABLE"),
    .MODE("FIFO8K"),
    .REGMODE_A("OUTREG"),
    .REGMODE_B("OUTREG"),
    .RESETMODE("ASYNC"))
    fifo_inst_2_ (
    .clkr(clkr),
    .clkw(clkw),
    .csr({2'b11,empty_flag_neg}),
    .csw({2'b11,full_flag_neg}),
    .dia({open_n109,open_n110,open_n111,open_n112,open_n113,di[11:8]}),
    .orea(1'b1),
    .oreb(1'b1),
    .re(re),
    .rprst(rst),
    .rst(rst),
    .we(we),
    .dob({open_n134,open_n135,open_n136,open_n137,open_n138,do[11:8]}));  // spi_rx_fifo.v(42)
  EG_PHY_FIFO #(
    .AE(32'b00000000000000000000000000011000),
    .AEP1(32'b00000000000000000000000000011100),
    .AF(32'b00000000000000000001111111101000),
    .AFM1(32'b00000000000000000001111111100100),
    .ASYNC_RESET_RELEASE("SYNC"),
    .DATA_WIDTH_A("4"),
    .DATA_WIDTH_B("4"),
    .E(32'b00000000000000000000000000000000),
    .EP1(32'b00000000000000000000000000000100),
    .F(32'b00000000000000000010000000000000),
    .FM1(32'b00000000000000000001111111111100),
    .GSR("DISABLE"),
    .MODE("FIFO8K"),
    .REGMODE_A("OUTREG"),
    .REGMODE_B("OUTREG"),
    .RESETMODE("ASYNC"))
    fifo_inst_3_ (
    .clkr(clkr),
    .clkw(clkw),
    .csr({2'b11,empty_flag_neg}),
    .csw({2'b11,full_flag_neg}),
    .dia({open_n141,open_n142,open_n143,open_n144,open_n145,di[15:12]}),
    .orea(1'b1),
    .oreb(1'b1),
    .re(re),
    .rprst(rst),
    .rst(rst),
    .we(we),
    .dob({open_n166,open_n167,open_n168,open_n169,open_n170,do[15:12]}));  // spi_rx_fifo.v(42)
  not full_flag_inv (full_flag_neg, full_flag);

endmodule 

