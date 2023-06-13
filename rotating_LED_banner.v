/*
	BCD5		BCD4		BCD3		BCD2		BCD1		BCD0	state combo
	0			1			2			3			4			5				0000
	1			2			3			4			5			6				0001
	2			3			4			5			6			7				0100
	3			4			5			6			7			8				0110
	4			5			6			7			8			9				0100
	5			6			7			8			9			0				0101
	6			7			8			9			0			1				0110
	7			8			9			0			1			2				0111
	8			9			0			1			2			3				1000
	9			0			1			2			3			4				1001
	0			1			2			3			4			5				0000
	
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

*/

module rotating_LED_banner
		(
		input wire clk, clr,
		input wire dir, en,
		output wire [7:0] bcd5,bcd4,bcd3,bcd2,bcd1,bcd0);

		// DECLARATIONS
		localparam dvsr = 50000000;
		reg [25:0] time_reg;
		reg [25:0] time_next;
		reg [3:0] state_reg;
		reg [3:0] state_next;
//		reg [7:0] bcd5_reg,bcd4_reg,bcd3_reg,bcd2_reg,bcd1_reg,bcd0_reg;
//		reg [7:0] bcd5_data,bcd4_data,bcd3_data,bcd2_data,bcd1_data,bcd0_data;

		// Register file
		always @ (posedge clk)
		begin
				time_reg <= time_next;
				state_reg <= state_next;
		end
		
		// Combinational part
		//assign time_next = (~clr || (time_reg == dvsr)) ? 25'b0 : time_reg+1;
		
		always @*
		begin
		if (en)
		begin
			time_next <= (~clr || (time_reg == dvsr)) ? 25'b0 : time_reg+1;
			 state_next <= (~clr || (dir && state_reg == 4'b1010)) ? 4'b0 : 
										(dir && time_reg == dvsr) ? state_reg+1 :
										(~dir && state_reg == 4'b1111) ? 4'b0 :
										(~dir && state_reg == 4'b0) ? 4'b1001 :
										(~dir && time_reg == dvsr) ? state_reg-1 :
										state_reg;
		end
		end
		
		assign bcd5 = (state_reg == 4'b0000) ? 8'b11000000:
							(state_reg == 4'b0001) ? 8'b11111001:
							(state_reg == 4'b0010) ? 8'b10100100:
							(state_reg == 4'b0011) ? 8'b10110000:
							(state_reg == 4'b0100) ? 8'b10011001:
							(state_reg == 4'b0101) ? 8'b10010010:
							(state_reg == 4'b0110) ? 8'b10000010:
							(state_reg == 4'b0111) ? 8'b11111000:
							(state_reg == 4'b1000) ? 8'b10000000:
							(state_reg == 4'b1001) ? 8'b10010000:
							8'b1111_1111;
							
		assign bcd4 = (state_reg == 4'b0000) ? 8'b11111001 : //1
							(state_reg == 4'b0001) ? 8'b10100100: //2
							(state_reg == 4'b0010) ? 8'b10110000:	//3
							(state_reg == 4'b0011) ? 8'b10011001:	//4
							(state_reg == 4'b0100) ? 8'b10010010:	//5
							(state_reg == 4'b0101) ? 8'b10000010: //6
							(state_reg == 4'b0110) ? 8'b11111000: //7
							(state_reg == 4'b0111) ? 8'b10000000: //8
							(state_reg == 4'b1000) ? 8'b10010000: //9
							(state_reg == 4'b1001) ? 8'b11000000: //0
							8'b1111_1111;

		assign bcd3 = (state_reg == 4'b0000) ? 8'b10100100:
							(state_reg == 4'b0001) ? 8'b10110000:
							(state_reg == 4'b0010) ? 8'b10011001:
							(state_reg == 4'b0011) ? 8'b10010010:
							(state_reg == 4'b0100) ? 8'b10000010:
							(state_reg == 4'b0101) ? 8'b11111000:
							(state_reg == 4'b0110) ? 8'b10000000:
							(state_reg == 4'b0111) ? 8'b10010000:
							(state_reg == 4'b1000) ? 8'b11000000:
							(state_reg == 4'b1001) ? 8'b11111001:
							8'b1111_1111;
							
		assign bcd2 = (state_reg == 4'b0000) ? 8'b10110000:
							(state_reg == 4'b0001) ? 8'b10011001:
							(state_reg == 4'b0010) ? 8'b10010010:
							(state_reg == 4'b0011) ? 8'b10000010:
							(state_reg == 4'b0100) ? 8'b11111000:
							(state_reg == 4'b0101) ? 8'b10000000:
							(state_reg == 4'b0110) ? 8'b10010000:
							(state_reg == 4'b0111) ? 8'b11000000:
							(state_reg == 4'b1000) ? 8'b11111001:
							(state_reg == 4'b1001) ? 8'b10100100:
							8'b1111_1111;
							
							
		assign bcd1 = (state_reg == 4'b0000) ? 8'b10011001:
							(state_reg == 4'b0001) ? 8'b10010010:
							(state_reg == 4'b0010) ? 8'b10000010:
							(state_reg == 4'b0011) ? 8'b11111000:
							(state_reg == 4'b0100) ? 8'b10000000:
							(state_reg == 4'b0101) ? 8'b10010000:
							(state_reg == 4'b0110) ? 8'b11000000:
							(state_reg == 4'b0111) ? 8'b11111001:
							(state_reg == 4'b1000) ? 8'b10100100:
							(state_reg == 4'b1001) ? 8'b10110000:
							8'b1111_1111;
							
		assign bcd0 = (state_reg == 4'b0000) ? 8'b10010010:
							(state_reg == 4'b0001) ? 8'b10000010:
							(state_reg == 4'b0010) ? 8'b11111000:
							(state_reg == 4'b0011) ? 8'b10000000:
							(state_reg == 4'b0100) ? 8'b10010000:
							(state_reg == 4'b0101) ? 8'b11000000:
							(state_reg == 4'b0110) ? 8'b11111001:
							(state_reg == 4'b0111) ? 8'b10100100:
							(state_reg == 4'b1000) ? 8'b10110000:
							(state_reg == 4'b1001) ? 8'b10011001:
							8'b1111_1111;

endmodule

