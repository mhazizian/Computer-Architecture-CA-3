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


		command_memory[0] 	<=	{3'b111, 2'b00, 2'b00, 1'b1}; 	// LDI {OPCODE, ADDRESS_OP, JUMP_OP, DONT_CARE}

		command_memory[1]	<=	{3'b000, 5'b00011};				// LDA {OPCODE, ADR[12:8]}
		command_memory[2]	<=	{8'b11101000};					// LDA {OPCODE, ADR[7:0]} // ADR = 1000

		// sec num
		command_memory[3]	<=	{3'b010, 5'b00011};				// ADA {OPCODE, ADR[12:8]}
		command_memory[4]	<=	{8'b11101001};					// ADA {OPCODE, ADR[7:0]} // ADR = 1001

		command_memory[5]	<=	{4'b1001, 2'b01, 2'b00};		// ADR {OPCODE, DEST, SRC}


		// third num
		command_memory[6]	<=	{3'b010, 5'b00011};				// ADA {OPCODE, ADR[12:8]}
		command_memory[7]	<=	{8'b11101010};					// ADA {OPCODE, ADR[7:0]} // ADR = 1002

		command_memory[8]	<=	{4'b1001, 2'b01, 2'b00};		// ADR {OPCODE, DEST, SRC}


		// 4th num
		command_memory[9]	<=	{3'b010, 5'b00011};				// ADA {OPCODE, ADR[12:8]}
		command_memory[10]	<=	{8'b11101011};					// ADA {OPCODE, ADR[7:0]} // ADR = 1003

		command_memory[11]	<=	{4'b1001, 2'b01, 2'b00};		// ADR {OPCODE, DEST, SRC}


		// 5th num
		command_memory[12]	<=	{3'b010, 5'b00011};				// ADA {OPCODE, ADR[12:8]}
		command_memory[13]	<=	{8'b11101100};					// ADA {OPCODE, ADR[7:0]} // ADR = 1004

		command_memory[14]	<=	{4'b1001, 2'b01, 2'b00};		// ADR {OPCODE, DEST, SRC}


		// 6th num
		command_memory[15]	<=	{3'b010, 5'b00011};				// ADA {OPCODE, ADR[12:8]}
		command_memory[16]	<=	{8'b1110111};					// ADA {OPCODE, ADR[7:0]} // ADR = 1005

		command_memory[17]	<=	{4'b1001, 2'b01, 2'b00};		// ADR {OPCODE, DEST, SRC}


		// 7th num
		command_memory[18]	<=	{3'b010, 5'b00011};				// ADA {OPCODE, ADR[12:8]}
		command_memory[19]	<=	{8'b11101110};					// ADA {OPCODE, ADR[7:0]} // ADR = 1006

		command_memory[20]	<=	{4'b1001, 2'b01, 2'b00};		// ADR {OPCODE, DEST, SRC}


		// 8th num
		command_memory[21]	<=	{3'b010, 5'b00011};				// ADA {OPCODE, ADR[12:8]}
		command_memory[22]	<=	{8'b11101111};					// ADA {OPCODE, ADR[7:0]} // ADR = 1007

		command_memory[23]	<=	{4'b1001, 2'b01, 2'b00};		// ADR {OPCODE, DEST, SRC}


		// 9th num
		command_memory[24]	<=	{3'b010, 5'b00011};				// ADA {OPCODE, ADR[12:8]}
		command_memory[25]	<=	{8'b11110000};					// ADA {OPCODE, ADR[7:0]} // ADR = 1008

		command_memory[26]	<=	{4'b1001, 2'b01, 2'b00};		// ADR {OPCODE, DEST, SRC}


		// 10th num
		command_memory[27]	<=	{3'b010, 5'b00011};				// ADA {OPCODE, ADR[12:8]}
		command_memory[28]	<=	{8'b11110001};					// ADA {OPCODE, ADR[7:0]} // ADR = 1009

		command_memory[29]	<=	{4'b1001, 2'b01, 2'b00};		// ADR {OPCODE, DEST, SRC}


		// store result on ADR = 2000 and ADR = 2001

		command_memory[30]	<=	{3'b001, 5'b00111};				// STA {OPCODE, ADR[12:8]}
		command_memory[31]	<=	{8'b11010000};					// STA {OPCODE, ADR[7:0]} // ADR = 2000

		command_memory[32] 	<=	{3'b111, 2'b01, 2'b00, 1'b1}; 	// LDI {OPCODE, ADDRESS_OP, JUMP_OP, DONT_CARE}

		command_memory[33]	<=	{3'b001, 5'b00111};				// STA {OPCODE, ADR[12:8]}
		command_memory[34]	<=	{8'b11010001};					// STA {OPCODE, ADR[7:0]} // ADR = 2001

		// Numbers:
		command_memory[1000] <= 	8'd5;
		command_memory[1001] <= 	8'd130;
		command_memory[1002] <= 	8'd126;
		command_memory[1003] <= 	8'd54;
		command_memory[1004] <= 	8'd27;
		command_memory[1005] <= 	8'd100;
		command_memory[1006] <= 	8'd3;
		command_memory[1007] <= 	8'd12;
		command_memory[1008] <= 	8'd110;
		command_memory[1009] <= 	8'd15;

		/*
		
		command_memory 		<= '{default : 8'b0};
		command_memory[0] 	<=	{3'b111, 2'b11, 2'b00, 1'b1}; 	// LDI {OPCODE, ADDRESS_OP, JUMP_OP, DONT_CARE}
		
		command_memory[1]	<=	{3'b000, 5'b0};					// LDA {OPCODE, ADR[12:8]}
		command_memory[2]	<=	{8'b01111111};					// LDA {OPCODE, ADR[7:0]} // ADR = 127
		
		command_memory[3]	<= 	{4'b1000, 2'b10, 2'b11};		// MVR {OPCODE, DEST, SRC}
		command_memory[4]	<=	{4'b1011, 2'b00, 2'b10};		// ORR {OPCODE, DEST, SRC}
		
		command_memory[5]	<=	{3'b110, 5'b0};					// JMP {OPCODE, ADR[12:8]} // ADR = 10
		command_memory[6]	<=	{8'b00001010};					// JMP {OPCODE, ADR[7:0]}
		
		command_memory[10]	<=	{4'b1001, 2'b11, 2'b10};		// ADR {OPCODE, DEST, SRC}
		
		command_memory[11] 	<=	{3'b111, 2'b11, 2'b00, 1'b1}; 	// LDI {OPCODE, ADDRESS_OP, JUMP_OP, DONT_CARE}
		
		command_memory[12]	<=	{3'b001, 5'b0};					// STA {OPCODE, ADR[12:8]}
		command_memory[13]	<=	{8'b11111111};					// STA {OPCODE, ADR[7:0]} // ADR = 255
	
		command_memory[14] 	<=	{3'b111, 2'b00, 2'b00, 1'b1}; 	// LDI {OPCODE, ADDRESS_OP, JUMP_OP, DONT_CARE}
	
		command_memory[15]	<=	{3'b011, 5'b0};					// ANA {OPCODE, ADR[12:8]}
		command_memory[16]	<=	{8'b11111111};	 				// ANA {OPCODE, ADR[7:0]} // ADR = 255

		command_memory[17]	<=	{3'b010, 5'b0};					// ADA {OPCODE, ADR[12:8]}
		command_memory[18]	<=	{8'b11111111};	 				// ADA {OPCODE, ADR[7:0]} // ADR = 255
		
		command_memory[127] <= 	8'b00011110;					// DATA
		
		*/
	
		

	end
	
	always @(address, mem_read) begin
		if (mem_read)
			command <= command_memory[address];
	end

endmodule