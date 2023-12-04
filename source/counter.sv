module counter (
    input logic clk,
    input logic n_rst,
    input logic cnt_up,
    input logic clear,
    output logic one_k_samples
);
    flex_counter #(10) inst1 (
        .clk(clk),
        .n_rst(n_rst),
        .clear(clear),
        .count_enable(cnt_up),
        .rollover_val(10'd1000),
        .rollover_flag(one_k_samples)
    );
endmodule