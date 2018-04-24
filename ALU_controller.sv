`include "defines.sv"

module ALU_controller(opcode, alu_operation);

	input [3:0] opcode;
	output logic [1:0] alu_operation;
	
	always @(opcode) begin
		
		case(opcode)
		`ADR_OP	:	alu_operation = `ADD_FN;
		`ANR_OP	:	alu_operation = `AND_FN;
		`ORR_OP	:	alu_operation = `OR_FN;
		endcase
		
		case(opcode[3:1])
		`ADA_OP	:	alu_operation = `ADD_FN;
		`ANA_OP	:	alu_operation = `AND_FN;
		endcase
	end
	
endmodule