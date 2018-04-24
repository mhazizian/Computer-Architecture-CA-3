module tb_mux();
	
	logic[12:0] f = 13'b1111000011110, s = 13'b1010101010101, o;
	logic sel1, sel2;
	
	mux_2_to_1 #(.WORD_LENGTH(13)) uut(
    .sel_first(sel1),
    .sel_second(sel2),
    .first(f),
    .second(s),
    .out(o)
	);
	
	initial begin
		#200
		sel1 = 1'b1;
		#200
		sel1 = 1'b0;
		sel2 = 1'b1;
		#200
		sel2 = 1'b0;
	end

endmodule