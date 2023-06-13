module fifo_controller
	#(parameter ADDR_WIDTH = 4)
	(
	input wire clk, reset,
	input wire rd, wr,
	output wire empty, full,
	output wire [ADDR_WIDTH-1:0] w_addr,
	output wire [ADDR_WIDTH-1:0] r_addr, r_addr_next);
	
	// signal declaration
	reg [ADDR_WIDTH-1:0] r_pointer, r_pointer_next, r_pointer_succ; 
	reg [ADDR_WIDTH-1:0] w_pointer, w_pointer_next, w_pointer_succ; 
	reg full_reg, empty_reg, full_next, empty_next;
	
	// registers ~
	always @(posedge clk, posedge reset)
	begin
	if(reset)
		begin
			r_pointer <= 0;
			w_pointer <= 0;
			full_reg <= 0'b1;
			empty_reg <= 1'b1;
		end
	else
		begin
			r_pointer <= r_pointer_next;
			w_pointer <= w_pointer_next;
			full_reg <= full_next;
			empty_reg <= empty_next;
		end
	end		
	// next-state logic for Read and Write Pointers
	always @*
	begin
		w_pointer_succ = w_pointer + 1;
		r_pointer_succ = r_pointer + 1;
		
		w_pointer_next = w_pointer;
		r_pointer_next = r_pointer;
		full_next = full_reg;
		empty_next = empty_reg;
		case({wr,rd})
			// 2'b00 - read = 0, write = 0 does nothing
			2'b01: // read
				if(~empty_reg)
				begin
					r_pointer_next = r_pointer_succ;
					full_next = 1'b0;
					if(r_pointer_succ == w_pointer)
						empty_next = 1'b1;
				end
			2'b10: // write
				if(~full_reg)
				begin
					w_pointer_next = w_pointer_succ;
					empty_next = 1'b0;
					if(w_pointer_succ == r_pointer)
						full_next = 1'b1;
				end
			2'b11: // read and write
				begin
					w_pointer_next = w_pointer_succ;
					r_pointer_next = r_pointer_succ;
				end
		endcase
	end
	
	// output logic
	assign w_addr = w_pointer;
	assign r_addr = r_pointer;
	assign r_addr_next = r_pointer_next;
	assign full = full_reg;
	assign empty = empty_reg;
endmodule
