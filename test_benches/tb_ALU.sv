`include "defines.sv"

module tb_alu();
	
	logic[7:0] alu_in1 = 8'b11110000, alu_in2 = 8'b10101010, alu_out;
	logic[2:0] opcode;
	logic c_out, z_out, n_out, c_in = 1'b1;
	
	ALU uut(alu_in1, alu_in2, c_in, opcode, alu_out, c_out, z_out, n_out);
	
	initial begin
		#100
		opcode = `ADD_FN;
		#200
		opcode = `ADDC_FN;
		#200
		opcode = `SUB_FN;
		#200
		opcode = `SUBC_FN;
		#200
		opcode = `AND_FN;
		#200
		opcode = `OR_FN;
		#200
		opcode = `OR_FN;
	end

endmodule

