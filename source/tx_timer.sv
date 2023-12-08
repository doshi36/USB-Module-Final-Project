// $Id: $
// File name:   tx_timer.sv
// Created:     12/7/2023
// Author:      Austin Bohlmann
// Lab Section: 337-009
// Version:     1.0  Initial Design Entry
// Description: Two layered counter for timing data throughput of TX module
module tx_timer (input logic clk, input logic n_rst,
                input logic timer_en, input logic load_data,
                output logic shift_en, output logic cnt_8bits, output logic cnt_7bits);
    logic [3:0] count;
    logic [3:0] next_count;
    logic [3:0] bitcnt;
    logic [3:0] nbitcnt;
    always_ff @ (posedge clk, negedge n_rst) begin
        if(~n_rst) begin
            count <= 4'b0;
            bitcnt <= 4'b0;
        end else begin
            count <= next_count;
            bitcnt <= nbitcnt;
        end
    end
    //Shift_en is enabled every 8 clock cycles,
    //incrementing the bit count, shifting a value in PISO,
    //and allowing new value into the encoder
    //cnt_8bits strobes for a clock cycle every 8 shift_en,
    //signalling for new data to be loaded into the PISO
    //cnt_7bits is strobed a bit period before cnt_8bits,
    //allowing for the FSM to signal for new data to enter
    //TX_data before the FIFO calls for a load.
    assign shift_en = (count == 4'b1000);
    assign cnt_8bits = (bitcnt == 4'b1000);
    assign cnt_7bits = (bitcnt == 4'b0111);
    always_comb begin
        if(load_data) begin
            next_count = 4'b0001;
        end else if(count == 4'b1000) begin
            next_count = 4'b0001;
        end else if(timer_en) begin
            next_count = count + 1;
        end else begin
            next_count = count;
        end

        if(load_data) begin
            nbitcnt = 4'b0000;
        end else if(bitcnt == 4'b1000) begin
            nbitcnt = 4'b0000;
        end
        else if(count == 4'b1000) begin
            nbitcnt = bitcnt + 1;
        end else begin
            nbitcnt = bitcnt;
        end
    end
endmodule
