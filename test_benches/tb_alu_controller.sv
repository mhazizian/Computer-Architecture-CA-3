module tb_alu();
	
	logic[7:0] alu_in1 = 8'b11110000, alu_in2 = 8'b10101010, alu_out;
	logic c_out, z_out, n_out, c_in = 1'b1;
	logic [3:0] opcode;
	logic [1:0] alu_operation;
	
	ALU_controller uut(opcode, alu_operation);
	
	ALU uut2(alu_in1, alu_in2, c_in, alu_operation, alu_out, c_out, z_out, n_out);
	
	initial #20000 $stop;
	
	initial begin
		#100
		opcode = 4'b0100;
		#200
		opcode = 4'b0111;
		#200
		opcode = 4'b1001;
		#200
		opcode = 4'b1010;
		#200
		opcode = 4'b1011;
	end

endmodule

