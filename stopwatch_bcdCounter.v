module stopwatch_bcdCounter
	(
	input wire clk,
	input wire go, clr,
	output wire [3:0] d2,d1,d0
	);

	// Declarations Begin
	localparam DVSR = 5000000;
	reg [22:0] ms_reg;
	wire [22:0] ms_next;
	reg [3:0] d2_reg, d1_reg, d0_reg;
	reg [3:0] d2_next, d1_next, d0_next;
	wire ms_tick;
	
	// Register
	always @ (posedge clk)
	begin
		ms_reg <= ms_next;
		d2_reg <= d2_next;
		d1_reg <= d1_next;
		d0_reg <= d0_next;
	end		
	// Next-State Logic
	
	assign ms_next = (clr || (ms_reg==DVSR && go)) ? 4'b0 :
							(go) ? ms_reg <= ms_reg + 1 :
												ms_reg;
	
	assign ms_tick = (ms_reg == DVSR) ? 1'b1 : 1'b0;
	
	// 3-digit bcd counter
	always @ *
	begin
			// DEFAULT CASE
		d0_next = d0_reg;
		d1_next = d1_reg;
		d2_next = d2_reg;
		if(clr)
		begin
			d0_next = 4'b0;
			d1_next = 4'b0;
			d2_next = 4'b0;
		end
		else
		if (ms_tick)
			if (d0_reg != 9)
				d0_next = d0_reg + 1;
			else // which means if d0_reg = 9 so we have X X 9
			begin
				d0_next = 4'b0;
				if(d1_reg != 9)
					d1_next = d1_reg +1;
				else // which means d1_reg = 9 so we are in the situation x 9 9
				begin
					d1_next = 4'b0;
					if(d2_reg != 9)
						d2_next = d2_reg + 1;
					else // Which means we are in the 9 9 9 situation
						d2_next = 4'b0;
			end
		end
	end
	
	// Output
	
	

endmodule
