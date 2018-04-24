module tb_register();
	
	logic[12:0] in = 13'b1111000011110, s = 13'b1010101010101, o;
	logic rst, clk = 1'b0, ld;
	
	register #(.WORD_LENGTH(13)) uut(
    .clk(clk),
    .rst(rst),
    .in(in),
    .out(o),
	.ld(ld)
	);
	
	initial repeat (20) #200 clk = ~clk;
	
	initial begin
		#200
		rst = 1'b1;
		#200
		rst = 1'b0;
		ld = 1'b1;
	end

endmodule
