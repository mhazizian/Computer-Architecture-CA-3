`include "defines.sv"

module register_file(
	clk, rst, write_reg, write_data,
	write_reg_en, read_reg1,
	read_data1, read_data2
	);

	input clk, rst, write_reg_en;
	input [1:0] read_reg1, write_reg;
	input [7:0] write_data;
	output logic [7:0] read_data1, read_data2;
	
	reg[7:0] acc[0:3];	
	logic[3:0] ld_reg;	
	int j;
	genvar i;
	
// Generate 4 regsiters
	
	generate for (i = 0; i < 4; i = i + 1)
		begin
			register #(.WORD_LENGTH(8)) registers(.clk(clk), .rst(rst), .ld(ld_reg[i]), .in(write_data), .out(acc[i]));
		end
	endgenerate

// Read registers on posedge of clock
	
	always @(posedge clk) begin
		read_data1 = acc[read_reg1];
		read_data2 = acc[write_reg];
	end

// Write regsiter on posedge of clock
	
	always @(posedge clk) begin
		for ( j = 0; j < 4; j = j + 1)	ld_reg[j] = 1'b0;
		if (write_reg_en)	ld_reg[write_reg] = 1'b1;
	end
	
// Reset load signals
	
	always@(posedge rst)
	begin
		for ( j = 0; j < 4; j = j + 1)	ld_reg[j] = 1'b0;
	end
	
endmodule