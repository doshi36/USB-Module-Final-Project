module rcv_timer (
    input logic clk,
    input logic n_rst,
    input logic edge_sig,
    input logic transfer_active,
    
    output logic byte_finish,
    output logic packet_done
);

    logic [3:0] count_out;

    rcv_flex_counter #(.NUM_CNT_BITS(4)) timer_1(
                        .clk(clk),     
                        .n_rst(n_rst), 
                        .clear(edge_sig),
                        .count_out(count_out), 
                        .count_enable(transfer_active), 
                        .rollover_val(4'd8));

    always_comb begin
        if (count_out == 4'd2) begin
            packet_done = '1;
        end
        else begin
            packet_done = '0;
        end
    end

    assign finished = (byte_finish || !transfer_active);

    rcv_flex_counter #(.NUM_CNT_BITS(4)) timer_2(
                        .clk(clk), 
                        .n_rst(n_rst), 
                        .clear(finished), 
                        .count_enable(packet_done), 
                        .rollover_val(4'd8), 
                        .rollover_flag(byte_finish));
endmodule