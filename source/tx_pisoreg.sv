// $Id: $
// File name:   tx_pisoreg.sv
// Created:     12/6/2023
// Author:      Austin Bohlmann
// Lab Section: 337-009
// Version:     1.0  Initial Design Entry
// Description: Shift Register for TX module
module tx_pisoreg(input logic clk, input logic n_rst,
                    input logic shift_en, input logic load_data, input logic cnt_8bits,
                    input logic [2:0] bit_type,
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
        if(load_data) begin //Loading sync and PID bytes
            case(bit_type)
                default: next_data = curr_data;
                3'b001: next_data = 8'b10000000;    //Decoded SYNC byte pattern, encodes to 01010100
                3'b010: next_data = 8'b11010010;    //ACK PID and its complement
                3'b011: next_data = 8'b01011010;
                3'b100: next_data = 8'b00011110;
                3'b101: next_data = 8'b11000011;
            endcase
        end
        else if(cnt_8bits) begin
            next_data = tx_packet_data;
        end
        else if(shift_en) begin
            next_data = curr_data >> 1;
        end
        else begin
            next_data = curr_data;
        end
    end
    assign serial_out = curr_data[0];
endmodule