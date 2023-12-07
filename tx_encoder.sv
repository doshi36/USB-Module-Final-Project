// $Id: $
// File name:   tx_encoder.sv
// Created:     12/7/2023
// Author:      Austin Bohlmann
// Lab Section: 337-009
// Version:     1.0  Initial Design Entry
// Description: Encoder for TX data in CDL
module tx_encoder(input logic clk, input logic n_rst,
            input logic data_out, input logic [2:0] bit_type, input logic shift_en,
            output logic dplus_out, output logic dminus_out);

logic next_dpout;

always_ff @ (posedge clk, negedge n_rst) begin
    if(~n_rst) begin
        dplus_out <= 1'b1;
    end
    else begin
        dplus_out <= next_dpout;
    end
end

always_comb begin
    next_dpout = dplus_out;
    if(shift_en) begin
        if(data_out == 1'b1)
            next_dpout = !dplus_out;
        else
            next_dpout = dplus_out;
    end
end
assign dminus_out = (bit_type == 3'b111) ? dplus_out : !dplus_out;

endmodule