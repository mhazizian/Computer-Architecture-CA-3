`include "defines.sv"

module ALU(alu_in1, alu_in2, c_in, opcode, alu_out, c_out, z_out, n_out);

	input [7:0] alu_in1, alu_in2;
	input [2:0] opcode;
	input c_in;
	output logic [7:0] alu_out;
	output logic z_out, c_out, n_out;
	
	assign z_out = (alu_out == 8'b0 ? 1 : 0);
	assign n_out = (alu_out < 0);
	
	always @(*) begin
		case(opcode)
			`ADD_FN:		{c_out, alu_out} <= alu_in1 + alu_in2;
			`ADDC_FN:		{c_out, alu_out} <= alu_in1 + alu_in2 + c_in;
			`SUB_FN:		{c_out, alu_out} <= alu_in1 - alu_in2;
			`SUBC_FN: 		{c_out, alu_out} <= alu_in1 - alu_in2 - c_in;
			`AND_FN:		alu_out <= alu_in1 & alu_in2;
			`OR_FN:			alu_out <= alu_in1 | alu_in2;
		endcase
		
	end
	
endmodule
