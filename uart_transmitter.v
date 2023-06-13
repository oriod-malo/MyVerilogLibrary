/*
		UART Transmitter
		
		i_DATA for testing 11011011
*/

module uart_transmitter
	#( parameter DATA_WIDTH = 8) // 1 start bit, 1 stop bit, 8 data bits
	(
		input wire clk, reset,
		input wire [DATA_WIDTH-1:0] i_DATA,
		input reg tx_start,
		output reg o_DATA,
		output reg tx_end
	);

	// State Declarations : 4 states 4 bits:
	localparam [1:0]	s_IDLE = 2'b00,
							s_START = 2'b01,
							s_TRANS = 2'b11,
							s_STOP = 2'b10;
	
	// Other Declarations
	reg [1:0] state_reg, state_next;
	reg [DATA_WIDTH-1:0] internal_reg;
	reg [2:0] count_reg,count_next;
	
	always @ (posedge clk, posedge reset)
	begin
		if(reset)
			state_reg <= s_IDLE;
		else
			state_reg <= state_next;
			count_reg <= count_next;
	end

	always @ * //(posedge clk, tx_start, i_DATA, state_reg)
	begin
		state_next = state_reg;
		
		// Case Statement on States
		case(state_reg)
				s_IDLE:
					begin
					o_DATA = 1'b1;
					tx_end = 1'b0;
					count_next = 4'b0;
						if(tx_start)
							state_next = s_START;
				end
				s_START:
					begin
					o_DATA = 1'b0;
					internal_reg = i_DATA;
					state_next = s_TRANS;
				end
				s_TRANS:
					begin
						o_DATA = internal_reg[0]; // Trannsmits LSB
						internal_reg = {1'b0 , internal_reg[DATA_WIDTH-1:1]}; // LSB
						count_next = count_reg + 1;
						state_next = (count_reg==3'b111) ? s_STOP : s_TRANS;
				end
				s_STOP:
					begin
						o_DATA = 1'b0;
						tx_end = 1;
						state_next = s_IDLE;
				end
		endcase
		end
		
endmodule
