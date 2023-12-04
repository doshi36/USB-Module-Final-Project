module flex_stp_sr
#(
    parameter NUM_BITS = 4, 
    parameter SHIFT_MSB = 1
)
(
    input logic clk,
    input logic n_rst,
    input logic shift_enable,
    input logic serial_in,
    output logic [NUM_BITS - 1:0] parallel_out
);

    logic [NUM_BITS - 1: 0] nxt_out;
    
    always_ff @(posedge clk, negedge n_rst) begin
        if (!n_rst)
            parallel_out <= '1;
        else 
            parallel_out <= nxt_out;
    end

    always_comb begin

        nxt_out = parallel_out;

        if (shift_enable) begin
            if (SHIFT_MSB == 0)
                nxt_out = {serial_in, parallel_out[NUM_BITS - 1: 1]};
            else 
                nxt_out = {parallel_out[NUM_BITS - 2: 0], serial_in};
        end
    end

endmodule