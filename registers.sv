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

//  TR register

module tr_register (clk, rst, ld_8, ld_5, in_8, in_5, out);

	input clk, rst, ld_8, ld_5;
	input [7:0] in_8;
	input [4:0] in_5;
	output logic [12:0] out;
	
	always@(posedge clk, posedge rst)
	begin
		if(ld_8) 	out[7:0] 	<= in_8;
		if(ld_5) 	out[12:8] 	<= in_5;
		if(rst)		out 		<= 13'b0;
	end
	
endmodule