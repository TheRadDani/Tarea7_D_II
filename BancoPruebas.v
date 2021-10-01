`include "bus.v"
`include "fsm.v"
`include "fsm_synth.v"
`include "bus_synth.v"
`include "probador.v"

module BancoPruebas();
	parameter BUS_SIZE = 16;
	parameter WORD_SIZE = 4;
    parameter WORD_NUM = BUS_SIZE / WORD_SIZE;

    wire reset, clk, err, nxt_err, err_synth, nxt_err_synth;
	wire [BUS_SIZE-1:0] data_input;
	wire [BUS_SIZE-1:0] data_out;
    wire [WORD_NUM-1:0] output_control;
	wire [BUS_SIZE-1:0] data_out_synth;
    wire [WORD_NUM-1:0] output_control_synth;

        bus bus_inst(/*AUTOINST*/
		 // Outputs
		 .data_out		(data_out[BUS_SIZE-1:0]),
		 .output_control	(output_control[WORD_NUM-1:0]),
		 // Inputs
		 .clk			(clk),
		 .reset			(reset),
		 .data_input		(data_input[BUS_SIZE-1:0]));

        bus_synth bus_synth_inst(/*AUTOINST*/
		// Outputs
		.data_out		(data_out_synth[15:0]),
		.output_control	(output_control_synth[3:0]),
		// Inputs
		.clk		(clk),
		.data_input		(data_input[15:0]),
		.reset		(reset));

        fsm fsm_inst(/*AUTOINST*/
			 // Outputs
			 .err			(err),
			 .nxt_err		(nxt_err),
			 // Inputs
			 .clk			(clk),
			 .reset			(reset),
			 .data_input		(data_input[BUS_SIZE-1:0]));
		fsm_synth fsm_sintetizado_inst(/*AUTOINST*/
			// Outputs
			.err		(err_synth),
			.nxt_err		(nxt_err_synth),
			// Inputs
			.clk		(clk),
			.data_input		(data_input[15:0]),
			.reset		(reset));

        probador probador_inst(/*AUTOINST*/
			   // Outputs
			   .clk			(clk),
			   .reset		(reset),
			   .data_input		(data_input[BUS_SIZE-1:0]),
			   // Inputs
			   .data_out		(data_out[BUS_SIZE-1:0]),
			   .output_control	(output_control[WORD_NUM-1:0]),
			   .data_out_synth(data_out_synth[BUS_SIZE-1:0]),
			   .output_control_synth(output_control_synth[WORD_NUM-1:0]),
			   .err			(err),
			   .nxt_err		(nxt_err),
			   .err_synth	(err_synth),
			   .nxt_err_synth(nxt_err_synth));
endmodule