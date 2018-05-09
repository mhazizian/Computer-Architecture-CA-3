module memory(rst, address, command, write_data);

	input [12:0] address;
	input [7:0] write_data;
	input rst;
	output logic[7:0] command;
	
	reg[7:0] command_memory[0:8191];

	always @(*)	begin
		command_memory[address] <= write_data;
	end
	
	always @(posedge rst) begin
		command_memory <= '{default : 8'b0};
	end
	
	always @(address) begin
		command <= command_memory[address];
	end

endmodule