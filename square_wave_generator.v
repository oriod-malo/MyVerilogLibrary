/*
	Embedded SoPC Design with Nios II Processor and Verilog Examples
								Excercise 5.9.1 Pg.132-133
	Square Wave Generator
								Solution by Oriod Malo (01 June 2023)
								
	Notes: The excercise assumes the 50MHz frequency of Altera FPGAs
	therefore the requirement for m*100ns HIGH and n*100ns LOW on the output waveform
	can be also imagined as m*5*20ns and n*5*20ns.
*/

module square_wave_generator
		(
		input wire clk, clr,					// Has to be initialized by clr=1 for the first cycle
		input wire [3:0] m, n,				// max that n can be is 1111=15
		output wire waveform);

		// signal declarations
		reg [6:0] m_reg, n_reg, m_next, n_next;
		reg [6:0] mMax, nMax; // 11 = 15*5 = 75 = 7'b1001011 requires 7 bits
		reg cycle_reg, cycle_next;
		reg waveform_reg, waveform_next;
		
		// Register
		
		always @(posedge clk, posedge clr)
		begin
		if(clr)
			begin
				m_next <= 7'b0;
				n_next <= 7'b0;
				cycle_next <= 0;
				waveform_next <= 0;
			end
		else
			begin
			m_reg <= m_next;
			n_reg <= n_next;
			cycle_reg <= cycle_next;
			waveform_reg <= waveform_next;
			end
		end

		// Next State logic
		always @*
		begin	
			// Default values
			mMax = m*5;
			nMax = n*5;

			
			if(cycle_reg && m_reg!=mMax-1)
				begin
					m_next = m_reg+1;
					waveform_next = 1'b1;
				end
			else if (cycle_reg && m_reg==mMax-1)
				begin
					m_next = 7'b0;
					cycle_next = 1'b0;
				end
			else if(~cycle_reg && n_reg!=nMax-1)
				begin
					n_next = n_reg+1;
					waveform_next = 1'b0;
				end
			else if (~cycle_reg && n_reg==nMax-1)
				begin
					n_next = 7'b0;
					cycle_next = 1'b1;
				end
			else cycle_next = 1'b1;
		end
		
			
		assign waveform = waveform_reg;
endmodule
