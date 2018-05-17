module test_bench();
	
	logic rst = 1'b0, clk = 1'b0;
	
	data_path dp(clk, rst);
	
	initial repeat(50) #200 clk = ~clk;
	
	initial begin
		#100
		rst = 1'b1;
		#400
		rst = 1'b0;
	end
	
endmodule
		