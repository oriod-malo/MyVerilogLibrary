`timescale 1ns/ 10ps

module gt2_testbench;
	reg [1:0] test_a, test_b;
	wire test_out;
	
	/* Instantiate the Circuit Under Test */
	gt2 cut(.a(test_a), .b(test_b), .result(test_out));
	
	// Test Vector Generation
	initial
	begin
		// Test Vector 
		test_a = 2'b00;
		test_b = 2'b00;
		# 200;
		$display("IN: %b%b\t OUT:%b\t",test_a,test_b,test_out);
		// Test Vector 
		test_a = 2'b00;
		test_b = 2'b01;
		# 200;
		$display("IN: %b%b\t OUT:%b\t",test_a,test_b,test_out);
		// Test Vector 
		test_a = 2'b00;
		test_b = 2'b10;
		# 200;
		$display("IN: %b%b\t OUT:%b\t",test_a,test_b,test_out);
		// Test Vector 
		test_a = 2'b00;
		test_b = 2'b11;
		# 200;
		$display("IN: %b%b\t OUT:%b\t",test_a,test_b,test_out);
		
		// Test Vector 
		test_a = 2'b01;
		test_b = 2'b00;
		# 200;
		$display("IN: %b%b\t OUT:%b\t",test_a,test_b,test_out);
		// Test Vector		
		test_a = 2'b01;
		test_b = 2'b01;
		# 200;
		$display("IN: %b%b\t OUT:%b\t",test_a,test_b,test_out);
		// Test Vector 
		test_a = 2'b01;
		test_b = 2'b10;
		# 200;
		$display("IN: %b%b\t OUT:%b\t",test_a,test_b,test_out);
		// Test Vector 
		test_a = 2'b01;
		test_b = 2'b11;
		# 200;
		$display("IN: %b%b\t OUT:%b\t",test_a,test_b,test_out);
		
		
		// Test Vector 
		test_a = 2'b10;
		test_b = 2'b00;
		# 200;
		$display("IN: %b%b\t OUT:%b\t",test_a,test_b,test_out);
		// Test Vector 
		test_a = 2'b10;
		test_b = 2'b01;
		# 200;
		$display("IN: %b%b\t OUT:%b\t",test_a,test_b,test_out);
		// Test Vector 
		test_a = 2'b10;
		test_b = 2'b10;
		# 200;
		$display("IN: %b%b\t OUT:%b\t",test_a,test_b,test_out);
		// Test Vector 
		test_a = 2'b10;
		test_b = 2'b11;
		# 200;
		$display("IN: %b%b\t OUT:%b\t",test_a,test_b,test_out);
		
		// Test Vector 
		test_a = 2'b11;
		test_b = 2'b00;
		# 200;
		$display("IN: %b%b\t OUT:%b\t",test_a,test_b,test_out);
		// Test Vector 
		test_a = 2'b11;
		test_b = 2'b01;
		# 200;
		$display("IN: %b%b\t OUT:%b\t",test_a,test_b,test_out);
		// Test Vector 
		test_a = 2'b11;
		test_b = 2'b10;
		# 200;
		$display("IN: %b%b\t OUT:%b\t",test_a,test_b,test_out);
		// Test Vector 
		test_a = 2'b11;
		test_b = 2'b11;
		# 200;
		$display("IN: %b%b\t OUT:%b\t",test_a,test_b,test_out);
		$stop;
	end
endmodule
