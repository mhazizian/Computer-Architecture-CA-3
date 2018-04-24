module memory(rst, address, command);

	input [12:0] address;
	input rst;
	output logic[7:0] command;

	reg[7:0] command_memory[0:8191];

	always @(posedge rst) begin
		command_memory <= '{default : 8'b0};
	end
	
	always @(address) begin
		command <= command_memory[address];
	end

endmodule