// $Id: $
// File name:   tb_tx_top.sv
// Created:     12/7/2023
// Author:      Austin Bohlmann
// Lab Section: 337-009
// Version:     1.0  Initial Design Entry
// Description: Top level testbench for TX module
`timescale 1ns/10ps

module tb_tx_top();

    localparam CLK_PERIOD = 10ns;
    localparam CHECK_DELAY = 1ns;

    reg tb_clk;
    reg tb_n_rst;
    reg [2:0] tb_tx_packet;
    reg [7:0] tb_tx_packet_data;
    reg [6:0] tb_buff_occ;
    wire tb_tx_transfer_active;
    wire tb_tx_error;
    wire tb_get_tx_data;
    wire tb_dplus_out;
    wire tb_dminus_out;

    integer tb_test_case_num;
	integer tb_std_test_case;
    string tb_test_case;

    reg tb_expected_error;
    reg tb_expected_transfer_active;
    reg tb_expected_get_tx_data;
    reg tb_expected_dplus_out;
    reg tb_expected_dminus_out;

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

    tx_top DUT(.clk(tb_clk), .n_rst(tb_n_rst), .tx_packet(tb_tx_packet),
    .tx_packet_data(tb_tx_packet_data), .buff_occ(tb_buff_occ),
    .TX_Transfer_Active(tb_tx_transfer_active), .tx_error(tb_tx_error),
    .get_tx_data(tb_get_tx_data), .dplus_out(tb_dplus_out), .dminus_out(tb_dminus_out));

    task check_outs;
            input logic expected_error;
            input logic expected_transfer_active;
            input logic expected_get_tx_data;
            input logic expected_dplus_out;
            input logic expected_dminus_out;
            input string test_case;
            input string test_part;
    begin

        if(expected_error == tb_tx_error)
        begin
            $info("Test Case #%0d: %s had a correct error output in %s", tb_test_case_num, tb_test_case, test_part);
        end
        else
        begin
            $error("Test Case #%0d: %s had an incorrect error output in %s", tb_test_case_num, tb_test_case, test_part);
        end

        if(expected_transfer_active == tb_tx_transfer_active)
        begin
            $info("Test Case #%0d: %s had a correct tx_transfer_active output in %s", tb_test_case_num, tb_test_case, test_part);
        end
        else
        begin
            $error("Test Case #%0d: %s had an ioncorrect tx_transfer_active output in %s", tb_test_case_num, tb_test_case, test_part);
        end

        if(expected_get_tx_data == tb_get_tx_data)
        begin
            $info("Test Case #%0d: %s had a correct get_tx_data output in %s", tb_test_case_num, tb_test_case, test_part);
        end
        else
        begin
            $error("Test Case #%0d: %s had an incorrect get_tx_data output in %s", tb_test_case_num, tb_test_case, test_part);
        end

        if(expected_dplus_out == tb_dplus_out)
        begin
            $info("Test Case #%0d: %s had a correct dplus_out output in %s", tb_test_case_num, tb_test_case, test_part);
        end
        else
        begin
            $error("Test Case #%0d: %s had an incorrect dplus_out output in %s", tb_test_case_num, tb_test_case, test_part);
        end

        if(expected_dminus_out == tb_dminus_out)
        begin
            $info("Test Case #%0d: %s had a correct dminus output in %s", tb_test_case_num, tb_test_case, test_part);
        end
        else
        begin
            $error("Test Case #%0d: %s had an incorrect dminus output in %s", tb_test_case_num, tb_test_case, test_part);
        end
    end
    endtask

    initial
    begin
        tb_n_rst = 1'b1;
        tb_tx_packet = 3'b0;
        tb_tx_packet_data = 8'b0;
        tb_buff_occ = 7'b0;
        tb_test_case_num = 0;

        #(0.1);
        tb_test_case_num += 1;
        tb_test_case = "Power on reset";
        
        tb_expected_error = 1'b0;
        tb_expected_transfer_active = 1'b0;
        tb_expected_get_tx_data = 1'b0;
        tb_expected_dplus_out = 1'b1;
        tb_expected_dminus_out = 1'b0;

        tb_n_rst = 1'b0;
        #(CLK_PERIOD * 0.5);
        check_outs(tb_expected_error,tb_expected_transfer_active,
        tb_expected_get_tx_data,
        tb_expected_dplus_out,
        tb_expected_dminus_out, tb_test_case, "after reset");
        
        
        //TEST 2
        tb_test_case_num += 1;
        tb_test_case = "ACK Byte";
        tb_expected_error = 1'b0;
        tb_expected_transfer_active = 1'b1;
        tb_expected_get_tx_data = 1'b0;
        tb_expected_dplus_out = 1'b1;
        tb_expected_dminus_out = 1'b0;

        reset_dut();
        @(negedge tb_clk);
        tb_tx_packet = 3'b010; //ACK Packet Code
        #(CLK_PERIOD * 2); //Beginning of sync byte
        
        check_outs(tb_expected_error,tb_expected_transfer_active,
        tb_expected_get_tx_data,
        tb_expected_dplus_out,
        tb_expected_dminus_out, tb_test_case, "Start of SYNC");

        #(CLK_PERIOD * 128);
        tb_tx_packet = 3'b0; //Return to IDLE state
        #(CLK_PERIOD * 16);

        //Expected Vals at EOP
        tb_expected_error = 1'b0;
        tb_expected_transfer_active = 1'b1;
        tb_expected_get_tx_data = 1'b0;
        tb_expected_dplus_out = 1'b0;
        tb_expected_dminus_out = 1'b0;

        check_outs(tb_expected_error,tb_expected_transfer_active,
        tb_expected_get_tx_data,
        tb_expected_dplus_out,
        tb_expected_dminus_out, tb_test_case, "EOP of ACK Packet");
        #(CLK_PERIOD * 8); // Make some space between tests

        //TEST 3
        tb_test_case_num += 1;
        tb_test_case = "NAK Byte";
        tb_expected_error = 1'b0;
        tb_expected_transfer_active = 1'b1;
        tb_expected_get_tx_data = 1'b0;
        tb_expected_dplus_out = 1'b1;
        tb_expected_dminus_out = 1'b0;

        reset_dut();
        @(negedge tb_clk);
        tb_tx_packet = 3'b011;
        #(CLK_PERIOD * 2); //Beginning of sync byte
        
        check_outs(tb_expected_error,tb_expected_transfer_active,
        tb_expected_get_tx_data,
        tb_expected_dplus_out,
        tb_expected_dminus_out, tb_test_case, "Start of SYNC");

        #(CLK_PERIOD * 128);
        tb_tx_packet = 3'b0; //Return to IDLE state
        #(CLK_PERIOD * 16);

        //Expected Vals at EOP
        tb_expected_error = 1'b0;
        tb_expected_transfer_active = 1'b1;
        tb_expected_get_tx_data = 1'b0;
        tb_expected_dplus_out = 1'b0;
        tb_expected_dminus_out = 1'b0;

        check_outs(tb_expected_error,tb_expected_transfer_active,
        tb_expected_get_tx_data,
        tb_expected_dplus_out,
        tb_expected_dminus_out, tb_test_case, "End of NAK");

        #(CLK_PERIOD * 8); // Make some space between tests

        //TEST 4
        tb_test_case_num += 1;
        tb_test_case = "STALL Byte";
        tb_expected_error = 1'b0;
        tb_expected_transfer_active = 1'b1;
        tb_expected_get_tx_data = 1'b0;
        tb_expected_dplus_out = 1'b1;
        tb_expected_dminus_out = 1'b0;

        reset_dut();
        @(negedge tb_clk);
        tb_tx_packet = 3'b100;
        #(CLK_PERIOD * 2); //Beginning of sync byte

        check_outs(tb_expected_error,tb_expected_transfer_active,
        tb_expected_get_tx_data,
        tb_expected_dplus_out,
        tb_expected_dminus_out, tb_test_case, "Start of SYNC");
        
        #(CLK_PERIOD * 128);
        tb_tx_packet = 3'b0; //Return to IDLE state
        #(CLK_PERIOD * 16);

        //Expected Vals at EOP
        tb_expected_error = 1'b0;
        tb_expected_transfer_active = 1'b1;
        tb_expected_get_tx_data = 1'b0;
        tb_expected_dplus_out = 1'b0;
        tb_expected_dminus_out = 1'b0;

        check_outs(tb_expected_error,tb_expected_transfer_active,
        tb_expected_get_tx_data,
        tb_expected_dplus_out,
        tb_expected_dminus_out, tb_test_case, "End of STALL");
        #(CLK_PERIOD * 8);

        //TEST 5
        tb_test_case_num += 1;
        tb_test_case = "Small Payload DATA PID";
        tb_expected_error = 1'b0;
        tb_expected_transfer_active = 1'b1;
        tb_expected_get_tx_data = 1'b0;
        tb_expected_dplus_out = 1'b1;
        tb_expected_dminus_out = 1'b0;
        
        tb_buff_occ = 7'd3;

        reset_dut();
        @(negedge tb_clk);
        tb_tx_packet = 3'b001;

        #(CLK_PERIOD * 128);
        tb_tx_packet_data = 8'b11010011;    //Random data entry
        for(tb_buff_occ = 3; tb_buff_occ > 0; tb_buff_occ--) begin
            //buff_occ subtracts during READ_DATA, before shift_en is asserted
            #(CLK_PERIOD * 64); //Goes once between READ_DATA and HOLD_DATA
        end
        check_outs(tb_expected_error,tb_expected_transfer_active,
        tb_expected_get_tx_data,
        tb_expected_dplus_out,
        tb_expected_dminus_out, tb_test_case, "Somewhere in data sending");
        
        //TEST 6
        tb_test_case_num += 1;
        tb_test_case = "Medium Payload DATA PID";
        tb_expected_error = 1'b0;
        tb_expected_transfer_active = 1'b1;
        tb_expected_get_tx_data = 1'b0;
        tb_expected_dplus_out = 1'b1;
        tb_expected_dminus_out = 1'b0;
        
        tb_buff_occ = 7'd3;

        reset_dut();
        @(negedge tb_clk);
        tb_tx_packet = 3'b001;

        #(CLK_PERIOD * 128);
        tb_tx_packet_data = 8'b00101100;    //Random data entry
        for(tb_buff_occ = 20; tb_buff_occ > 0; tb_buff_occ--) begin
            //buff_occ subtracts during READ_DATA, before shift_en is asserted
            #(CLK_PERIOD * 64); //Goes once between READ_DATA and HOLD_DATA
        end
        check_outs(tb_expected_error,tb_expected_transfer_active,
        tb_expected_get_tx_data,
        tb_expected_dplus_out,
        tb_expected_dminus_out, tb_test_case, "After all data is expended");
        tb_tx_packet = 3'b000;
        
        //TEST 7
        tb_test_case_num += 1;
        tb_test_case = "Large Payload DATA PID";
        tb_expected_error = 1'b0;
        tb_expected_transfer_active = 1'b1;
        tb_expected_get_tx_data = 1'b0;
        tb_expected_dplus_out = 1'b1;
        tb_expected_dminus_out = 1'b0;
        
        tb_buff_occ = 7'd3;

        reset_dut();
        @(negedge tb_clk);
        tb_tx_packet = 3'b001;

        #(CLK_PERIOD * 128);
        tb_tx_packet_data = 8'b00101100;    //Random data entry
        for(tb_buff_occ = 64; tb_buff_occ > 0; tb_buff_occ--) begin
            //buff_occ subtracts during READ_DATA, before shift_en is asserted
            #(CLK_PERIOD * 64); //Goes once between READ_DATA and HOLD_DATA
        end
        check_outs(tb_expected_error,tb_expected_transfer_active,
        tb_expected_get_tx_data,
        tb_expected_dplus_out,
        tb_expected_dminus_out, tb_test_case, "After all data is expended");
        #(CLK_PERIOD * 5);
        tb_tx_packet = 3'b000;

        //TEST 8
        tb_test_case_num += 1;
        tb_test_case = "Invalid Transfer Error";
        tb_expected_error = 1'b1;
        tb_expected_transfer_active = 1'b1;
        tb_expected_get_tx_data = 1'b0;
        tb_expected_dplus_out = 1'b1;
        tb_expected_dminus_out = 1'b0;

        tb_buff_occ = 7'd0; //Attempting to read data from empty buffer

        reset_dut();
        
        @(negedge tb_clk);
        tb_tx_packet = 3'b001;

        #(CLK_PERIOD * 124); //2 clk cycles to get to sync, 64 to complete, 56 to get through 7 bits of data
        check_outs(tb_expected_error,tb_expected_transfer_active,
        tb_expected_get_tx_data,
        tb_expected_dplus_out,
        tb_expected_dminus_out, tb_test_case, "After attempting to read data");
        #(CLK_PERIOD * 3);
        reset_dut();
    end 
endmodule