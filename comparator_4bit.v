module comparator4bit(
		Data_in_A,
		Data_in_B,
		less,
		equal,
		greater);
		
		input [3:0] Data_in_A;
		input [3:0] Data_in_B;
		output less;
		output equal;
		output greater;
		
		reg less, equal, greater;
		
		always @ (Data_in_A, Data_in_B)
		begin
			if(Data_in_A > Data_in_B) begin
				less = 0;
				equal = 0;
				greater = 1; end
			else if (Data_in_A == Data_in_B) begin
				less = 0;
				equal = 1;
				greater = 0; end
			else			begin
				less = 1;
				equal = 0;
				greater = 0;	end
	end
endmodule