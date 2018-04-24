// 13 bit for TR, 8 bit for IR, 5 bit for DI, 8 bit for acc, 8 bit for ALU_out

module register #(parameter integer WORD_LENGTH) (clk, rst, ld, in, out);

	input clk, rst, ld;
	input[WORD_LENGTH - 1:0] in;
	output logic[WORD_LENGTH - 1:0] out;
 
	always@(posedge clk, posedge rst) 
	begin
		if (ld) out <= in;
		if (rst) out <= 0;
	end
	
endmodule

// PC register

module pc_register (clk, rst, ld, cen, in, out);

	input clk, rst, ld, cen;
	input[12:0] in;
	output logic [12:0] out;
	
	always@(posedge clk, posedge rst)
	begin
		if(cen) out <= out + 1;
		if(ld) 	out <= in;
		if(rst)	out <= 13'b0;
	end
	
endmodule