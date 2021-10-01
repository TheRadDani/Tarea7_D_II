module fsm
(
    input clk,
	input reset,
	input [BUS_SIZE-1:0] data_in,
    output reg err,
    output reg nxt_err
);
    parameter BUS_SIZE = 16;
    parameter WORD_SIZE = 4;

    reg [3:0] state; 
    reg [3:0] next_state;
    reg [WORD_SIZE-1:0] counter;

    //ASIGNACIÓN ONE HOT
    parameter RESET =     4'b0000; //1
    parameter FIRST_PKG = 4'b0001; //2
    parameter REG_PKG =   4'b0010; //3
    parameter F_ERR =     4'b0100; //4
    parameter SEQ_ERR =   4'b1000; //8

    always @(posedge clk) 
    begin
        if (reset == 0) begin
            state <= RESET;
            err <= 0;
            counter <= 0;
        end
        else if (reset == 1) begin
            state <= next_state;
            err <= nxt_err;
            if (nxt_err == 1)begin
                counter <= 0;
            end
            else begin
                counter <= counter + 1;
            end

        end
    end 
    always @(*) begin
        nxt_err = err;
        next_state = state;
        case (state)
            RESET: begin
                if ((data_in[BUS_SIZE-1:BUS_SIZE-WORD_SIZE] == 'hF) && (data_in[WORD_SIZE-1:0] == counter))begin
                    next_state = FIRST_PKG;
                    nxt_err = 0;
                end
                else begin
                    next_state = RESET;
                end
            end

            FIRST_PKG: begin
                if ((data_in[BUS_SIZE-1:BUS_SIZE-WORD_SIZE] == 'hF) && (data_in[WORD_SIZE-1:0] == counter))begin
                    next_state = REG_PKG;
                    nxt_err = 0;
                end
                else if (data_in[BUS_SIZE-1:BUS_SIZE-WORD_SIZE] != 'hF) begin
                    next_state = F_ERR;
                    nxt_err = 1;
                end
                else if (data_in[WORD_SIZE-1:0] != counter)begin
                    next_state = SEQ_ERR;
                    nxt_err = 1;
                end
            end

            REG_PKG: begin
                if ((data_in[BUS_SIZE-1:BUS_SIZE-WORD_SIZE] == 'hF) && (data_in[WORD_SIZE-1:0] == counter)) begin
                    next_state = REG_PKG;
                    nxt_err = 0;
                end
                else if (data_in[BUS_SIZE-1:BUS_SIZE-WORD_SIZE] != 'hF) begin
                    next_state = F_ERR;
                    nxt_err = 1;
                end
                else if (data_in[WORD_SIZE-1:0] != counter)begin
                    next_state = SEQ_ERR;
                    nxt_err = 1;
                end
            end

            F_ERR: begin
                if ((data_in[BUS_SIZE-1:BUS_SIZE-WORD_SIZE] == 'hF) && (data_in[WORD_SIZE-1:0] == counter))begin
                    next_state = FIRST_PKG;
                    nxt_err = 0;
                end
                else if (data_in[WORD_SIZE-1:0] != counter)begin
                    next_state = SEQ_ERR;
                    nxt_err = 1;
                end
                else if (data_in[BUS_SIZE-1:BUS_SIZE-WORD_SIZE] != 'hF) begin
                    next_state = F_ERR;
                    nxt_err = 1;
                end
            end

            SEQ_ERR: begin
                if ((data_in[BUS_SIZE-1:BUS_SIZE-WORD_SIZE] == 'hF) && (data_in[WORD_SIZE-1:0] == counter))begin
                    next_state = FIRST_PKG;
                    nxt_err = 0;
                end
                else if (data_in[BUS_SIZE-1:BUS_SIZE-WORD_SIZE] != 'hF) begin
                    next_state = F_ERR;
                    nxt_err = 1;
                end
                else if (data_in[WORD_SIZE-1:0] != counter)begin
                    next_state = SEQ_ERR;
                    nxt_err = 1;
                end
            end

            default: begin
                next_state = RESET;
                nxt_err = 0;
            end
        endcase    
    end
endmodule