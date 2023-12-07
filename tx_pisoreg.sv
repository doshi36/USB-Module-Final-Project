// $Id: $
// File name:   tx_pisoreg.sv
// Created:     12/6/2023
// Author:      Austin Bohlmann
// Lab Section: 337-009
// Version:     1.0  Initial Design Entry
// Description: Shift Register for TX module
module tx_pisoreg(input logic clk, input logic n_rst,
                    input logic shift_en, input logic load_data, input logic cnt_7bits,
                    input logic [7:0] tx_packet_data, output logic serial_out);
    logic [7:0] next_data;
    logic [7:0] curr_data;
    always_ff @ (posedge clk, negedge n_rst) begin
        if(~n_rst) begin
            curr_data <= 8'b0;
        end else begin
            curr_data <= next_data;
        end
    end
    
    always_comb begin
        if(load_data || cnt_7bits) begin
            next_data = tx_packet_data;
        end
        else if(shift_en) begin
            next_data = curr_data << 1;
        end
        else begin
            next_data = curr_data;
        end
    end
    assign serial_out = curr_data[7];
endmodule