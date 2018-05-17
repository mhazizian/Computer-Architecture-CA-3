module memory(rst, address, command, write_data, mem_read, mem_write);

	input [12:0] address;
	input [7:0] write_data;
	input  mem_read, mem_write;
	input rst;
	output logic[7:0] command;
	
	reg[7:0] command_memory[0:8191];

	always @(address, mem_write)	begin
		if (mem_write)
			command_memory[address] <= write_data;
	end
	
	always @(posedge rst) begin
		command_memory 		<= '{default : 8'b0};
/*
		command_memory 		<= '{default : 8'b0};
		command_memory[0] 	<=	{3'b111, 2'b11, 2'b00, 1'b1}; 	// LDI {OPCODE, ADDRESS_OP, JUMP_OP, DONT_CARE}
		command_memory[1]	<= 	{4'b1000, 2'b10, 2'b00};		// MVR {OPCODE, DEST, SRC}
		command_memory[2]	<=	{4'b1011, 2'b11, 2'b00};		// ORR {OPCODE, DEST, SRC}
		command_memory[3]	<=	{3'b110, 5'b0};					// JMP {OPCODE, ADR[12:8]} // ADR = 10
		command_memory[4]	<=	{8'b00001010};					// JMP {OPCODE, ADR[7:0]}
		command_memory[10]	<=	{4'b1001, 2'b11, 2'b10};		// ADR {OPCODE, DEST, SRC}
		
		command_memory[11]	<=	{3'b000, 5'b0};					// LDA {OPCODE, ADR[12:8]}
		command_memory[12]	<=	{8'b01111111};					// LDA {OPCODE, ADR[7:0]} // ADR = 127
		
//		command_memory[13]	<=	{3'b001, 5'b0};					// STA {OPCODE, ADR[12:8]}
//		command_memory[14]	<=	{8'b11111111};					// STA {OPCODE, ADR[7:0]} // ADR = 255
		
		command_memory[13]	<=	{8'b11100111};					// STA {OPCODE, ADR[12:8]}
		command_memory[14]	<=	{8'b11111111};					// STA {OPCODE, ADR[7:0]} // ADR = 255

	
		command_memory[127] <= 	8'b10101010;					// DATA
*/	


		command_memory[0] 	<=	{3'b111, 2'b11, 2'b00, 1'b1}; 	// LDI {OPCODE, ADDRESS_OP, JUMP_OP, DONT_CARE}
		
		command_memory[1]	<=	{3'b000, 5'b0};					// LDA {OPCODE, ADR[12:8]}
		command_memory[2]	<=	{8'b01111111};					// LDA {OPCODE, ADR[7:0]} // ADR = 127
		
//		command_memory[13]	<=	{3'b001, 5'b0};					// STA {OPCODE, ADR[12:8]}
//		command_memory[14]	<=	{8'b11111111};					// STA {OPCODE, ADR[7:0]} // ADR = 255
		
		command_memory[3]	<=	{3'b001, 5'b0};					// STA {OPCODE, ADR[12:8]}
		command_memory[4]	<=	{8'b11111111};					// STA {OPCODE, ADR[7:0]} // ADR = 255
	
		command_memory[5]	<=	{3'b011, 5'b0};					// ADA {OPCODE, ADR[12:8]}
		command_memory[6]	<=	{8'b11111111};	 				// ADA {OPCODE, ADR[7:0]} // ADR = 255 // R[3] = 14
		
//		command_memory[5]	<=	{3'b010, 5'b0};					// ADA {OPCODE, ADR[12:8]}
//		command_memory[6]	<=	{8'b11111111};	 				// ADA {OPCODE, ADR[7:0]} // ADR = 255 // R[3] = 60
	
		command_memory[127] <= 	8'b00011110;					// DATA

	end
	
	always @(address, mem_read) begin
		if (mem_read)
			command <= command_memory[address];
	end

endmodule