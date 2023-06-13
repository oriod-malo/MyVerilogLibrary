module ram_dualport_synch //"altera_dual_port_ram_true" from pg.128
	#(parameter DATA_WIDTH = 8,
	parameter ADDR_WIDTH = 10)
	(
	input wire clk,
	input wire we_a, we_b,
	input wire [DATA_WIDTH-1:0] d_a, d_b,
	input wire [ADDR_WIDTH-1:0] addr_a,addr_b,
	output wire [DATA_WIDTH-1:0] q_a, q_b);
	
	/* Signal Declarations */
	reg [DATA_WIDTH-1:0] ram [2**ADDR_WIDTH-1:0];
	reg [DATA_WIDTH-1:0] data_reg_a, data_reg_b;
	
	/* Body Begin*/
	
	// Write Process for "Port A"
	always @ (posedge clk)
	begin
		if(we_a)
			begin
				ram[addr_a] <= d_a;
				data_reg_a <= d_a;
			end
		else
		data_reg_a <= ram[addr_a];
	end
	
	// Write Process for "Port B"
	always @ (posedge clk)
	begin
		if(we_b)
			begin
				ram[addr_b] <= d_b;
				data_reg_b <= d_b;
			end
		else
			data_reg_b <= ram[addr_b];
	end
	
	// Read process for both ports
	
	assign q_a = data_reg_a; // read process for port A
	assign q_b = data_reg_b; // read process for port B
	
	/* Body End*/
	

endmodule
