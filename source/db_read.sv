// $Id: $
// File name:   db_read.sv
// Created:     12/6/2023
// Author:      Austin Bohlmann
// Lab Section: 337-009
// Version:     1.0  Initial Design Entry
// Description: Read block of data buffer module
module db_read(input logic clk, input logic n_rst,
                input logic get_tx_data, input logic get_rx_data, input logic [6:0] buff_occ,
                input logic clear, input logic flush,
                output logic read_en, output logic [6:0] read_ptr);

logic [6:0] next_ptr;
logic next_en;

always_ff @ (posedge clk, negedge n_rst) begin
    if(~n_rst) begin
        read_ptr <= 7'b0;
        read_en <= 1'b0;
    end
    else begin
        read_ptr <= next_ptr;
        read_en <= next_en;
    end
end

always_comb begin
    next_ptr = read_ptr;
    next_en = 1'b0;
    if(clear || flush) begin
        next_ptr = 7'b0;
        next_en = 1'b0;
    end
    else if(get_tx_data || get_rx_data) begin
        if(buff_occ != 0) begin
            next_en = 1'b1;
            next_ptr = read_ptr + 1;
        end else begin
            next_en= 1'b0;
            next_ptr = read_ptr;
        end
    end
end
endmodule

