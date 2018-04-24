// ALU Functions

`define ADD_FN 				3'b000
`define ADDC_FN 			3'b001
`define SUB_FN 				3'b010
`define SUBC_FN 			3'b011
`define AND_FN 				3'b100
`define OR_FN 				3'b101

// JUMP types

`define NON_CONDITIONAL		2'b00
`define C_CONDITIONAL		2'b01
`define Z_CONDITIONAL		2'b10
`define N_CONDITIONAL		2'b11