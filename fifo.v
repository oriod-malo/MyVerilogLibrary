module fifo
	#(
	parameter DATA_WIDTH=8,
	parameter ADDR_WIDTH=4
	)
	
	(
	input wire clk,reset,
	input wire rd, wr,
	input wire [DATA_WIDTH-1:0] w_data,
	output wire empty, full,
	output wire [DATA_WIDTH-1:0] r_data
	);
	
	// Signal Declaration
	wire [ADDR_WIDTH-1:0] w_addr, r_addr;
	wire wr_en, full_tmp;
	
	// Body
	assign wr_en = wr & ~full_tmp;
	assign full = full_tmp;
	// write enable 
	
	fifo_controller #(.ADDR_WIDTH(ADDR_WIDTH)) c_unit
	(.clk(clk), .reset(reset), .rd(rd), .wr(wr), .empty(empty),
	.full(full_tmp), .w_addr(w_addr), .r_addr(r_addr), .r_addr_next()	);
	
	reg_file #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) r_unit
	(.clk(clk), .wr_en(wr_en), .w_addr(w_addr), .r_addr(r_addr),
	.w_data(w_data), .r_data(r_data));
	
endmodule
