// $Id: $
// File name:   tx_top.sv
// Created:     12/7/2023
// Author:      Austin Bohlmann
// Lab Section: 337-009
// Version:     1.0  Initial Design Entry
// Description: Top level for TX module of CDL
module tx_top(input logic clk, input logic n_rst,
    input logic [2:0] tx_packet, input logic [7:0] tx_packet_data,
    input logic [6:0] buff_occ, 
    output logic TX_Transfer_Active, output logic tx_error, 
    output logic get_tx_data, output logic dplus_out, output logic dminus_out);

    logic cnt_8bits;
    logic cnt_7bits;
    logic shift_en;
    logic timer_en;
    logic load_data;
    logic [2:0] bit_type;

    logic serial_out;

    tx_fsm fsm1(.clk(clk), .n_rst(n_rst), .TX_packet(tx_packet), .buff_occ(buff_occ), .cnt_7bits(cnt_7bits),
    .shift_en(shift_en), .TX_Error(tx_error), .TX_Transfer_Active(TX_Transfer_Active), .Get_TX_Data(get_tx_data),
    .timer_en(timer_en), .load_data(load_data), .bit_type(bit_type));

    tx_pisoreg sreg1(.clk(clk), .n_rst(n_rst), .shift_en(shift_en), .load_data(load_data), .cnt_8bits(cnt_8bits),
        .bit_type(bit_type), .tx_packet_data(tx_packet_data), .serial_out(serial_out));
    
    tx_timer txt1(.clk(clk), .n_rst(n_rst), .timer_en(timer_en), .load_data(load_data), .shift_en(shift_en), .cnt_8bits(cnt_8bits), .cnt_7bits(cnt_7bits));

    tx_encoder enc1(.clk(clk), .n_rst(n_rst), .data_out(serial_out), .bit_type(bit_type), .shift_en(shift_en),
    .dplus_out(dplus_out), .dminus_out(dminus_out));
    
endmodule