/*

I have made a slightly different edge detector,
 Mealy, with 2 output bits that detects both rising edge and falling edge.

*/

module c6_e6_3_1_edgeDetector
			(
				input wire clk, reset,
				input wire in,
				output reg rising, falling
			);
			
// State Variable Definitions:
	localparam	sZero = 1'b0,
					sOne = 1'b1;
				
// Signal Declarations:
	reg state_reg, state_next;
				
// State Register
	always @ (posedge clk, posedge reset)
	begin
		if(reset)
			state_reg <= sZero;
		else
			state_reg <= state_next;
	end

// Next-State Register
	always @ *
	begin
		// Default values
		state_next = state_reg;
		rising = 1'b0;
		falling = 1'b0;
		
		// Case
	
		case(state_reg)
			sZero:
				begin
					if(in) begin
						rising = 1'b1;
						state_next = sOne;
					end
					else
						state_next = sZero;
				end
			sOne:
				begin
					if(in)
						state_next = sOne;
					else begin
						falling = 1'b1;
						state_next = sZero;
					end
				end
			default: state_next = sZero;
		endcase
	end
endmodule

