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

`define LDA_OP				3'b000
`define STA_OP				3'b001
`define JMP_OP				3'b110


//Controller States

`define CONTROLLER_IF 		4'd1
`define CONTROLLER_IF2 		4'd2
`define CONTROLLER_Decode 	4'd3

`define CONTROLLER_LDI 		4'd4
`define CONTROLLER_MVR 		4'd5
`define CONTROLLER_RTYPE 	4'd6
`define CONTROLLER_ALU_TO_RF 	4'd7

`define CONTROLLER_JMP 		4'd8
`define CONTROLLER_STA 		4'd9
`define CONTROLLER_LD_MEM 	4'd10
`define CONTROLLER_LDA 		4'd11
`define CONTROLLER_MEM_TO_ALU 	4'd12
`define CONTROLLER_ALU_TO_RF_D 	4'd13







