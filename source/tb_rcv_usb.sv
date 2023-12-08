// File name:   tb_rcv_usb.sv
// Created:     12/6/23
// Author:      Parth R. Doshi
// Lab Section: 337
// Description: // Testbench for USB_RX

`timescale 1ns/100ps

module tb_rcv_usb();

    parameter CLK_P        = 10;
    parameter DATA_P  = (10 * CLK_P);
    string tb_test_case;
    integer tb_test_num;

    logic tb_clk, tb_n_rst;
    logic tb_d_plus, tb_d_minus;
    logic tb_flush, tb_rx_transfer_active, tb_rx_data_ready, tb_rx_error, tb_store_rx_packet_data;
    logic [2:0] tb_rx_packet;
    logic [7:0] tb_rx_packet_data;
    
    //DUT - Power-on-Reset - TASK 

    task reset_dut; begin
		tb_n_rst = 1'b0;
		
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(negedge tb_clk);

		tb_n_rst = 1;
    tb_d_plus = 1;
    tb_d_minus = 0;
		
		@(posedge tb_clk);
		@(posedge tb_clk);
	  end

	  endtask

  
	  always begin : MY_CLK

      tb_clk = 1'b0;
      #(CLK_P / 2.0);

      tb_clk = 1'b1;
      #(CLK_P / 2.0);

	  end

    //Send EOP Task

    task eop_task_send;
    
    begin
      @(negedge tb_clk) 
      tb_d_minus = 1'b0;
      tb_d_plus = 1'b0;
      #(16 * CLK_P);

      @(negedge tb_clk)
      tb_d_plus = 1'b1;
      tb_d_minus = 1'b0;
      #(8* CLK_P);

      @(negedge tb_clk)
      #(CLK_P);

      @(negedge tb_clk)
      #(CLK_P); 
    end
    endtask

    //TASK - Send Data Packet

    task send_data_pckt;
        input  [7:0] data;
        integer j;
    begin
        @(negedge tb_clk)
        
        for(j = 0; j <= 7; j += 1) begin

          if(data[j] == 0) begin
              tb_d_plus = ~tb_d_plus;
              tb_d_minus = ~tb_d_minus;
          end 
          else begin
              tb_d_plus = tb_d_plus;
              tb_d_minus = tb_d_minus; 
          end

          $info("j: %d, d_plus: %d, d_minus: %d" , j, tb_d_plus, tb_d_minus);

          #(CLK_P*8);
        end
        
    end
    endtask

    //TASK - Send Data Packet 

    task stream_packet;
      integer k;
    begin
      for(k = 0; k < 64; k += 1) begin
        send_data_pckt(8'b01010101);
      end
    end
    endtask

    //TASK - Send Data with Payload size > 64 bytes 

    task stream_packet_65;
      integer i;
    begin
      for(i = 0; i < 66; i += 1) begin
        send_data_pckt(8'b01010101);
      end
    end
    endtask


    /****************************************************************************
    **** Expected Value and Check Output
    *****************************************************************************/
    logic tb_expected_store_rx_packet_data, tb_expected_rx_transfer_active, tb_expected_rx_error, tb_expected_flush, tb_expected_rx_data_ready;
    logic [2:0] tb_expected_rx_packet;
    logic [7:0] tb_expected_rx_packet_data;

    task check_output;
  
    begin    

    assert(tb_rx_packet_data == tb_expected_rx_packet_data)
      $info("TEST %0d: Payload Data correctly received! ", tb_test_num);
    else
      $error("TEST %0d: Payload Data not correctly received! ", tb_test_num);
    
    if(tb_expected_rx_transfer_active == 1'b0) begin
      assert(tb_rx_transfer_active == 1'b0)
        $info("TEST %0d: DUT correctly asserted rx_transfer_active == 1", tb_test_num);
      else
        $error("TEST %0d: DUT not correctly asserted rx_transfer_active == 1", tb_test_num);
    end 
    else begin
        assert(1'b1 == tb_expected_rx_transfer_active)
        $info("TEST %0d: DUT correctly asserted rx_transfer_active == 1", tb_test_num);
        else
        $error("TEST %0d: DUT not correctly assert rx_transfer_active == 1", tb_test_num);
    end 

    if(1'b1 == tb_expected_store_rx_packet_data) begin
      assert(1'b1 == tb_store_rx_packet_data)
        $info("TEST %0d: DUT correctly outputs store signal", tb_test_num);
      else
        $error("TEST %0d: DUT not correctly output store signal", tb_test_num);
    end 
    else begin
      assert(1'b0 == tb_expected_store_rx_packet_data)
        $info("TEST %0d: DUT correctly outputs store signal", tb_test_num);
      else
        $error("TEST %0d: DUT not correctly output store signal", tb_test_num);
    end 

    if(tb_expected_rx_data_ready == 'b1) begin
      assert(1'b1 == tb_rx_data_ready)

        $info("TEST %0d: DUT correctly output rready", tb_test_num);
      else 
        $error("TEST %0d: DUT not correctly output rready", tb_test_num);
    end 
    else begin
        assert(1'b0 == tb_rx_data_ready)
        $info("TEST %0d: DUT correctly output rready", tb_test_num);
      else 
        $error("TEST %0d: DUT not correctly output rready", tb_test_num);
    end 

    if(tb_expected_flush == 1'b1) begin
      assert(tb_flush == 1'b1)
        $info("TEST %0d: DUT correctly outputs flush == 1'b1", tb_test_num);
      else 
        $error("TEST %0d: DUT not correctly outputs flush", tb_test_num);
    end 
    else begin
      assert(tb_flush == 1'b0)
        $info("TEST %0d: DUT correctly outputs flush == 1'b0", tb_test_num);
      else 
        $error("Test %0d: DUT not correctly outputs flush", tb_test_num);
    end

    if(tb_expected_rx_error == 'b1) begin
      assert(tb_rx_error == 'b1)
        $info("TEST %0d: DUT correctly outputs rx_error == 1'b1", tb_test_num);
      else
        $error("TEST %0d: DUT not correctly outputs error", tb_test_num);
    end 
    else begin
      assert(tb_rx_error == 1'b0)
        $info("TEST %0d: DUT correctly outputs rx_error == 1'b0", tb_test_num);
      else
        $error("TEST %0d: DUT not correctly outputs a error", tb_test_num);
    end 
    
    
  end 
  endtask
    
  rcv_usb DUT(

      .clk(tb_clk),                                   
      .n_rst(tb_n_rst),

      .d_plus_in(tb_d_plus),                            //Input
      .d_minus_in(tb_d_minus),                          //Input
      
      .flush(tb_flush),
      .store_rx_packet_data(tb_store_rx_packet_data),   //Output
      .rx_transfer_active(tb_rx_transfer_active),       //Output
      .rx_packet(tb_rx_packet),                         //Output
      .rx_packet_data(tb_rx_packet_data),               //Output
      .rx_data_ready(tb_rx_data_ready),                 //Output
      .rx_error(tb_rx_error)                            //Output

  );

  initial 
  begin 
  
  tb_test_num = -1;
  tb_expected_store_rx_packet_data = 1'b0;
  tb_expected_flush = 1'b0;

  tb_expected_rx_transfer_active = 1'b0;
  tb_expected_rx_error = 1'b0;
  tb_expected_rx_packet = 'h0;
  tb_expected_rx_packet_data = 8'b11111111;
  tb_expected_rx_data_ready = 1'b0;
  tb_n_rst = 1'b1;

  #(0.1);

  tb_test_num = 0;

  /*******************************************************************************
  ** Test 1 : DUT Power-On-Reset
  *******************************************************************************/
  #(0.1);
  tb_n_rst = 1'b1;
  tb_test_num = 0;
  tb_test_case = "DUT RESET";
  reset_dut;

  #(16 * CLK_P)
  check_output;

    /*********************************************************************************
  ** Test 2: Flush Assertion
  *********************************************************************************/
  tb_test_num = 1; 
  tb_test_case = "FLUSH";
  tb_d_plus = 1'b1;
  tb_d_minus = 1'b0;
  tb_n_rst = 1; 
  reset_dut;
  tb_expected_rx_packet_data = 8'b00000001;
  send_data_pckt(8'b10000000);

  tb_expected_rx_packet_data = 8'b11000011;
  send_data_pckt(8'b11000011);

  tb_expected_rx_packet_data = 8'b01010101;
  stream_packet_65;
  tb_expected_flush = 1'b1;

  /*******************************************************************************
  ** Test 3: VALID ACK
  ********************************************************************************/
  tb_test_num = 2; 
  tb_test_case = "VALID ACK";
  tb_d_plus = 1'b1;
  tb_d_minus = 1'b0;
  tb_n_rst = 1; 
  reset_dut;

  tb_expected_rx_packet_data = 8'b00000001;
  send_data_pckt(8'b10000000);
  tb_expected_rx_packet_data = 8'b01001011;
  send_data_pckt(8'b11010010);

  eop_task_send;
  
  /*******************************************************************************
  ** Test 4: VALID NAK
  ********************************************************************************/
  tb_test_num = 3; 
  tb_test_case = "VALID NAK";
  tb_d_plus = 1'b1;
  tb_d_minus = 1'b0;
  tb_n_rst = 1; 
  reset_dut;

  tb_expected_rx_packet_data = 8'b00000001;
  send_data_pckt(8'b10000000);
  tb_expected_rx_packet_data = 8'b01011010;
  send_data_pckt(8'b01011010);

  eop_task_send;

  /*******************************************************************************
  ** Test 5: VALID OUT
  ********************************************************************************/
  tb_test_num = 4; 
  tb_test_case = "VALID OUT";
  tb_d_plus = 1'b1;
  tb_d_minus = 1'b0;
  tb_n_rst = 1; 
  reset_dut;

  tb_expected_rx_packet_data = 8'b00000001;
  send_data_pckt(8'b10000000);
  tb_expected_rx_packet_data = 8'b10010110;
  send_data_pckt(8'b01101001);

  eop_task_send;

  /*******************************************************************************
  ** Test 6: VALID IN
  ********************************************************************************/
  tb_test_num = 5; 
  tb_test_case = "VALID IN";

  tb_d_plus = 1'b1;
  tb_d_minus = 1'b0;
  tb_n_rst = 1; 
  reset_dut;
  tb_expected_rx_packet_data = 8'b00000001;
  send_data_pckt(8'b10000000);
  tb_expected_rx_packet_data = 8'b10000111;
  send_data_pckt(8'b11100001);

  eop_task_send;

  /*********************************************************************************
  ** Test 7: VALID DATA0/DATA1
  *********************************************************************************/
  tb_test_num = 6; 
  tb_test_case = "VALID DATA0/DATA1";
  tb_d_plus = 1'b1;
  tb_d_minus = 1'b0;
  tb_n_rst = 1; 
  reset_dut;
  tb_expected_rx_packet_data = 8'b00000001;
  send_data_pckt(8'b10000000);
  tb_expected_rx_packet_data = 8'b11000011;
  send_data_pckt(8'b11000011);

  tb_expected_rx_packet_data = 8'b01010101;
  stream_packet;

  eop_task_send;

  /*********************************************************************************
  ** Test 7: INVALID SYNC
  *********************************************************************************/
  tb_test_num = 7; 
  tb_test_case = "INVALID SYNC";
  tb_d_plus = 1'b1;
  tb_d_minus = 1'b0;
  tb_n_rst = 1; 
  reset_dut;

  tb_expected_rx_packet_data = 8'b00000011;
  send_data_pckt(8'b11000000);

  tb_expected_rx_error = 1'b1;
  eop_task_send;

  /*********************************************************************************
  ** Test 8: INVALID PID
  *********************************************************************************/
  tb_test_num = 8; 
  tb_test_case = "INVALID PID";
  tb_d_plus = 1'b1;
  tb_d_minus = 1'b0;
  tb_n_rst = 1; 
  reset_dut;

  tb_expected_rx_packet_data = 8'b00000001;
  send_data_pckt(8'b10000000);
  tb_expected_rx_packet_data = 8'b10111111;
  send_data_pckt(8'b11111101);

  tb_expected_rx_error = 1'b1;
  eop_task_send;

  $stop;

  end
endmodule