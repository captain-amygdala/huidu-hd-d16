module top
(
	input clk50,  // 25MHz
	output [2:0] TMDSp, TMDSn,
	output TMDSp_clock, TMDSn_clock
	
	
);


 //   Gowin_rPLL your_instance_name(
 //       .clkout(tdmsclk), //output clkout
 //       .clkoutd(), //output clkoutd
 //       .clkin(clk) //input clkin
 //   );
 
ghfh ghfh(		
		.refclk(clk50),
		.reset(1'b0),
		.clk0_out(),		
		.clk1_out(clk),		
		.clk2_out(tdmsclk));		
		


	wire clk;
	wire tdmsclk;
	reg clk_audio;
    reg soundclk;


	reg [31:0] audio_sample_word = 32'h00000000;
	//always @(posedge clk) audio_sample_word <= {audio_sample_word[16+:16] + 16'd1, audio_sample_word[0+:16] - 16'd1};
	//always @(posedge clk) audio_sample_word <= {data_out,8'h00, data_out,8'h00};
	always @(posedge clk) audio_sample_word <= {noise, noise};

	reg [23:0] rgb = 24'd0;
	wire [9:0] cx;
	wire [9:0] cy;
	wire [9:0] screen_start_x;
	wire [9:0] screen_start_y;
	wire [9:0] frame_width;
	wire [9:0] frame_height;
	wire [9:0] screen_width;
	wire [9:0] screen_height;


reg[27:0] counter=28'd0;
parameter DIVISOR = 28'd562;

always @(posedge clk)
begin
 counter <= counter + 28'd1;
 if(counter>=(DIVISOR-1))
  counter <= 28'd0;
  clk_audio <= (counter<DIVISOR/2)?1'b1:1'b0;
end

always @(posedge clk_audio)
begin
soundclk <= ~soundclk;
end


//declare the sine ROM - 30 registers each 8 bit wide.  
    reg [7:0] sine [0:29];
//Internal signals  
    integer i;  
    reg [7:0] data_out; 
//Initialize the sine rom with samples. 
    initial begin
        i = 0;
        sine[0] = 0;
        sine[1] = 16;
        sine[2] = 31;
        sine[3] = 45;
        sine[4] = 58;
        sine[5] = 67;
        sine[6] = 74;
        sine[7] = 77;
        sine[8] = 77;
        sine[9] = 74;
        sine[10] = 67;
        sine[11] = 58;
        sine[12] = 45;
        sine[13] = 31;
        sine[14] = 16;
        sine[15] = 0;
        sine[16] = -16;
        sine[17] = -31;
        sine[18] = -45;
        sine[19] = -58;
        sine[20] = -67;
        sine[21] = -74;
        sine[22] = -77;
        sine[23] = -77;
        sine[24] = -74;
        sine[25] = -67;
        sine[26] = -58;
        sine[27] = -45;
        sine[28] = -31;
        sine[29] = -16;
    end
    
    //At every positive edge of the clock, output a sine wave sample.
    always@ (posedge(soundclk))
    begin
        data_out = sine[i];
        i = i+ 1;
        if(i == 29)
            i = 0;
    end

wire [15:0] noise;
LFSR #(16'b1000000001011,0)
     lfsr_i3(clk, 1'b0, 1'b1, noise);

	//always @(posedge clk) rgb <= {(cx == 0 ? ~8'd0 : 8'd200), (cy == 0 ? ~8'd0 : 8'd400), ((cx == (screen_width - 1'd1)) || (cy == (screen_width - 1'd1)) ? ~8'd0 : {noise, noise})};

always @(posedge clk) rgb <= {noise, noise};

	hdmi #(
		.VIDEO_ID_CODE(17),
		.VIDEO_REFRESH_RATE(50),
		.AUDIO_RATE(48000),
		.AUDIO_BIT_WIDTH(16)
	) hdmi(
		.clk_pixel_x5(tdmsclk),
		.clk_pixel(clk),
		.clk_audio(clk_audio),
		.reset(~resetn),
		.rgb(rgb),
		.audio_sample_word(audio_sample_word),
		.tmds(tdms),
		.tmds_clock(tclk),
		.cx(cx),
		.cy(cy),
		.frame_width(frame_width),
		.frame_height(frame_height),
		.screen_width(screen_width),
		.screen_height(screen_height)
	);
	
wire [2:0] tdms;	
wire tclk;
wire resetn;

assign resetn = 1'b1;
assign TMDSp = tdms;
assign TMDSn = ~tdms;
assign TMDSp_clock = tclk;
assign TMDSn_clock = ~tclk;
	
	
endmodule
