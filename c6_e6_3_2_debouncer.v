module c6_e6_3_2_debouncer
			(
			input wire clk, reset,
			input wire in,
			output reg out
			);
			
// State Variable Definitions
localparam	[2:0] sZero = 3'b000,
						sC01_1 = 3'b001,
						sC01_2 = 3'b010,
						sC01_3 = 3'b011,
						sOne = 3'b111,
						sC10_1 = 3'b110,
						sC10_2 = 3'b100,
						sC10_3 = 3'b101;

// Other Definitions
	localparam ms_time = 500000; // ideally more
	reg [18:0] time_reg;
	wire [18:0] time_next;
	reg [2:0] state_reg, state_next;
	reg ms_tick;
	

// Time Counter assignments
	//always @ (posedge clk)
	//	time_reg <= time_next;
		
	//assign time_next = time_reg + 1;
	//assign ms_tick = (time_reg == ms_time) ? 1'b1 : 1'b0;
	
	
	
// State Register
	always @ *
	begin
		if(reset)
			begin
				state_reg <= sZero;
				time_reg <= 19'b0;
			end
		else
			begin
				state_reg <= state_next;
				time_reg <= time_next;
				if(time_reg == ms_time)
					begin
						ms_tick <= 1'b1;
					end
				else
					ms_tick <= 1'b0;
			end
	end
	
	//assign time_next = time_reg + 1;
//assign ms_tick = (time_reg == ms_time) ? 1'b1 : 1'b0;
	

// Next-State Logic
	always @*
	begin
		// Default states
		state_next = state_reg;
		out = 1'b0;

		case(state_reg)
			sZero:
				begin
					out = 1'b0;
						if(~in)
							state_next = sZero;
						else
							if(ms_tick)
								state_next = sC01_1;
					end
			sC01_1:
				begin
					out = 1'b0;
						if(~in)
							state_next = sZero;
						else
							if(ms_tick)
								state_next = sC01_2;
					end
			sC01_2:
				begin
					out = 1'b0;
						if(~in)
							state_next = sZero;
						else
							if(ms_tick)
								state_next = sC01_3;
					end
			sC01_3:
				begin
					out = 1'b0;
						if(~in)
							state_next = sZero;
						else
							if(ms_tick)
								state_next = sOne;
					end
			sOne:
				begin
					out = 1'b1;
						if(in)
							state_next = sOne;
						else
							if(ms_tick)
								state_next = sC10_1;
					end
			sC10_1:
				begin
					out = 1'b1;
						if(in)
							state_next = sOne;
						else
							if(ms_tick)
								state_next = sC10_2;
					end
			sC10_2:
				begin
					out = 1'b1;
						if(in)
							state_next = sOne;
						else
							if(ms_tick)
								state_next = sC10_3;
					end
			sC10_3:
				begin
					out = 1'b1;
						if(in)
							state_next = sOne;
						else
							if(ms_tick)
								state_next = sZero;
					end
			default: state_next = sZero;
		endcase
	end
// Output


endmodule
