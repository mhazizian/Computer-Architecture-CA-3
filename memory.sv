module memory(rst, address, command, write_data, mem_read, mem_writer);

	input [12:0] address;
	input [7:0] write_data;
	input  mem_read, mem_writer;
	input rst;
	output logic[7:0] command;
	
	reg[7:0] command_memory[0:8191];

	always @(*)	begin
		if (write_data)
			command_memory[address] <= write_data;
	end
	
	always @(posedge rst) begin
		command_memory <= '{default : 8'b0};
	end
	
	always @(address) begin
		if (mem_read)
			command <= command_memory[address];
	end

endmodule