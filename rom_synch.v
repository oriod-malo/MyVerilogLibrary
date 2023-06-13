module rom_synch //altera_sync_rom_case template from page 129
		#(parameter DATA_WIDTH=8) // for a 7-segment BCD in DE-10 lite, where MSB is the DOT (off)
		(
		input clk,
		input wire [3:0] addr,
		output wire [DATA_WIDTH-1:0] data);
		
		/* Signal Declarations */
		reg [DATA_WIDTH-1:0] data_reg, rom_data;
		
		/* Body Begin */
		
		// Synchronous statement
		always @ (posedge clk)
		begin
			data_reg <= rom_data; // save the value of the "read" data each Posedge of the Clock
		end 
		
		// "Reading" the content of the ROM with a Case, dot off
		always @*
		case(addr)
			4'h0: rom_data = 8'b11000000 ;
			4'h1: rom_data = 8'b11111001 ;
			4'h2: rom_data = 8'b10100100 ;
			4'h3: rom_data = 8'b10110000 ;
			4'h4: rom_data = 8'b10011001 ;
			4'h5: rom_data = 8'b10010010 ;
			4'h6: rom_data = 8'b10000010 ;
			4'h7: rom_data = 8'b11111000 ;
			4'h8: rom_data = 8'b10000000 ;
			4'h9: rom_data = 8'b10010000 ;
			4'ha: rom_data = 8'b10001000 ;
			4'hb: rom_data = 8'b10000011 ;
			4'hc: rom_data = 8'b11000110 ;
			4'hd: rom_data = 8'b10100001 ;
			4'he: rom_data = 8'b10000110 ;
			4'hf: rom_data = 8'b10001110 ;
		endcase

		// Assing the read value to the output
		assign data = data_reg;
		/* Body End */

endmodule
