module sign_mag_add
		#(	parameter N = 4 )
		(	input wire [N-1:0] a , b,
			output reg [N-1:0] sum	);
		
		// Signal Declaration ~
		
		reg [N-2:0] mag_a, mag_b, mag_sum, max, min;
		reg sgn_a, sgn_b, sgn_sum;
		
		always @*
		begin
		
			// Step 1: Separate Magnitude and Sign
			
			mag_a = a[N-2:0];
			mag_b = b[N-2:0];
			sgn_a = a[N-1];
			sgn_b = b[N-1];
			
			// Step 2: Sort according to magnitude
			
			if (mag_a > mag_b)
			begin
				max = mag_a;
				min = mag_b;
				sgn_sum = sgn_a;
			end
			else begin
				max = mag_b;
				min = mag_a;
				sgn_sum = sgn_b;
			end
			
			// Step 3: calculate sum magnitude
				mag_sum = (sgn_a == sgn_b) ? (max + min) : (max - min) ;
				
			// Step 4: Join output
				sum = {sgn_sum , mag_sum};
		
		end
endmodule