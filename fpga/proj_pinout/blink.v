module blink(
  output [194:0] LEDG    
);    


    reg [32:0] counter;
    wire [194:0] hold;
    reg state;     
    reg stateq;     
    reg start;
	    
    wire clk;    
    wire clk0_out;
    
   
EG_PHY_OSC #(
		.STDBY("DISABLE"))
		inst(
		.osc_clk(clk),
		.osc_dis(1'b0));		
		
		
ghfh ghfh(		
		.refclk(clk),
		.reset(1'b0),
		.clk0_out(clk0_out));
		
//assign LEDG = counter;				
				
				
genvar i;				
generate
 for (i=0; i<194; i=i+1) begin
     async_transmitter trx_i(
	.clk(clk0_out),
	.TxD_start(start),
	.TxD_data(i),
	.TxD(hold[i]),
	.TxD_busy()
    );	
    wire [7:0]data_i;    
    assign LEDG[i] = hold[i] ? 1'bz : 1'b0;
 end
endgenerate			
   
    /* always */
    always @ (posedge clk0_out) begin
        counter <= counter + 1;
        state <= counter[20]; // <------ data to change                         
        //wr_sync <= {wr_sync[0], state}; 		
        //start = !stateq && state;   
    end         
       

always @(posedge clk0_out)
begin
stateq <= state;
start <= pulsy;
end
wire pulsy;
assign pulsy = state & ~stateq;

endmodule
