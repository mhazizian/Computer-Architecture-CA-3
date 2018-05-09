`include "defines.sv"

module jump_selcetor(opcode, CZN, enable);
	input [1:0] opcode;
	input [2:0] CZN;
	output logic enable;
	
	always@(opcode, CZN)
	begin
		case(opcode)
		`NON_CONDITIONAL	:	enable = 1'b1;
		`C_CONDITIONAL		:	enable = CZN[0];
		`Z_CONDITIONAL		:	enable = CZN[1];
		`N_CONDITIONAL		:	enable = CZN[2];
		endcase
	end
endmodule