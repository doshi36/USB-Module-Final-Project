// $Id: $
// File name:   tb_buffer.sv
// Created:     12/7/2023
// Author:      Austin Bohlmann
// Lab Section: 337-009
// Version:     1.0  Initial Design Entry
// Description: Testbench for data buffer

`timescale 1ns/10ps

module tb_buffer();

    localparam CLK_PERIOD = 10ns;
    localparam CHECK_DELAY = 1ns;

    reg tb_clk;
    reg tb_n_rst;
    reg tb_clear;
    reg tb_flush;
    reg tb_store_tx_data;
    reg [7:0] tb_tx_data;
    reg tb_store_rx_data;
    reg [7:0] tb_rx_packet_data;
    reg tb_get_tx_data;
    reg tb_get_rx_data;
    wire [6:0] tb_buff_occ;
    wire [7:0] tb_tx_packet_data;
    wire [7:0] tb_rx_data;

    integer tb_test_case_num;
	integer tb_std_test_case;
    string tb_test_case;

    reg [7:0] tb_expected_rx_data;
    reg [7:0] tb_expected_tx_packet;
    reg [6:0] tb_expected_buff_occ;

    task reset_dut;
	begin
		// Activate the design's reset (does not need to be synchronize with clock)
		tb_n_rst = 1'b0;
		
		// Wait for a couple clock cycles
		@(posedge tb_clk);
		@(posedge tb_clk);
		
		// Release the reset
		@(negedge tb_clk);
		tb_n_rst = 1;
		
		// Wait for a while before activating the design
		@(posedge tb_clk);
		@(posedge tb_clk);
	end
	endtask

    // Clock gen block
	always
	begin : CLK_GEN
		tb_clk = 1'b0;
		#(CLK_PERIOD / 2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD / 2.0);
	end

    buffer DUT(.clk(tb_clk), .n_rst(tb_n_rst), .clear(tb_clear), .flush(tb_flush),
                .store_tx_data(tb_store_tx_data), .tx_data(tb_tx_data),
                .store_rx_data(tb_store_rx_data), .RX_packet_data(tb_rx_packet_data),
                .get_tx_data(tb_get_tx_data), .get_rx_data(tb_get_rx_data),
                .buff_occ(tb_buff_occ), .TX_packet_data(tb_tx_packet_data),
                .RX_data(tb_rx_data));

    task send_rx_in;
            input [7:0] rx_data_in;
    begin
        @(negedge tb_clk);
        tb_rx_packet_data = rx_data_in;
        tb_store_rx_data = 1'b1;
        @(negedge tb_clk) //wait clock cycle;
        tb_store_rx_data = 1'b0;
    end
    endtask

    task send_tx_in;
            input [7:0] tx_data_in;
    begin
        @(negedge tb_clk);
        tb_tx_data = tx_data_in;
        tb_store_tx_data = 1'b1;
        @(negedge tb_clk) //wait clock cycle;
        tb_store_tx_data = 1'b0;
    end
    endtask

    task take_rx_out;
    begin
        @(negedge tb_clk);
        tb_get_rx_data = 1'b1;
        @(negedge tb_clk) //wait clock cycle;
        tb_get_rx_data = 1'b0;
    end
    endtask
    task take_tx_out;
    begin
        @(negedge tb_clk);
        tb_get_tx_data = 1'b1;
        @(negedge tb_clk) //wait clock cycle;
        tb_get_tx_data = 1'b0;
    end
    endtask

    task clear_buf;
    begin
        @(negedge tb_clk);
        tb_clear = 1'b1;
        @(negedge tb_clk);
        tb_clear = 1'b0;
    end
    endtask

    task check_outs;
            input logic [7:0] expected_rx_data;
            input logic [7:0] expected_tx_packet;
            input logic [6:0] expected_buff_occ;
            input logic [3:0] test_case_num;
            input string test_case;
    begin

        if(expected_rx_data == tb_rx_data)
        begin
            $info("Test Case #%0d had a correct rx_data output: %s", tb_test_case_num, tb_test_case);
        end
        else
        begin
            $error("Test Case #%0d had an incorrect rx_data output", tb_test_case_num);
        end

        if(expected_tx_packet == tb_tx_packet_data)
        begin
            $info("Test Case #%0d had a correct tx_packet_data output", tb_test_case_num);
        end
        else
        begin
            $error("Test Case #%0d had an incorrect tx_packet_data output", tb_test_case_num);
        end

        if(expected_buff_occ == tb_buff_occ)
        begin
            $info("Test Case #%0d had a correct buff_occ output", tb_test_case_num);
        end
        else
        begin
            $error("Test Case #%0d had an incorrect buff_occ output", tb_test_case_num);
        end
    end
    endtask

    initial
    begin
        tb_n_rst = 1'b1;
        tb_clear = 0;
        tb_flush = 0;
        tb_store_tx_data = 0;
        tb_store_rx_data = 0;
        tb_tx_data = 8'b0;
        tb_rx_packet_data = 8'b0;
        tb_get_rx_data = 1'b0;
        tb_get_tx_data = 1'b0;

        #(0.1);

        tb_test_case_num += 1;
        tb_expected_rx_data = 8'b0;
        tb_expected_tx_packet = 8'b0;
        tb_expected_buff_occ = 7'b0;
        tb_test_case = "Power on reset";
        
        tb_n_rst = 1'b0;
        #(CLK_PERIOD * 0.5);
        check_outs(tb_expected_rx_data, tb_expected_tx_packet, tb_expected_buff_occ, tb_test_case_num, tb_test_case);
        
        reset_dut();

        tb_test_case_num += 1;
        tb_expected_rx_data = 8'b11011110;
        tb_expected_tx_packet = 8'b0;
        tb_expected_buff_occ = 7'b0;
        tb_test_case = "Send RX data byte";
        send_rx_in(8'b11011110);
        @(negedge tb_clk); //wait for data to enter buffer
        take_rx_out;
        @(negedge tb_clk); 
        check_outs(tb_expected_rx_data, tb_expected_tx_packet, tb_expected_buff_occ, tb_test_case_num, tb_test_case);
    end
endmodule
