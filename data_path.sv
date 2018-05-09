module data_path(clk, rst);
	
	input clk, rst;

	logic ld_PC, cen_PC, ld_IR, ld_DI, ld_ALU;
	
	logic [12:0] out_TR, out_PC;
	
	logic [7:0] out_MEM, out_IR, out_ALU, out_ALU_reg;
	
	logic [4:0] out_DI;
	
	pc_register PC(
	.clk(clk), 
	.rst(rst),
	.ld(ld_PC),
	.cen(cen_PC),
	.in(out_TR),
	.out(out_PC)
	);

// 13 bit for TR


// 	8 bit for IR

	register #(.WORD_LENGTH(8)) IR(
    .clk(clk),
    .rst(rst),
    .in(out_MEM),
    .out(out_IR),
	.ld(ld_IR)
	);
	
//	5 bit for DI

	register #(.WORD_LENGTH(5)) DI(
    .clk(clk),
    .rst(rst),
    .in(out_MEM [4:0]),
    .out(out_DI),
	.ld(ld_DI)
	);

//	8 bit for ALU_out

	register #(.WORD_LENGTH(5)) ALU(
    .clk(clk),
    .rst(rst),
    .in(out_ALU),
    .out(out_ALU_reg),
	.ld(ld_ALU)
	);