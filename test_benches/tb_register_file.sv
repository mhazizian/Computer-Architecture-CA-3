`include "defines.sv"

module tb_register_file();
	
	logic clk = 1'b0, rst = 1'b0, reg_write_en = 1'b0;
	int read_reg1, read_reg2, write_reg;
	logic [7:0] write_data , read_data1, read_data2;
	
	register_file uut(
	clk, rst, write_reg, write_data,
	reg_write_en, read_reg1, read_reg2,
	read_data1, read_data2
	);

	initial repeat (100) #200 clk = ~clk;
	
	initial begin
		#400
			rst = 1'b1; 
		#200
			reg_write_en = 1'b1;
			rst = 1'b0;
			write_data = 8'b10101010;
			write_reg = 2;
		
		#800
			reg_write_en = 1'b0;
		#400
			write_reg = 3;
			write_data = 8'b11111111;
			reg_write_en = 1'b1;			
		#800
			reg_write_en = 1'b0;
		#400
			read_reg1 = 2;
		#800
			read_reg2 = 3;
		
	end

endmodule

