/*
	Embedded SoPC Design with Nios II Processor and Verilog Examples
								Excercise 5.9.3 Pg.133
	Rotating Square circuit
								Solution by Oriod Malo (02 June 2023)
								
	Notes: The original text suggests the excercise using a DE1 board which
	has 4 7-Segment BCDs, while this solution is for DE10 Lite Which has 6 7-Segment BCDs
	controlled by 8 bits - 7 for the bcd 1 for the dot. 1 is off 0 is on.
	8b'.gfedcba
	
	upper square 8'b10011100 (dot off)
	lower square 8'b10100011 (dot on)
*/

module rotatingSquare_de10lite
	(
		input wire clk, clr,
		output wire [7:0] bcd0,bcd1,bcd2,bcd3,bcd4,bcd5
	);


		// DECLARATIONS BEGIN:
		localparam dvsr = 12500000;
		reg [23:0] time_reg;
		wire [23:0] time_next;
		reg [3:0] state_reg;
		wire [3:0] state_next;
		
		// Register file
		always @ (posedge clk)
		begin
				time_reg <= time_next;
				state_reg <= state_next;
		end
		
		// Combinational part
		assign time_next = (~clr || (time_reg == dvsr)) ? 23'b0 : time_reg+1;
		
		assign state_next = (~clr || state_reg == 4'b1100) ? 4'b0 : 
									(time_reg == dvsr) ? state_reg+1 :
									state_reg;
		
		// Outputs
		assign bcd5 = (state_reg == 4'b0000) ? 8'b10011100 :
							(state_reg == 4'b1011) ? 8'b10100011 :
							8'b1111_1111;
		
		assign bcd4 = (state_reg == 4'b0001) ? 8'b10011100 :
							(state_reg == 4'b1010) ? 8'b10100011 :
							8'b1111_1111;
							
		assign bcd3 = (state_reg == 4'b0010) ? 8'b10011100 :
							(state_reg == 4'b1001) ? 8'b10100011 :
							8'b1111_1111;
							
		assign bcd2 = (state_reg == 4'b0011) ? 8'b10011100 :
							(state_reg == 4'b1000) ? 8'b10100011 :
							8'b1111_1111;
							
		assign bcd1 = (state_reg == 4'b0100) ? 8'b10011100 :
							(state_reg == 4'b0111) ? 8'b10100011 :
							8'b1111_1111;
							
		assign bcd0 = (state_reg == 4'b0101) ? 8'b10011100 :
							(state_reg == 4'b0110) ? 8'b10100011 :
							8'b1111_1111;

endmodule
