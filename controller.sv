`include "defines.sv"

module Controller(
		clk, rst,

		instruction

		ld_PC, cen_PC, ld_IR, ld_DI, ld_ALU, write_en_rf, sel_IR_3_2, 
		
		sel_DI_4_3, sel_RF_write_src_TR_12_5, write_reg_en, sel_MEM_src_TR, 
				
		sel_MEM_src_PC, sel_ALU_src_reg1, sel_ALU_src_TR, ld_CZN,
				
		sel_CZN_src_RF, sel_CZN_src_ALU, ld_TR,
					
		sel_RF_write_src_ALU, sel_RF_write_src_reg1, MEM_read, MEM_write

	);

	input clk, rst;
	input [3:0] instruction;
	output logic ld_PC, cen_PC, ld_IR, ld_DI, ld_ALU, write_en_rf, sel_IR_3_2, 
		
		sel_DI_4_3, sel_RF_write_src_TR_12_5, write_reg_en, sel_MEM_src_TR, 
				
		sel_MEM_src_PC, sel_ALU_src_reg1, sel_ALU_src_TR, ld_CZN,
				
		sel_CZN_src_RF, sel_CZN_src_ALU, ld_TR,
					
		sel_RF_write_src_ALU, sel_RF_write_src_reg1, MEM_read, MEM_write;

	logic [3:0] ps, ns;


	always @(posedge clk, posedge rst) 
    begin : TRANSITION_DECIDE
		ns = `CONTROLLER_IF;	
      
		case(ps)

			`CONTROLLER_IF : begin
				if (instruction[3:1] == `LDI_OP) ns = `CONTROLLER_LDI;
				if (instruction[3:0] == `MVR_OP) ns = `CONTROLLER_MVR;
			end

			`CONTROLLER_LDI : ns = `CONTROLLER_IF;
			`CONTROLLER_MVR : ns = `CONTROLLER_IF;

		endcase // ps
	end

	always @(posedge clk, posedge rst)
	begin : TRANSITION_APPLY
		if(rst)
			ps <= `CONTROLLER_IF;
		else
			ps <= ns;
	end

	always @(posedge clk, posedge rst)
	begin : 
		ld_PC = 0; cen_PC = 0; ld_IR = 0; ld_DI = 0; ld_ALU = 0; write_en_rf = 0; sel_IR_3_2 = 0; 
		sel_DI_4_3 = 0; sel_RF_write_src_TR_12_5 = 0; write_reg_en = 0; sel_MEM_src_TR = 0;
		sel_MEM_src_PC = 0; sel_ALU_src_reg1 = 0; sel_ALU_src_TR = 0; ld_CZN = 0;
		sel_CZN_src_RF = 0; sel_CZN_src_ALU = 0; ld_TR = 0;
		sel_RF_write_src_ALU = 0; sel_RF_write_src_reg1 = 0; MEM_read = 0; MEM_write = 0;

		case(ps)
			`CONTROLLER_IF : begin

				// Set IR 
				ld_IR = 1;
				sel_MEM_src_PC = 1;
				MEM_read = 1;

				// Inc PC
				ld_PC = 1;
			end

			`CONTROLLER_LDI : begin
				ld_DI = 1;
			end

			`CONTROLLER_LDI : begin
				sel_RF_write_src_reg1 = 1;
				write_en_rf = 1;
				sel_DI_4_3 = 1;
				ld_CZN = 1;
				sel_CZN_src_ALU = 1;
			end
		endcase // ps
	end

endmodule // Controller