module probador #(parameter BUS_SIZE = 16,parameter WORD_SIZE = 4,parameter WORD_NUM = BUS_SIZE / WORD_SIZE)
(output reg clk,
output reg reset,
output reg [BUS_SIZE-1:0] data_input,
input [BUS_SIZE-1:0] data_out,
input [WORD_NUM-1:0] output_control,
input [BUS_SIZE-1:0] data_out_synth,
input [WORD_NUM-1:0] output_control_synth,
input err,
input nxt_err,
input err_synth,
input nxt_err_synth);

    initial begin
        $dumpfile("diagrama.vcd");
        $dumpvars();
        
        reset <= 0;
        data_input <= 0;

        @(posedge clk);
        reset <= 0;
        
        @(posedge clk);
        reset <= 1;
        data_input <= 'hF980;
        
        @(posedge clk);
        reset <= 1;
        data_input <= 'hF221;
        
        @(posedge clk);
        reset <= 1;
        data_input <= 'hF452;

        @(posedge clk);
        reset <= 1;
        data_input <= 'hABC3;    

        @(posedge clk);
        reset <= 1;
        data_input <= 'hF000;   
    
        @(posedge clk);
        reset <= 1;
        data_input <= 'hF119;

        @(posedge clk);

        @(posedge clk);

        @(posedge clk);

        $finish;    
    end
//clock
    initial clk <= 0;
    always #5 clk <= ~clk; 

endmodule