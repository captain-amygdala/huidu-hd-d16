//based on fpga4fun hdmi project
//using anlogic oddr as serializer

module HDMI_test(
	input pclk,	
	input hs,	
	input vs,	
	input de,	
	input pin,	
	output LED,	
	input [23:0] video,	
	output [2:0] TMDSp, TMDSn,
	output TMDSp_clock, TMDSn_clock
);

wire clk_TMDS,clk_TMDSx5, pixclk;
wire [9:0] TMDS_redx5, TMDS_greenx5, TMDS_bluex5;
reg [3:0] TMDS_mod5x5=0; 
reg [9:0] TMDS_shift_redx5=0, TMDS_shift_greenx5=0, TMDS_shift_bluex5=0, TMDS_shift_clkx5=0;
reg TMDS_shift_loadx5=0;
reg [23:0] vid,qvid;
reg q_vs,d_vs,q_hs,d_hs,q_de,d_de;

assign LED = pin;

//pll
ghfh ghfh(		
		.refclk(pclk),
		.reset(1'b0),
		.clk0_out(pixclk),		
		.clk1_out(clk_TMDS),		
		.clk2_out(clk_TMDSx5)		
);


//sync in video data
always @(posedge pixclk) 
begin
	qvid <= video; vid <= qvid;
	q_vs <= d_vs; d_vs <= vs;
	q_hs <= d_hs; d_hs <= hs;
	q_de <= d_de; d_de <= de;
end

//encode tmds
wire [9:0] TMDS_red, TMDS_green, TMDS_blue;
TMDS_encoder encode_R(.clk(pixclk), .VD(vid[23:16]  ), .CD(2'b00)        , .VDE(q_de), .TMDS(TMDS_redx5));
TMDS_encoder encode_G(.clk(pixclk), .VD(vid[15:8]), .CD(2'b00)        , .VDE(q_de), .TMDS(TMDS_greenx5));
TMDS_encoder encode_B(.clk(pixclk), .VD(vid[7:0] ), .CD({q_vs,q_hs}), .VDE(q_de), .TMDS(TMDS_bluex5));

//CDC pixclk5x
reg [9:0] d_TMDS_redx5,q_TMDS_redx5;
reg [9:0] d_TMDS_greenx5,q_TMDS_greenx5;
reg [9:0] d_TMDS_bluex5,q_TMDS_bluex5;

always @(posedge clk_TMDSx5)
begin
d_TMDS_redx5   <= TMDS_redx5;   q_TMDS_redx5 <= d_TMDS_redx5;
d_TMDS_greenx5 <= TMDS_greenx5; q_TMDS_greenx5 <= d_TMDS_greenx5; 
d_TMDS_bluex5  <= TMDS_bluex5;  q_TMDS_bluex5 <= d_TMDS_bluex5;
end


//serialize rgb to tmds, 5x pixelclock
always @(posedge clk_TMDSx5) TMDS_shift_loadx5 <= (TMDS_mod5x5==4'd4);
always @(posedge clk_TMDSx5)
begin
	TMDS_shift_redx5   <= TMDS_shift_loadx5 ? q_TMDS_redx5   : TMDS_shift_redx5   >> 2;
	TMDS_shift_greenx5 <= TMDS_shift_loadx5 ? q_TMDS_greenx5 : TMDS_shift_greenx5 >> 2;
	TMDS_shift_bluex5  <= TMDS_shift_loadx5 ? q_TMDS_bluex5  : TMDS_shift_bluex5  >> 2;	
	TMDS_shift_clkx5  <= TMDS_shift_loadx5 ? 10'b0000011111 : {TMDS_shift_clkx5[1:0], TMDS_shift_clkx5[9:2]};		
	TMDS_mod5x5 <= (TMDS_mod5x5==4'd4) ? 4'd0 : TMDS_mod5x5+4'd1;
end

//serialize tmds to ddr cells
reg [1:0]red_p;always @(posedge clk_TMDSx5)red_p <= TMDS_shift_redx5;
reg [1:0]red_n;always @(posedge clk_TMDSx5)red_n <=~TMDS_shift_redx5;
ddr red(
 .q(TMDSp[2]), 
 .clk(clk_TMDSx5), 
 .d1(red_p[1]), 
 .d0(red_p[0]), 
 .rst(1'b0) 
 ); 
 
ddr ddrred_n(
 .q(TMDSn[2]), 
 .clk(clk_TMDSx5), 
 .d1(red_n[1]), 
 .d0(red_n[0]), 
 .rst(1'b0) 
 ); 

reg [1:0]green_p;always @(posedge clk_TMDSx5)green_p <= TMDS_shift_greenx5;
reg [1:0]green_n;always @(posedge clk_TMDSx5)green_n <=~TMDS_shift_greenx5;
ddr green(
 .q(TMDSp[1]), 
 .clk(clk_TMDSx5), 
 .d1(green_p[1]), 
 .d0(green_p[0]), 
 .rst(1'b0) 
 );  
  
ddr ddrgreen_n(
 .q(TMDSn[1]), 
 .clk(clk_TMDSx5), 
 .d1(green_n[1]), 
 .d0(green_n[0]), 
 .rst(1'b0) 
 );

reg [1:0]blue_p;always @(posedge clk_TMDSx5)blue_p <= TMDS_shift_bluex5;
reg [1:0]blue_n;always @(posedge clk_TMDSx5)blue_n <=~TMDS_shift_bluex5;
ddr blue(
 .q(TMDSp[0]), 
 .clk(clk_TMDSx5), 
 .d1(blue_p[1]), 
 .d0(blue_p[0]), 
 .rst(1'b0) 
 );  
 
ddr ddrblue_n(
 .q(TMDSn[0]), 
 .clk(clk_TMDSx5), 
 .d1(blue_n[1]), 
 .d0(blue_n[0]), 
 .rst(1'b0) 
 ); 

reg [1:0]clk_p;always @(posedge clk_TMDSx5)clk_p <= TMDS_shift_clkx5;
reg [1:0]clk_n;always @(posedge clk_TMDSx5)clk_n <=~TMDS_shift_clkx5;
ddr ddrclk_p(
 .q(TMDSp_clock), 
 .clk(clk_TMDSx5), 
 .d1(clk_p[1]), 
 .d0(clk_p[0]), 
 .rst(1'b0) 
 );  

ddr ddrclk_n(
 .q(TMDSn_clock), 
 .clk(clk_TMDSx5), 
 .d1(clk_n[1]), 
 .d0(clk_n[0]), 
 .rst(1'b0) 
 );

endmodule


////////////////////////////////////////////////////////////////////////
module TMDS_encoder(
	input clk,
	input [7:0] VD,  // video data (red, green or blue)
	input [1:0] CD,  // control data
	input VDE,  // video data enable, to choose between CD (when VDE=0) and VD (when VDE=1)
	output reg [9:0] TMDS = 0
);

wire [3:0] Nb1s = VD[0] + VD[1] + VD[2] + VD[3] + VD[4] + VD[5] + VD[6] + VD[7];
wire XNOR = (Nb1s>4'd4) || (Nb1s==4'd4 && VD[0]==1'b0);
wire [8:0] q_m = {~XNOR, q_m[6:0] ^ VD[7:1] ^ {7{XNOR}}, VD[0]};

reg [3:0] balance_acc = 0;
wire [3:0] balance = q_m[0] + q_m[1] + q_m[2] + q_m[3] + q_m[4] + q_m[5] + q_m[6] + q_m[7] - 4'd4;
wire balance_sign_eq = (balance[3] == balance_acc[3]);
wire invert_q_m = (balance==0 || balance_acc==0) ? ~q_m[8] : balance_sign_eq;
wire [3:0] balance_acc_inc = balance - ({q_m[8] ^ ~balance_sign_eq} & ~(balance==0 || balance_acc==0));
wire [3:0] balance_acc_new = invert_q_m ? balance_acc-balance_acc_inc : balance_acc+balance_acc_inc;
wire [9:0] TMDS_data = {invert_q_m, q_m[8], q_m[7:0] ^ {8{invert_q_m}}};
wire [9:0] TMDS_code = CD[1] ? (CD[0] ? 10'b1010101011 : 10'b0101010100) : (CD[0] ? 10'b0010101011 : 10'b1101010100);

always @(posedge clk) TMDS <= VDE ? TMDS_data : TMDS_code;
always @(posedge clk) balance_acc <= VDE ? balance_acc_new : 4'h0;
endmodule


////////////////////////////////////////////////////////////////////////