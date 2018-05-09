`include "defines.sv"

module ALU(alu_in1, alu_in2, c_in, opcode, alu_out, CZN_from_ALU);

	input [7:0] alu_in1, alu_in2;
	input [1:0] opcode;
	input c_in;
	output logic [7:0] alu_out;
	output logic [2:0] CZN_from_ALU;
	
	assign CZN_from_ALU[1] = (alu_out == 8'b0 ? 1 : 0);
	assign CZN_from_ALU[2] = (alu_out < 0);
	
	always @(*) begin
		case(opcode)
			`ADD_FN:		{CZN_from_ALU[0], alu_out} <= alu_in1 + alu_in2 + c_in;
			`AND_FN:		alu_out <= alu_in1 & alu_in2;
			`OR_FN:			alu_out <= alu_in1 | alu_in2;
		endcase
		
	end
	
endmodule
