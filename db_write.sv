// $Id: $
// File name:   db_write.sv
// Created:     12/6/2023
// Author:      Austin Bohlmann
// Lab Section: 337-009
// Version:     1.0  Initial Design Entry
// Description: Write block of data buffer module

module db_write(input logic clk, input logic n_rst,
    input logic flush, input logic clear, input logic [6:0] buff_occ,
    input logic store_tx_data, input logic [7:0] tx_data,
    input logic store_rx_data, input logic [7:0] RX_packet_data,
    output logic write_en, output logic [7:0] write_data, output logic [6:0] write_ptr);

    logic next_en;
    logic [6:0] next_ptr;
    logic [7:0] next_data;

    always_ff @ (posedge clk, negedge n_rst) begin 
        if(~n_rst) begin
            write_ptr <= 7'b0;
            write_data <= 8'b0;
            write_en <= 1'b0;
        end
        else begin
            write_ptr <= next_ptr;
            write_data <= next_data;
            write_en <= next_en;
        end
    end

    always_comb begin
        next_en = 0;
        next_data = write_data;
        next_ptr = write_ptr;
        if(clear || flush) begin
            next_en = 1'b0;
            next_data = 8'b0;
            next_ptr = 7'b0;
        end
        else if(buff_occ < 7'd64) begin
            if(store_tx_data) begin
                next_en = 1'b1;
                next_data = tx_data;
                next_ptr = write_ptr + 1;
            end
            else if(store_rx_data) begin
                next_en = 1'b1;
                next_data = RX_packet_data;
                next_ptr = write_ptr + 1;
            end
        end
    end




endmodule

