`include "defines.sv"

module Controller(
		clk, rst,

		instruction, out_jump_sel,

		ld_PC, cen_PC, ld_IR, ld_DI, ld_ALU, write_en_rf, sel_IR_3_2, 
		
		sel_DI_4_3, sel_RF_write_src_TR_7_0, sel_MEM_src_TR, 
				
		sel_MEM_src_PC, sel_ALU_src_reg1, sel_ALU_src_TR, ld_CZN,
				
		sel_CZN_src_RF, sel_CZN_src_ALU, ld_TR, sel_PC_src_jump,
					
		sel_RF_write_src_ALU, sel_RF_write_src_reg1, MEM_read, MEM_write

	);

	input clk, rst, out_jump_sel;
	
	input [3:0] instruction;
	
	output logic ld_PC, cen_PC, ld_IR, ld_DI, ld_ALU, write_en_rf, sel_IR_3_2, 
		
		sel_DI_4_3, sel_RF_write_src_TR_7_0, sel_MEM_src_TR, 
				
		sel_MEM_src_PC, sel_ALU_src_reg1, sel_ALU_src_TR, ld_CZN,
				
		sel_CZN_src_RF, sel_CZN_src_ALU, ld_TR, sel_PC_src_jump,
					
		sel_RF_write_src_ALU, sel_RF_write_src_reg1, MEM_read, MEM_write;

	logic [3:0] ps, ns;


	always @(posedge clk, instruction) 
    begin : TRANSITION_DECIDE
		ns = `CONTROLLER_IF;	
      
		case(ps)
			`CONTROLLER_IF : ns = `CONTROLLER_Decode;

			`CONTROLLER_Decode : begin
				case(instruction[3:1])
					`LDI_OP : ns = `CONTROLLER_LDI;

					`LDA_OP : ns = `CONTROLLER_IF2;
					`STA_OP : ns = `CONTROLLER_IF2;
					`ADA_OP : ns = `CONTROLLER_IF2;
					`ANA_OP : ns = `CONTROLLER_IF2;
					`JMP_OP : ns = `CONTROLLER_IF2;

				endcase

				case(instruction[3:0])
					`MVR_OP : ns = `CONTROLLER_MVR;

					`ADR_OP : ns = `CONTROLLER_RTYPE;
					`ANR_OP : ns = `CONTROLLER_RTYPE;
					`ORR_OP : ns = `CONTROLLER_RTYPE;

				endcase
			end

			`CONTROLLER_LDI : ns = `CONTROLLER_IF;
			`CONTROLLER_MVR : ns = `CONTROLLER_IF;

			`CONTROLLER_RTYPE : ns = `CONTROLLER_ALU_TO_RF;
			`CONTROLLER_ALU_TO_RF: ns = `CONTROLLER_IF;

			`CONTROLLER_IF2 : begin
				case(instruction[3:1])

					`LDA_OP : ns = `CONTROLLER_LD_MEM;
					`ADA_OP : ns = `CONTROLLER_LD_MEM;
					`ANA_OP : ns = `CONTROLLER_LD_MEM;
					`JMP_OP : ns = `CONTROLLER_JMP;
					`STA_OP : ns = `CONTROLLER_STA;

				endcase
			end

			`CONTROLLER_JMP : ns = `CONTROLLER_IF;
			`CONTROLLER_STA : ns = `CONTROLLER_IF;
			
			`CONTROLLER_LD_MEM : begin
				case(instruction[3:1])

					`LDA_OP : ns = `CONTROLLER_LDA;
					`ADA_OP : ns = `CONTROLLER_MEM_TO_ALU;
					`ANA_OP : ns = `CONTROLLER_MEM_TO_ALU;

				endcase
			end

			`CONTROLLER_LDA : ns = `CONTROLLER_IF;

			`CONTROLLER_MEM_TO_ALU : ns = `CONTROLLER_ALU_TO_RF_D;
			`CONTROLLER_ALU_TO_RF_D : ns = `CONTROLLER_IF;

		endcase // ps
	end

	always @(ps)
	begin
		ld_PC = 0; cen_PC = 0; ld_IR = 0; ld_DI = 0; ld_ALU = 0; write_en_rf = 0; sel_IR_3_2 = 0; 
		sel_DI_4_3 = 0; sel_RF_write_src_TR_7_0 = 0; sel_MEM_src_TR = 0;
		sel_MEM_src_PC = 0; sel_ALU_src_reg1 = 0; sel_ALU_src_TR = 0; ld_CZN = 0;
		sel_CZN_src_RF = 0; sel_CZN_src_ALU = 0; ld_TR = 0; sel_PC_src_jump = 0;
		sel_RF_write_src_ALU = 0; sel_RF_write_src_reg1 = 0; MEM_read = 0; MEM_write = 0;

		case(ps)
			`CONTROLLER_IF : begin
				// Set IR 
				ld_IR = 1;
				sel_MEM_src_PC = 1;
				MEM_read = 1;

				// Inc PC
				ld_PC = 1;
				sel_PC_src_jump = 0;
			end

			`CONTROLLER_Decode : begin
			end


			`CONTROLLER_LDI : begin
				ld_DI = 1;
			end

			`CONTROLLER_MVR : begin
				sel_RF_write_src_reg1 = 1;
				write_en_rf = 1;
				sel_IR_3_2 = 1;
				// ld_CZN = 1;
				// sel_CZN_src_RF = 1;
			end

			`CONTROLLER_RTYPE : begin
				sel_IR_3_2 = 1;
				ld_ALU = 1;
				sel_ALU_src_reg1 = 1;
				ld_CZN = 1;
				sel_CZN_src_ALU = 1;
			end

			`CONTROLLER_ALU_TO_RF : begin
				sel_RF_write_src_ALU = 1;
				write_en_rf = 1;
			end

			`CONTROLLER_IF2 : begin
				// Set TR
				ld_TR = 1;
				sel_MEM_src_PC = 1;
				MEM_read = 1;

				// Inc PC
				ld_PC = 1;
				sel_PC_src_jump = 0;
			end

			`CONTROLLER_JMP : begin
				if (out_jump_sel) begin
					ld_PC = 1;
					sel_PC_src_jump = 1;
				end
			end

			`CONTROLLER_STA : begin
				sel_DI_4_3 = 1;
				sel_MEM_src_TR = 1;
				MEM_write = 1;
			end

			`CONTROLLER_LD_MEM : begin
				sel_MEM_src_TR = 1;
				MEM_read = 1;
				ld_TR = 1;
			end
			`CONTROLLER_LDA : begin
				sel_DI_4_3 = 1;
				sel_RF_write_src_TR_7_0 = 1;
				write_en_rf = 1;
				ld_CZN = 1;
				sel_CZN_src_RF = 1;
			end

			`CONTROLLER_MEM_TO_ALU : begin
				sel_ALU_src_TR = 1;
				sel_DI_4_3 = 1;
				ld_ALU = 1;
				ld_CZN = 1;
				sel_CZN_src_ALU = 1;
			end

			`CONTROLLER_ALU_TO_RF_D : begin
				sel_RF_write_src_ALU = 1;
				sel_DI_4_3 = 1;
				write_en_rf = 1;
			end

		endcase // ps
	end



	always @(posedge clk, posedge rst)
	begin : TRANSITION_APPLY
		if(rst)
			ps <= `CONTROLLER_IF;
		else
			ps <= ns;
	end
	
	
endmodule // Controller