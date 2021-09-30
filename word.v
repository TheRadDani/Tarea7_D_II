module word #(parameter BUS_SIZE = 16,parameter WORD_SIZE = 4,parameter WORD_NUM = BUS_SIZE / WORD_SIZE) 
(
	input clk,
	input reset,
	input [WORD_SIZE-1:0] data_input,
	output reg [WORD_SIZE-1:0] data_out,
    output reg output_control
);
    always @ (posedge clk) 
    begin
      	if (reset == 0)
        begin
              data_out <= 0;
              output_control <= 0;
        end
      	else if (reset == 1) 
        begin
              data_out <= data_input;
              output_control <= data_input[0] | data_input[1] | data_input[2] | data_input[3];
        end
    end
endmodule