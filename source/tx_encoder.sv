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
logic curr_pout;
always_ff @ (posedge clk, negedge n_rst) begin
    if(~n_rst) begin
        curr_pout <= 1'b1;
    end
    else begin
        curr_pout <= next_dpout;
    end
end

always_comb begin
    next_dpout = curr_pout;
    if(shift_en) begin
        if(data_out == 1'b0) begin
            next_dpout = !curr_pout;
        end else begin
            next_dpout = curr_pout;
        end
        /*
        if(bit_type == 3'b111) //EOP
            next_dpout = 1'b0;
        else if(bit_type == 3'b000) //IDLE 
            next_dpout = 1'b1;
        else if(data_out == 1'b0)
            next_dpout = !dplus_out;
        else
            next_dpout = dplus_out;
            */
    end
end
assign dplus_out = (bit_type == 3'b111) ? 1'b0 : ((bit_type == 3'b000) ? 1'b1 : curr_pout);
assign dminus_out = (bit_type == 3'b111) ? 1'b0 : ((bit_type == 3'b000) ? 1'b0 : !curr_pout);

endmodule