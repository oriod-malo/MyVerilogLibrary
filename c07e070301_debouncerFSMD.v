module c07e070301_debouncerFSMD
			(
				input wire clk, reset,
				input wire sw,
				output reg db_tick, db_level
			);
			
		// State Encoding
		
		localparam 	s_Zero = 2'b00,
						s_Wait0 = 2'b01,
						s_One = 2'b10,
						s_Wait1 = 2'b11;
		
		// Parameter Declaration
		
		localparam N = 21;
		
		// Signal Declarations
		reg [1:0] state_reg, state_next;
		reg [N-1:0] count_reg, count_next;
		
		/*---------------------------------	BODY -------------------------*/
		
		// Registers update
		always @ (posedge clk, posedge reset)
		begin
			if(reset)
				begin
					state_reg <= s_Zero;
					count_reg <= 0;
				end
			else
				begin
					state_reg <= state_next;
					count_reg <= count_next;
				end
		end
		
		// Next State Logic
		always @*
		begin
			// default values
			state_next = state_reg;
			count_next = count_reg;
			db_tick = 1'b0;
			
			case(state_reg)
				s_Zero:
					begin
						db_level = 1'b0;
					if(sw)
						begin
							state_next = s_Wait0;
							count_next = {N{1'b1}};
						end
					end
				s_Wait0:
					begin
						db_level = 1'b0;
					if(sw)
						begin
							count_next = count_reg - 1;
							if(count_next==0)
								begin
									state_next = s_One;
									db_tick = 1;
								end
						end
					else
						state_next = s_Zero;

					end
				s_One:
					begin
						db_level = 1'b0;
					if(~sw)
						begin
							state_next = s_Wait1;
							count_next = {N{1'b1}};
						end
					end
				s_Wait1:
					begin
						db_level = 1'b0;
					if(~sw)
						begin
							count_next = count_reg - 1;
							if(count_next == 0)
								state_next = s_Zero;
						end
					else
						state_next = s_One;
					end
			endcase
		end
endmodule
