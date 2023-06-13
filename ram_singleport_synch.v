module ram_singleport_synch //  altera_one_port_ram_alternative Pg.125
	#(
	parameter DATA_WIDTH = 8,
	parameter ADDR_WIDTH = 10
	)
	(
	input wire clk,
	input wire we,
	input wire [DATA_WIDTH-1:0]d,
	input wire [ADDR_WIDTH-1:0] addr,
	output wire [DATA_WIDTH-1:0]q);
	
	/* Signals Declaration */
	reg [DATA_WIDTH-1:0] ram [2**ADDR_WIDTH-1:0];
	reg [DATA_WIDTH-1:0] data_reg;
	
	/* Body Beign */
	
	// Write Operation
	always @(posedge clk)
	begin
		if(we)
			ram[addr] <= d;
		data_reg <= ram[addr];
	end
	
	// Read operation
	assign q = data_reg;
	
	/* Body Beign */
	
endmodule
