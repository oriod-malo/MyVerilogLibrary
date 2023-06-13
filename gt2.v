module gt2
	(
	input wire [1:0] a, b,
	output wire result
	);
	
	// internal signal declarations
	wire term0, term1;
	
	/* Body
		calculate the two partial terms and then their sum as output */

	assign term1 = a[1] & !(b[1]);
	assign term2 = !(a[1]) & a[0] & !(b[1]) & !(b[0]);
	assign term3 = a[1] & a[0] & b[1] & !(b[0]);
	
	// Calculate result
	
	assign result = term1 | term2 | term3;

endmodule
