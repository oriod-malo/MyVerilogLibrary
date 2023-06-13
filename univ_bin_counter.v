/*
		Universal binary counter with
			* synchronous clear
			* enable
			* load
			* direction (up or not(up) which is equal to down)
			* min and max tick
*/


module univ_bin_counter
	#(parameter N=8)
	(
		input wire clk, reset,
		input wire sync_clear, enable, load, up,
		input wire [N-1:0] d,
		output wire [N-1:0] q,
		output wire min_tick, max_tick);
		
		// Signal declarations
		reg [N-1:0] r_reg, r_next;
		
		// Register file
		always @ (posedge clk, posedge reset)
		if(reset)
			r_reg <= 0;
		else
			r_reg <= r_next;
		
		// Next-state logic
		always @*
		if(sync_clear)
			r_next = 4'b0;
		else if (load)
			r_next = d;
		else if (enable & up)
			r_next = r_reg + 1;
		else if (enable & ~up)
			r_next = r_reg - 1;
		else
			r_next = r_reg;
		
		// Output file
		assign q = r_reg;
		assign max_tick = (r_reg == 2**N-1) ? 1'b1 : 1'b0;
		assign min_tick = (r_reg == 0) ? 1'b1 : 1'b0;
		
endmodule
