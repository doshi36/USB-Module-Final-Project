// $Id: $
// File name:   fifo.sv
// Created:     12/5/2023
// Author:      Austin Bohlmann
// Lab Section: 337-009
// Version:     1.0  Initial Design Entry
// Description: FIFO module of data buffer RAM
module db_fifo(input logic clk, input logic n_rst,
            input logic write_en, input logic [7:0] write_data,
            input logic [6:0] write_ptr, 
            input logic clear, input logic flush,
            input logic [6:0] read_ptr, input logic read_en,
            input logic get_tx_data, input logic get_rx_data,
            output logic [7:0] tx_packet_data, 
            output logic [7:0] rx_data,
            output logic [6:0] buff_occ);

logic [7:0] ram [63:0];
logic [7:0] nram [63:0];
logic [7:0] nrx_data;
logic [7:0] ntx_data;
logic i, j;
always_ff @ (posedge clk, negedge n_rst) begin //updating ram and data outputs
    if(~n_rst) begin
        for(j=0; j < 64; j++) begin
                ram[j] = 8'b0;
            end
        tx_packet_data <= 8'b0;
        rx_data <= 8'b0;
    end else begin
        ram <= nram;
        tx_packet_data <= ntx_data;
        rx_data <= nrx_data;
    end
end

//delaying get_tx_data and get_rx_data by a clock cycle to align with read enable
logic tx_en;
logic rx_en;
always_ff @ (posedge clk, negedge n_rst) begin
    if(~n_rst) begin
        tx_en <= 1'b0;
        rx_en <= 1'b0;
    end else begin
        tx_en <= get_tx_data;
        rx_en <= get_rx_data;
    end
end

always_comb begin
    nram = ram;
    ntx_data = tx_packet_data;
    nrx_data = rx_data;
    if(clear || flush) begin    //clearing data
            for(i=0; i < 64; i++) begin
                nram[i] = 8'b0;
            end
    end
    else begin
        if(write_en && (buff_occ != 7'd64)) begin //writing to register file
            nram[write_ptr] = write_data;
        end
        if(read_en && buff_occ != 0) begin //reading data and popping it out of the file
            if(tx_en) begin
                ntx_data = ram[read_ptr];
                nram[read_ptr] = 8'b0;
            end
            else if(get_rx_data) begin
                nrx_data = ram[read_ptr];
                nram[read_ptr] = 8'b0;
            end
        end
    end
end

assign buff_occ = write_ptr - read_ptr;
endmodule