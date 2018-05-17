`include "defines.sv"

module register_file(
	clk, rst, write_reg, write_data,
	write_reg_en, read_reg1, read_reg2,
	read_data1, read_data2, CZN_from_RF
	);

	input clk, rst, write_reg_en;
	input [1:0] read_reg1, read_reg2, write_reg;
	input [7:0] write_data;
	output logic [7:0] read_data1, read_data2;
	output logic [2:0] CZN_from_RF;
	
	reg[7:0] acc[0:3];	
	logic[3:0] ld_reg;	
	int j;
	genvar i;
	
//	Set CZN flags

	assign CZN_from_RF[0] = 0;
	assign CZN_from_RF[1] = (write_data == 8'b0 ? 1 : 0);
	assign CZN_from_RF[2] = (write_data < 0);
	
// Generate 4 regsiters
	
//	register #(.WORD_LENGTH(8)) TEST(.clk(clk), .rst(rst), .ld(1'b1), .in(8'd7), .out(acc[0]));
	
	generate for (i = 0; i < 4; i = i + 1)
		begin
			register #(.WORD_LENGTH(8)) registers(.clk(clk), .rst(rst), .ld(ld_reg[i]), .in(write_data), .out(acc[i]));
		end
	endgenerate

// Read registers on posedge of clock
	
	always @(posedge clk) begin
		read_data1 = acc[read_reg1];
		read_data2 = acc[read_reg2];
	end

// Write regsiter on posedge of clock
	
	always @(posedge clk, write_reg_en, write_reg) begin
		for ( j = 0; j < 4; j = j + 1)	ld_reg[j] = 1'b0;
		if (write_reg_en)	ld_reg[write_reg] = 1'b1;
	end
	
// Reset load signals
	
	always@(posedge rst)
	begin
		for ( j = 0; j < 4; j = j + 1)	ld_reg[j] = 1'b0;
	end
	
endmodule