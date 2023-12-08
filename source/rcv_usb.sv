// TOP LEVEL USB RX FILE

module rcv_usb(

    input logic        clk, 
    input logic        n_rst, 
    input logic        d_plus_in, 
    input logic        d_minus_in,

    output logic       rx_data_ready,
    output logic       flush, 
    output logic       store_rx_packet_data, 
    output logic       rx_transfer_active, 
    output logic       rx_error, 
    output logic [7:0] rx_packet_data,
    output logic [2:0] rx_packet
    
);
    logic [1:0] reg_state;

    logic d_plus_sync; 
    logic d_minus_sync; 

    logic byte_finish; 
    logic packet_done; 

    logic eop; 

    logic edge_sig; 
    logic d_prim;

    rcv_sync_low mod1(
        .clk(clk), 
        .n_rst(n_rst), 
        .async_in(d_minus_in), 
        .sync_out(d_minus_sync)
    );

    rcv_sync_high mod2(
        .clk(clk), 
        .n_rst(n_rst), 
        .async_in(d_plus_in), 
        .sync_out(d_plus_sync)
    );

    rcv_timer mod3(
        .clk(clk), 
        .n_rst(n_rst), 
        .edge_sig(edge_sig),
        .transfer_active(rx_transfer_active),
        .byte_finish(byte_finish),
        .packet_done(packet_done)
    );
    
    rcv_decoder mod4(
        .clk(clk), 
        .n_rst(n_rst), 
        .d_plus_sync(d_plus_sync), 
        .packet_done(packet_done), 
        .d_prim(d_prim)
    );
    
    rcv_edge_detector mod5(
        .clk(clk), 
        .n_rst(n_rst), 
        .d_plus_sync(d_plus_sync), 
        .edge_sig(edge_sig)
    );

    rcv_eop_detector mod6(
        .clk(clk), 
        .n_rst(n_rst), 
        .packet_done(packet_done),
        .d_plus_sync(d_plus_sync), 
        .d_minus_sync(d_minus_sync), 
        .eop(eop), 
        .reg_state(reg_state)
    );
    
    rcv_flex_stp_sr #(8, 1) mod7(
        .clk(clk), 
        .n_rst(n_rst), 
        .shift_enable(packet_done), 
        .serial_in(d_prim),
        .parallel_out(rx_packet_data)
    );
    
    rcv_rcu final_mod8(
        .clk(clk), 
        .n_rst(n_rst), 
        .edge_sig(edge_sig),
        .byte_finish(byte_finish),
        .flush(flush), 
        .packet_done(packet_done),
        .eop(eop), 
        .reg_state(reg_state),
        .rx_transfer_active(rx_transfer_active), 
        .rx_data_ready(rx_data_ready), 
        .rx_error(rx_error),
        .store_rx_packet_data(store_rx_packet_data),
        .rx_packet(rx_packet),
        .rx_shift_register(rx_packet_data) 
    );
endmodule