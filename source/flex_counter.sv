module flex_counter
#(
    parameter  NUM_CNT_BITS = 10 
)
(
    input logic clk,
    input logic n_rst,
    input logic clear,
    input logic count_enable,
    input logic [NUM_CNT_BITS - 1:0] rollover_val,
    output logic [NUM_CNT_BITS - 1:0] count_out,
    output logic rollover_flag
);
logic [NUM_CNT_BITS - 1:0] nxt_count;
logic nxt_rollover_flag;

always_ff @ (posedge clk, negedge n_rst) begin
    if (~n_rst) begin
        count_out <= 0;
        rollover_flag <= 0;
    end
    else begin
        count_out <= nxt_count;
        rollover_flag <= nxt_rollover_flag;
    end 
end

always_comb begin

    nxt_rollover_flag = 0;
    nxt_count = count_out;

    if (clear) begin
        nxt_rollover_flag = 0;
        nxt_count = 0;
    end 

    else if (count_enable) begin
        if (count_out == (rollover_val - 1)) begin

            nxt_rollover_flag = 1;
            nxt_count = count_out + 1;
        end 
        
        else if (count_out == rollover_val)

            nxt_count = 1;

        else
            
            nxt_count = count_out + 1;


    end

    else begin
        nxt_rollover_flag = rollover_flag;
        nxt_count = count_out;
        
    end


end

endmodule