module tb_memory();

	logic [12:0] address = 10;
	logic [7:0] write_data = 8'b10101010;
	logic rst = 1'b1;
	logic[7:0] command;

	memory uut(rst, address, command, write_data);
	
	initial #1000 $stop;
	
	initial begin
		#200
		rst = 1'b0;
		#200
		address = 11;
		
	end
	
endmodule