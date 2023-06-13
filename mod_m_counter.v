module mod_m_counter
	#(
	parameter N=4,
	parameter M=10
	)
	(
	input wire clk,reset,
	input wire [N-1:0] d,
	output wire [N-1:0] q,
	output wire max_tick
	);
	
	/* SIGNAL DECLARATIONS */
	reg [N-1:0] r_reg;
	wire [N-1:0] r_next;
	
	/*				 Body Begin			 */
	
	// Register
	always @ (posedge clk, posedge reset)
	begin
	if (reset)
		r_reg <= 0;
	else
		r_reg <= r_reg;
	end		
	// Next State Logic
	assign r_next = (r_reg == M-1) ? 0 : r_reg+1 ;
	
	
	// Output Logic
	assign q = r_reg;
	assign max_tick = (r_reg == M-1) ? 1'b1 : 1'b0;
	
	/*				 Body End			 */

endmodule
