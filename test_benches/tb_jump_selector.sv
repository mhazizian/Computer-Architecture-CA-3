`include "defines.sv"

module tb_jump_selector();
	
	logic [1:0] opcode;
	logic C = 1'b0, Z = 1'b1, N = 1'b0, enable;
		
	jump_selcetor uut(opcode, C, Z, N, enable);

	initial begin
		#200
			opcode = `NON_CONDITIONAL;
		#200
			opcode = `C_CONDITIONAL;
		#200
			opcode = `Z_CONDITIONAL;
		#200
			opcode = `N_CONDITIONAL;
		#200
			opcode = `NON_CONDITIONAL;
	end

endmodule


