// $Id: $
// File name:   buffer.sv
// Created:     12/6/2023
// Author:      Austin Bohlmann
// Lab Section: 337-009
// Version:     1.0  Initial Design Entry
// Description: Top level for data buffer module of CDL
module buffer(input logic clk, input logic n_rst,
                input logic clear, input logic flush,
                input logic store_tx_data, input logic [7:0] tx_data,
                input logic store_rx_data, input logic [7:0] RX_packet_data,
                input logic get_tx_data, input logic get_rx_data,
                output logic [6:0] buff_occ, output logic [7:0] TX_packet_data, output logic [7:0] RX_data);
//write block outputs
logic write_en;
logic [7:0] write_data;
logic [6:0] write_ptr;
//read block outputs
logic read_en;
logic [6:0] read_ptr;

db_write write_block (.clk(clk), .n_rst(n_rst), .flush(flush), .clear(clear), .buff_occ(buff_occ),
                        .store_tx_data(store_tx_data), .tx_data(tx_data),
                        .store_rx_data(store_rx_data), .RX_packet_data(RX_packet_data),
                        .write_en(write_en), .write_data(write_data), .write_ptr(write_ptr));
                   
db_read read_block (.clk(clk), .n_rst(n_rst), .flush(flush), .clear(clear), .get_tx_data(get_tx_data),
                        .get_rx_data(get_rx_data), .buff_occ(buff_occ), .read_en(read_en), .read_ptr(read_ptr));

db_fifo f1 (.clk(clk), .n_rst(n_rst), .write_en(write_en), .write_data(write_data), .write_ptr(write_ptr),
        .clear(clear), .flush(flush), .read_ptr(read_ptr), .read_en(read_en), .get_tx_data(get_tx_data), .get_rx_data(get_rx_data),
        .tx_packet_data(TX_packet_data), .rx_data(RX_data), .buff_occ(buff_occ));
endmodule