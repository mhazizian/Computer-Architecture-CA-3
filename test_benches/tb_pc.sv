module tb_pc();
	
	logic[12:0] in = 13'b1111000011110, s = 13'b1010101010101, o;
	logic rst, clk = 1'b0, ld, cen;
	
	pc_register uut(
    .clk(clk),
    .rst(rst),
    .in(in),
    .out(o),
	.ld(ld),
	.cen(cen)
	);
	
	initial repeat (20) #200 clk = ~clk;
	
	initial begin
		#100
		rst = 1'b1;
		#200
		rst = 1'b0;
		ld = 1'b1;
		#400
		ld = 1'b0;
		cen = 1'b1;
	end

endmodule

