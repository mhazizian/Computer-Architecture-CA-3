module data_path(clk, rst);
	
	input clk, rst;

	logic ld_PC, cen_PC, ld_IR, ld_DI, ld_ALU, write_en_rf, sel_IR_3_2, 
	
				sel_DI_4_3, sel_RF_write_src_TR_12_5, write_reg_en, sel_MEM_src_TR, 
			
				sel_MEM_src_PC, sel_ALU_src_reg1, sel_ALU_src_TR, ld_CZN,
			
				sel_CZN_src_RF, sel_CZN_src_ALU, sel_PC_src_JUMP, ld_TR,
				
				sel_RF_write_src_ALU, sel_RF_write_src_reg1, MEM_read, MEM_write,
				
				out_jump_sel;
	
	
	logic [12:0] out_TR, out_PC, out_mux_src_adr, out_PC_plus1, out_mux_src_pc;
	
	
	logic [7:0] out_MEM, out_IR, out_ALU, out_ALU_reg, out_mux_write_data, 
	
				out_reg1, out_reg2, out_mux_ALU_src;
	
	logic [4:0] out_DI;
	
	logic [2:0] out_CZN, CZN_from_ALU, CZN_from_RF, out_mux_src_CZN;
	
	logic [1:0] out_mux_dst_src, ALU_OP;

	Controller controller
	(
		.clk(clk), .rst(rst), .instruction(out_IR[7:4]),

		.ld_PC(ld_PC), .cen_PC(cen_PC), .ld_IR(ld_IR), .ld_DI(ld_DI),

		.ld_ALU(ld_ALU), .write_en_rf(write_en_rf), .sel_IR_3_2(sel_IR_3_2), .sel_DI_4_3(sel_DI_4_3),

		.sel_RF_write_src_TR_12_5(sel_RF_write_src_TR_12_5), .write_reg_en(write_reg_en), .sel_MEM_src_TR(sel_MEM_src_TR),

		.sel_MEM_src_PC(sel_MEM_src_PC), .sel_ALU_src_reg1(sel_ALU_src_reg1),

		.sel_ALU_src_TR(sel_ALU_src_TR), .ld_CZN(ld_CZN), .sel_CZN_src_RF(sel_CZN_src_RF),

		.ld_TR(ld_TR), .sel_RF_write_src_ALU(sel_RF_write_src_ALU),  .sel_CZN_src_ALU(sel_CZN_src_ALU),

		.sel_RF_write_src_reg1(sel_RF_write_src_reg1), .MEM_read(MEM_read), .MEM_write(MEM_write)

		.out_jump_sel(sel_PC_src_JUMP), .sel_PC_src_jump(out_jump_sel)
	);
	
	
	// PC

	jump_selcetor jump_selecetor(.opcode(out_DI[2:1]), .CZN(out_CZN), .enable(sel_PC_src_JUMP));
	
	register #(.WORD_LENGTH(13)) PC(.clk(clk), .rst(rst), .in(out_mux_src_pc), .out(out_PC), .ld(ld_PC));
	
	incrementer #(.WORD_LENGTH(13)) pc_incrementer(.in(out_PC), .out(out_PC_plus1));
	
	mux_2_to_1 #(.WORD_LENGTH(13)) mux_pc(.sel_first(out_jump_sel), .sel_second(~out_jump_sel), 
	
				.first(out_TR), .second(out_PC_plus1), .out(out_mux_src_pc));
		
	
	// Memory

	memory memory(.rst(rst), .address(out_mux_src_adr), .command(out_MEM), .write_data(out_reg2), .mem_read(MEM_read), .mem_writer(MEM_write));
	
	
	mux_2_to_1 #(.WORD_LENGTH(13)) mux_memory(.sel_first(sel_MEM_src_TR), .sel_second(sel_MEM_src_PC), 
	
				.first(out_TR), .second(out_PC), .out(out_mux_src_adr));
		
	
	// 13 bit for TR
	
	register #(.WORD_LENGTH(13)) TR(.clk(clk), .rst(rst), .in({out_MEM, out_IR[4:0]}), .out(out_TR), .ld(ld_TR));
	

	// 	8 bit for IR

	register #(.WORD_LENGTH(8)) IR(.clk(clk), .rst(rst), .in(out_MEM), .out(out_IR), .ld(ld_IR));

	
	//	5 bit for DI

	register #(.WORD_LENGTH(5)) DI(.clk(clk), .rst(rst), .in(out_IR [4:0]), .out(out_DI), .ld(ld_DI));

	
	//	Register file

	mux_2_to_1 #(.WORD_LENGTH(2)) mux_dst_rf(.sel_first(sel_IR_3_2), .sel_second(sel_DI_4_3),
	
				.first(out_IR[3:2]), .second(out_DI[4:3]), .out(out_mux_dst_src));
	
	
	mux_3_to_1 #(.WORD_LENGTH(8)) mux_write_data_rf(.first(out_TR[12:5]) , 
	
				.second(out_reg1), .third(out_ALU_reg), .sel_first(sel_RF_write_src_TR_12_5), 
				
				.sel_second(sel_RF_write_src_reg1), .sel_third(sel_RF_write_src_ALU), .out(out_mux_write_data));
		
	
	register_file RF(.clk(clk), .rst(rst), .write_reg(out_mux_dst_src), .write_data(out_mux_write_data),
	
				.write_reg_en(write_reg_en), .read_reg1(out_IR[1:0]), .read_reg2(out_mux_dst_src), 
			
				.read_data1(out_reg1), .read_data2(out_reg2), .CZN_from_RF(CZN_from_RF));

	
	//	ALU
	
	ALU_controller alu_controller(.opcode(out_IR[7:4]), .alu_operation(ALU_OP));
	
	mux_2_to_1 #(.WORD_LENGTH(8)) mux_alu_src(.sel_first(sel_ALU_src_reg1), 
		
				.sel_second(sel_ALU_src_TR),.first(out_reg1), .second(out_TR[12:5]), .out(out_mux_ALU_src));
				
	
	ALU alu(.alu_in1(out_mux_ALU_src), .alu_in2(out_reg2), .c_in(out_CZN[0]),
	
				.opcode(ALU_OP), .alu_out(out_ALU), .CZN_from_ALU(CZN_from_ALU));
	
	
	
	register #(.WORD_LENGTH(5)) ALU_reg(.clk(clk), .rst(rst), .in(out_ALU), .out(out_ALU_reg), .ld(ld_ALU));
	
		
	// CZN
	
	mux_2_to_1 #(.WORD_LENGTH(3)) mux_CZN(.sel_first(sel_CZN_src_RF), .sel_second(sel_CZN_src_ALU),
	
				.first(CZN_from_RF), .second(CZN_from_ALU), .out(out_mux_src_CZN));
	
	
	
	register #(.WORD_LENGTH(3)) CZN(.clk(clk), .rst(rst), .in(out_mux_src_CZN), .out(out_CZN), .ld(ld_CZN));
	


endmodule