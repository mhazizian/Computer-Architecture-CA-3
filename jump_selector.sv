`include "defines.sv"

module jump_selcetor(opcode, C, Z, N, enable);
	input [1:0] opcode;
	input C, Z, N;
	output logic enable;
	
	always@(opcode, C, Z, N)
	begin
		case(opcode)
		`NON_CONDITIONAL	:	enable = 1'b1;
		`C_CONDITIONAL		:	enable = C;
		`Z_CONDITIONAL		:	enable = Z;
		`N_CONDITIONAL		:	enable = N;
		endcase
	end
endmodule