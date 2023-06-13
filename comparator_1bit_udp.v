primitive comparator_1bit_udp(eq, i0, i1);
	
	/* The inputs must be declared in the same order 
	as the one they will be used in the table */
 	input i0, i1;
	
	// The output
	output eq;
	
	// The Table
	table
			0	0	:	1;
			0	1	:	0;
			1	0	:	0;
			1	1	:	1;
	endtable

endprimitive