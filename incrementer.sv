module incrementer_13(num, q);

	input [12:0]num;
	output logic[12:0]q;

	assign q = num + 1;
	
endmodule
