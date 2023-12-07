// $Id: $
// File name:   tx_timer.sv
// Created:     12/7/2023
// Author:      Austin Bohlmann
// Lab Section: 337-009
// Version:     1.0  Initial Design Entry
// Description: Two layered counter for timing data throughput of TX module
module tx_timer (input logic clk, input logic n_rst,
                input logic timer_en,
                output logic shift_en, output logic cnt_7bits);
    logic [3:0] count;
    logic [3:0] next_count;
    logic [2:0] bitcnt;
    logic [2:0] nbitcnt;
    always_ff @ (posedge clk, negedge n_rst) begin
        if(~n_rst) begin
            count <= 4'b0;
            bitcnt <= 3'b0;
        end else begin
            count <= next_count;
            bitcnt <= nbitcnt;
        end
    end
    assign shift_en = (count == 4'b1000);
    assign cnt_7bits = (bitcnt == 3'b111);
    always_comb begin
        if(count == 4'b1000)
            next_count = 4'b0001;
        else if(timer_en) begin
            next_count = count + 1;
        end else begin
            next_count = count;
        end

        if(bitcnt == 3'b111) begin
            nbitcnt = 3'b000;
        end
        else if(count == 4'b1000) begin
            nbitcnt = bitcnt + 1;
        end else begin
            nbitcnt = bitcnt;
        end
    end
endmodule
