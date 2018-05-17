// ALU Functions

`define ADD_FN 				2'b00
`define AND_FN 				2'b01
`define OR_FN 				2'b10

// ALU Opcodes

`define ADA_OP 				3'b010
`define ANA_OP 				3'b011
`define ADR_OP 				4'b1001
`define ANR_OP 				4'b1010
`define ORR_OP 				4'b1011

// JUMP Types

`define NON_CONDITIONAL		2'b00
`define C_CONDITIONAL		2'b01
`define Z_CONDITIONAL		2'b10
`define N_CONDITIONAL		2'b11

// Instructions

`define LDI_OP				3'b111
`define MVR_OP				4'b1000

//Controller States

`define CONTROLLER_IF 		4'd1
`define CONTROLLER_Decode 	4'd2

`define CONTROLLER_LDI 		4'd3
`define CONTROLLER_MVR 		4'd4
`define CONTROLLER_RTYPE 	4'd5
`define CONTROLLER_RTYPE_T 	4'd6