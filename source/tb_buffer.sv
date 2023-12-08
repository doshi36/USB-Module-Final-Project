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

    integer i;

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
        tb_rx_packet_data = rx_data_in;
        @(negedge tb_clk);
        tb_store_rx_data = 1'b1;
        @(negedge tb_clk) //wait clock cycle;
        tb_store_rx_data = 1'b0;
    end
    endtask

    task send_tx_in;
            input [7:0] tx_data_in;
    begin
        tb_tx_data = tx_data_in;
        @(negedge tb_clk)
        tb_store_tx_data = 1'b1;
         #(CLK_PERIOD); //wait clock cycle;
        tb_store_tx_data = 1'b0;
    end
    endtask

    task take_rx_out;
    begin
        @(negedge tb_clk);
        tb_get_rx_data = 1'b1;
        #(CLK_PERIOD);
        tb_get_rx_data = 1'b0;
    end
    endtask
    task take_tx_out;
    begin
        @(negedge tb_clk);
        tb_get_tx_data = 1'b1;
        #(CLK_PERIOD) //wait clock cycle;
        tb_get_tx_data = 1'b0;
    end
    endtask

    task clear_buf;
    begin
        @(negedge tb_clk);
        tb_clear = 1'b1;
        #(CLK_PERIOD);
        tb_clear = 1'b0;
    end
    endtask

    task check_outs;
            input logic [7:0] expected_rx_data;
            input logic [7:0] expected_tx_packet;
            input logic [6:0] expected_buff_occ;
            input logic [3:0] test_case_num;
            input string test_case;
            input string test_part;
    begin

        if(expected_rx_data == tb_rx_data)
        begin
            $info("Test Case #%0d: %s had a correct rx_data output: %s", tb_test_case_num, tb_test_case, test_part);
        end
        else
        begin
            $error("Test Case #%0d: %s had an incorrect rx_data output: %s", tb_test_case_num, tb_test_case, test_part);
        end

        if(expected_tx_packet == tb_tx_packet_data)
        begin
            $info("Test Case #%0d: %s had a correct tx_packet_data output: %s", tb_test_case_num, tb_test_case, test_part);
        end
        else
        begin
            $error("Test Case #%0d: %s had an incorrect tx_packet_data output: %s", tb_test_case_num, tb_test_case, test_part);
            $info("%0d E:%0d",tb_tx_packet_data, expected_tx_packet);
        end

        if(expected_buff_occ == tb_buff_occ)
        begin
            $info("Test Case #%0d: %s had a correct buff_occ output: %s", tb_test_case_num, tb_test_case, test_part);
        end
        else
        begin
            $error("Test Case #%0d: %s had an incorrect buff_occ output: %s", tb_test_case_num, tb_test_case, test_part);
            $info("%0d E:%0d",tb_buff_occ, expected_buff_occ);
        end
    end
    endtask

    initial
    begin
        tb_n_rst = 1'b1;
        tb_clear = 1'b0;
        tb_flush = 1'b0;
        tb_store_tx_data =  1'b0;
        tb_store_rx_data = 1'b0;
        tb_tx_data = 8'b0;
        tb_rx_packet_data = 8'b0;
        tb_get_rx_data = 1'b0;
        tb_get_tx_data = 1'b0;
        tb_test_case_num = 0;
        #(0.1);
        
        tb_test_case_num += 1;
        tb_test_case = "Power on reset";
        tb_expected_rx_data = 8'b0;
        tb_expected_tx_packet = 8'b0;
        tb_expected_buff_occ = 7'b0;
        
        tb_n_rst = 1'b0;
        #(CLK_PERIOD * 0.5);
        check_outs(tb_expected_rx_data, tb_expected_tx_packet, tb_expected_buff_occ, tb_test_case_num, tb_test_case, "After resetting");
        
        reset_dut();

        tb_test_case_num += 1;
        tb_expected_tx_packet = 8'b0;
        tb_expected_rx_data = 8'b0;
        tb_test_case = "Send and pull RX data byte";
        tb_expected_buff_occ = 7'b0000001;

        send_rx_in(8'b11011110);

        @(negedge tb_clk); //wait for data to enter buffer
        
        check_outs(tb_expected_rx_data, tb_expected_tx_packet, tb_expected_buff_occ, tb_test_case_num, tb_test_case, "After writing RX data");
        take_rx_out();
        #(CLK_PERIOD);
        tb_expected_buff_occ = 7'b0;
        tb_expected_rx_data = 8'b11011110;
        check_outs(tb_expected_rx_data, tb_expected_tx_packet, tb_expected_buff_occ, tb_test_case_num, tb_test_case, "After pulling RX data");
        
        //TEST 3
        #(CLK_PERIOD);
        reset_dut();
        tb_test_case = "Send and pull TX data byte";
        tb_test_case_num += 1;
        tb_expected_tx_packet = 8'b0;
        tb_expected_rx_data = 8'b0;
        tb_expected_buff_occ = 7'b0000001;

        send_tx_in(8'b00000100);
        @(negedge tb_clk); //wait for data to enter buffer

        check_outs(tb_expected_rx_data, tb_expected_tx_packet, tb_expected_buff_occ, tb_test_case_num, tb_test_case, "After writing TX data");
        take_tx_out();
        #(CLK_PERIOD);
        tb_expected_buff_occ = 7'b0;
        tb_expected_tx_packet = 8'b00000100;
        check_outs(tb_expected_rx_data, tb_expected_tx_packet, tb_expected_buff_occ, tb_test_case_num, tb_test_case, "After pulling TX data");

        //TEST 4
        #(CLK_PERIOD);
        reset_dut();
        tb_test_case = "Clear and flush";
        tb_test_case_num += 1;
        tb_expected_tx_packet = 8'b0;
        tb_expected_rx_data = 8'b0;
        tb_expected_buff_occ = 7'b0001000;
        
        tb_rx_packet_data = 8'b11111111;
        @(negedge tb_clk);
        tb_store_rx_data = 1'b1;
        #(CLK_PERIOD * 8);
        tb_store_rx_data = 1'b0;
        check_outs(tb_expected_rx_data, tb_expected_tx_packet, tb_expected_buff_occ, tb_test_case_num, tb_test_case, "After filling with data");
        clear_buf();
        tb_expected_buff_occ = 7'b0000000;
        #(CLK_PERIOD);
        check_outs(tb_expected_rx_data, tb_expected_tx_packet, tb_expected_buff_occ, tb_test_case_num, tb_test_case, "After clearing data");

        //TEST 5
        #(CLK_PERIOD);
        reset_dut();
        tb_test_case = "Small size data transfer";
        tb_test_case_num += 1;
        tb_expected_tx_packet = 8'b0;
        tb_expected_rx_data = 8'b0;
        tb_expected_buff_occ = 7'b0000100;

        send_tx_in(8'b10000001);
        send_tx_in(8'b00001000);
        send_tx_in(8'b11100000);
        send_tx_in(8'b11111111);
    
        check_outs(tb_expected_rx_data, tb_expected_tx_packet, tb_expected_buff_occ, tb_test_case_num, tb_test_case, "Writing small packet");
        @(negedge tb_clk);
        tb_expected_tx_packet = 8'b11111111;
        tb_expected_buff_occ = 7'b0;
        for(i = 0; i < 4; i++)begin
            take_tx_out;
        end
        #(CLK_PERIOD * 2);
        check_outs(tb_expected_rx_data, tb_expected_tx_packet, tb_expected_buff_occ, tb_test_case_num, tb_test_case, "Reading Small Packet");

        //TEST 6
        #(CLK_PERIOD);
        reset_dut();
        tb_test_case = "Medium size data transfer";
        tb_test_case_num += 1;
        tb_expected_tx_packet = 8'b0;
        tb_expected_rx_data = 8'b0;
        tb_expected_buff_occ = 7'b0010000;
        tb_rx_packet_data = 8'b10101010;
        @(negedge tb_clk);
        tb_store_rx_data = 1'b1;
        #(CLK_PERIOD * 16);
        tb_store_rx_data =1'b0;
        

        check_outs(tb_expected_rx_data, tb_expected_tx_packet, tb_expected_buff_occ, tb_test_case_num, tb_test_case, "Writing medium packet");
        @(negedge tb_clk);
        tb_expected_tx_packet = 8'b10101010;
        tb_expected_buff_occ = 7'b0;
        tb_get_tx_data = 1'b1;
        #(CLK_PERIOD * 16);
        check_outs(tb_expected_rx_data, tb_expected_tx_packet, tb_expected_buff_occ, tb_test_case_num, tb_test_case, "Reading Medium Packet");
        tb_get_tx_data = 1'b0;

        //TEST 7
        #(CLK_PERIOD);
        reset_dut();
        tb_test_case = "Max size data transfer";
        tb_test_case_num += 1;
        tb_expected_tx_packet = 8'b0;
        tb_expected_rx_data = 8'b0;
        tb_expected_buff_occ = 7'b0111100;
        tb_tx_data = 8'b10010000;
        @(negedge tb_clk);
        tb_store_tx_data = 1'b1;
        #(CLK_PERIOD * 60);
        tb_store_tx_data = 1'b0;

        check_outs(tb_expected_rx_data, tb_expected_tx_packet, tb_expected_buff_occ, tb_test_case_num, tb_test_case, "Writing max size packet");
        @(negedge tb_clk);
        tb_expected_tx_packet = 8'b10010000;
        tb_expected_buff_occ = 7'b0;
        tb_get_tx_data = 1'b1;
        #(CLK_PERIOD * 62); //Needs extra cycles to get to expected
        check_outs(tb_expected_rx_data, tb_expected_tx_packet, tb_expected_buff_occ, tb_test_case_num, tb_test_case, "Reading max size Packet");
        tb_get_tx_data = 1'b0;

        //TEST 8
        #(CLK_PERIOD);
        reset_dut();
        tb_test_case = "Simultaneous read and write";
        tb_test_case_num += 1;
        tb_expected_tx_packet = 8'b0;
        tb_expected_rx_data = 8'b11111101;
        tb_expected_buff_occ = 7'b0000001;
        tb_rx_packet_data = 8'b11111101;
        @(negedge tb_clk);
        send_rx_in(8'b11111101);
        #(CLK_PERIOD);
        tb_store_rx_data = 1;
        tb_get_rx_data = 1;
        #(CLK_PERIOD * 5);
        tb_store_rx_data = 0;
        tb_get_rx_data = 0;
        check_outs(tb_expected_rx_data, tb_expected_tx_packet, tb_expected_buff_occ, tb_test_case_num, tb_test_case, "After FIFO Processes Reads/Writes");
        
        //TEST 9
        #(CLK_PERIOD);
        reset_dut();
        tb_test_case = "Flush while counting";
        tb_test_case_num += 1;
        tb_expected_tx_packet = 8'b0;
        tb_expected_rx_data = 8'b0;
        tb_expected_buff_occ = 7'b0000000;
        tb_rx_packet_data = 8'b11111101;
        @(negedge tb_clk);
        send_rx_in(8'b11111111);
        #(CLK_PERIOD * 6);
        tb_flush = 1'b1;
        #(CLK_PERIOD);
        check_outs(tb_expected_rx_data, tb_expected_tx_packet, tb_expected_buff_occ, tb_test_case_num, tb_test_case, "After Flush is asserted");
        #(CLK_PERIOD * 2);
    end
endmodule