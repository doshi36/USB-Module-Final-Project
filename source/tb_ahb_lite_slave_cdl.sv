`timescale 1ns / 10ps

module tb_ahb_lite_slave_cdl();

// Timing related constants
localparam CLK_PERIOD = 10;
localparam BUS_DELAY  = 800ps; // Based on FF propagation delay

// Sizing related constants
localparam DATA_WIDTH      = 4;
localparam ADDR_WIDTH      = 4;
localparam DATA_WIDTH_BITS = DATA_WIDTH * 8;
localparam DATA_MAX_BIT    = DATA_WIDTH_BITS - 1;
localparam ADDR_MAX_BIT    = ADDR_WIDTH - 1;

// HTRANS Codes
localparam TRANS_IDLE = 2'd0;
localparam TRANS_BUSY = 2'd1;
localparam TRANS_NSEQ = 2'd2;
localparam TRANS_SEQ  = 2'd3;

// HBURST Codes
localparam BURST_SINGLE = 3'd0;
localparam BURST_INCR   = 3'd1;
localparam BURST_WRAP4  = 3'd2;
localparam BURST_INCR4  = 3'd3;
localparam BURST_WRAP8  = 3'd4;
localparam BURST_INCR8  = 3'd5;
localparam BURST_WRAP16 = 3'd6;
localparam BURST_INCR16 = 3'd7;

// Define our address mapping scheme via constants
localparam ADDR_READ_MIN  = 8'd0;
localparam ADDR_READ_MAX  = 8'd127;
localparam ADDR_WRITE_MIN = 8'd64;
localparam ADDR_WRITE_MAX = 8'd255;

//*****************************************************************************
// Declare TB Signals (Bus Model Controls)
//*****************************************************************************
// Testing setup signals
bit                          tb_enqueue_transaction;
bit                          tb_transaction_write;
bit                          tb_transaction_fake;
bit [(ADDR_WIDTH - 1):0]     tb_transaction_addr;
bit [((DATA_WIDTH*8) - 1):0] tb_transaction_data [];
bit [2:0]                    tb_transaction_burst;
bit                          tb_transaction_error;
bit [2:0]                    tb_transaction_size;
// Testing control signal(s)
logic    tb_model_reset;
logic    tb_enable_transactions;
integer  tb_current_addr_transaction_num;
integer  tb_current_addr_beat_num;
logic    tb_current_addr_transaction_error;
integer  tb_current_data_transaction_num;
integer  tb_current_data_beat_num;
logic    tb_current_data_transaction_error;

string                 tb_test_case;
integer                tb_test_case_num;
bit   [DATA_MAX_BIT:0] tb_test_data [];
string                 tb_check_tag;
logic                  tb_mismatch;
logic                  tb_check;
integer                tb_i;

//*****************************************************************************
// General System signals
//*****************************************************************************
logic tb_clk;
logic tb_n_rst;

//*****************************************************************************
// AHB-Lite-Slave side signals
//*****************************************************************************
logic                          tb_hsel;
logic [1:0]                    tb_htrans;
logic [2:0]                    tb_hburst;
logic [(ADDR_WIDTH - 1):0]     tb_haddr;
logic [2:0]                    tb_hsize;
logic                          tb_hwrite;
logic [((DATA_WIDTH*8) - 1):0] tb_hwdata;
logic [((DATA_WIDTH*8) - 1):0] tb_hrdata;
logic                          tb_hresp;
logic                          tb_hready;

logic                          tb_clear;
logic                          tb_Get_RX_Data;
logic                          tb_Store_TX_Data;
logic                          tb_TX_Error;
logic                          tb_RX_Error;
logic                          [6:0] tb_Buffer_Occupancy;
logic                          tb_RX_Transfer_Active;
logic                          tb_TX_Transfer_Active;
logic                          [2:0] tb_TX_Packet;
logic                          [2:0] tb_RX_Packet;
logic                          tb_RX_Data_Ready;
logic                          tb_D_mode;
logic                          [7:0] tb_TX_Data;
logic                          [7:0] tb_RX_Data;

//*****************************************************************************
// Clock Generation Block
//*****************************************************************************
// Clock generation block
always begin
  // Start with clock low to avoid false rising edge events at t=0
  tb_clk = 1'b0;
  // Wait half of the clock period before toggling clock value (maintain 50% duty cycle)
  #(CLK_PERIOD/2.0);
  tb_clk = 1'b1;
  // Wait half of the clock period before toggling clock value via rerunning the block (maintain 50% duty cycle)
  #(CLK_PERIOD/2.0);
end

//*****************************************************************************
// Bus Model Instance
//*****************************************************************************
ahb_lite_bus_cdl 
              #(  .DATA_WIDTH(4),
                  .ADDR_WIDTH(4))
              BFM(.clk(tb_clk),
                  // Testing setup signals
                  .enqueue_transaction(tb_enqueue_transaction),
                  .transaction_write(tb_transaction_write),
                  .transaction_fake(tb_transaction_fake),
                  .transaction_addr(tb_transaction_addr),
                  .transaction_size(tb_transaction_size),
                  .transaction_data(tb_transaction_data),
                  .transaction_burst(tb_transaction_burst),
                  .transaction_error(tb_transaction_error),
                  // Testing controls
                  .model_reset(tb_model_reset),
                  .enable_transactions(tb_enable_transactions),
                  .current_addr_transaction_num(tb_current_addr_transaction_num),
                  .current_addr_beat_num(tb_current_addr_beat_num),
                  .current_addr_transaction_error(tb_current_addr_transaction_error),
                  .current_data_transaction_num(tb_current_data_transaction_num),
                  .current_data_beat_num(tb_current_data_beat_num),
                  .current_data_transaction_error(tb_current_data_transaction_error),
                  // AHB-Lite-Slave Side
                  .hsel(tb_hsel),
                  .haddr(tb_haddr),
                  .hsize(tb_hsize),
                  .htrans(tb_htrans),
                  .hburst(tb_hburst),
                  .hwrite(tb_hwrite),
                  .hwdata(tb_hwdata),
                  .hrdata(tb_hrdata),
                  .hresp(tb_hresp),
                  .hready(tb_hready));

//*****************************************************************************
// Test Module Instance
//*****************************************************************************
ahb_lite_slave_cdl TM ( .clk(tb_clk), .n_rst(tb_n_rst),
                        // AHB-Lite-Slave Side Bus
                        .hsel(tb_hsel),
                        .haddr(tb_haddr),
                        .hsize(tb_hsize[1:0]),
                        .htrans(tb_htrans),
                        .hwrite(tb_hwrite),
                        .hwdata(tb_hwdata),
                        .hrdata(tb_hrdata),
                        .hresp(tb_hresp),
                        .hready(tb_hready),
                        .tx_error(tb_TX_Error),
                        .rx_error(tb_RX_Error),
                        .tx_transfer_active(tb_TX_Transfer_Active),
                        .rx_transfer_active(tb_RX_Transfer_Active),
                        .clear(tb_clear),
                        .tx_data(tb_TX_Data),
                        .rx_data(tb_RX_Data),
                        .rx_data_ready(tb_RX_Data_Ready),
                        .buffer_occ(tb_Buffer_Occupancy),
                        .get_rx_data(tb_Get_RX_Data),
                        .store_tx_data(tb_Store_TX_Data),
                        .d_mode(tb_D_mode),
                        .tx_packet(tb_TX_Packet),
                        .rx_packet(tb_RX_Packet)
                        );

//*****************************************************************************
// DUT Related TB Tasks
//*****************************************************************************
// Task for standard DUT reset procedure
task reset_dut;
begin
  // Activate the reset
  tb_n_rst = 1'b0;

  // Maintain the reset for more than one cycle
  @(posedge tb_clk);
  @(posedge tb_clk);

  // Wait until safely away from rising edge of the clock before releasing
  @(negedge tb_clk);
  tb_n_rst = 1'b1;

  // Leave out of reset for a couple cycles before allowing other stimulus
  // Wait for negative clock edges, 
  // since inputs to DUT should normally be applied away from rising clock edges
  @(negedge tb_clk);
  @(negedge tb_clk);
end
endtask

//*****************************************************************************
// Bus Model Usage Related TB Tasks
//*****************************************************************************
// Task to pulse the reset for the bus model
task reset_model;
begin
  tb_model_reset = 1'b1;
  #(0.1);
  tb_model_reset = 1'b0;
end
endtask

// Task to enqueue a new transaction
task enqueue_transaction;
  input bit for_dut;
  input bit write_mode;
  input bit [ADDR_MAX_BIT:0] address;
  input bit [DATA_MAX_BIT:0] data [];
  input bit [2:0] burst_type;
  input bit expected_error;
  input bit [1:0] size;
begin
  // Make sure enqueue flag is low (will need a 0->1 pulse later)
  tb_enqueue_transaction = 1'b0;
  #0.1ns;

  // Setup info about transaction
  tb_transaction_fake  = ~for_dut;
  tb_transaction_write = write_mode;
  tb_transaction_addr  = address;
  tb_transaction_data  = data;
  tb_transaction_error = expected_error;
  tb_transaction_size  = {1'b0,size};
  tb_transaction_burst = burst_type;

  // Pulse the enqueue flag
  tb_enqueue_transaction = 1'b1;
  #0.1ns;
  tb_enqueue_transaction = 1'b0;
end
endtask

// Task to wait for multiple transactions to happen
task execute_transactions;
  input integer num_transactions;
  integer wait_var;
begin
  // Activate the bus model
  tb_enable_transactions = 1'b1;
  @(posedge tb_clk);

  // Process the transactions (all but last one overlap 1 out of 2 cycles
  for(wait_var = 0; wait_var < num_transactions; wait_var++) begin
    @(posedge tb_clk);
  end

  // Run out the last one (currently in data phase)
  @(posedge tb_clk);

  // Turn off the bus model
  @(negedge tb_clk);
  tb_enable_transactions = 1'b0;
end
endtask


//*****************************************************************************
//*****************************************************************************
// Main TB Process
//*****************************************************************************
//*****************************************************************************
initial begin
  // Initialize Test Case Navigation Signals
  tb_test_case       = "Initialization";
  tb_test_case_num   = -1;
  tb_test_data       = new[1];
  tb_check_tag       = "N/A";
  tb_check           = 1'b0;
  tb_mismatch        = 1'b0;
  // Initialize all of the directly controled DUT inputs
  tb_n_rst          = 1'b1;
  // Initialize all of the bus model control inputs
  tb_model_reset          = 1'b0;
  tb_enable_transactions  = 1'b0;
  tb_enqueue_transaction  = 1'b0;
  tb_transaction_write    = 1'b0;
  tb_transaction_fake     = 1'b0;
  tb_transaction_addr     = '0;
  tb_transaction_data     = new[1];
  tb_transaction_error    = 1'b0;
  tb_transaction_size     = 3'd0;
  tb_transaction_burst    = 3'd0;

  tb_TX_Transfer_Active   = 0;
  tb_TX_Error             = 0;

  tb_RX_Error             = 0;
  tb_RX_Data_Ready        = 0;
  tb_RX_Transfer_Active   = 0;
  tb_RX_Packet            = 0;
  tb_Buffer_Occupancy     = 0;

  tb_RX_Data              = 0;


  // Wait some time before starting first test case
  #(0.1);

  // Clear the bus model
  reset_model();

  //*****************************************************************************
  // Power-on-Reset Test Case
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Power-on-Reset";
  tb_test_case_num = tb_test_case_num + 1;
  
  // Reset the DUT
  reset_dut();

  // No actual DUT -> Just a place holder currently
  
  //*****************************************************************************
  // Test Case: Singleton Write
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Single Word Write";
  tb_test_case_num = tb_test_case_num + 1;

  // Reset the DUT to isolate from prior test case
  reset_dut();

  // Enqueue the needed transactions
  tb_test_data = '{32'hFFFFFFFF}; 
  enqueue_transaction(1'b1, 1'b1, 4'h0, tb_test_data, BURST_SINGLE, 1'b0, 2'd2);
  
  // Run the transactions via the model
  execute_transactions(1);

  #(CLK_PERIOD * 10)

  //*****************************************************************************
  // Test Case: Singleton Write
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Single Half-Word Write";
  tb_test_case_num = tb_test_case_num + 1;

  // Reset the DUT to isolate from prior test case
  reset_dut();

  // Enqueue the needed transactions
  tb_test_data = '{32'hABCD9876}; 
  enqueue_transaction(1'b1, 1'b1, 4'd2, tb_test_data, BURST_SINGLE, 1'b0, 2'd1);
  
  // Run the transactions via the model
  execute_transactions(1);

  #(CLK_PERIOD * 10)

  //*****************************************************************************
  // Test Case: Singleton Write
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Single byte Read";
  tb_test_case_num = tb_test_case_num + 1;

  // Reset the DUT to isolate from prior test case
  reset_dut();

  // Enqueue the needed transactions
  tb_test_data = '{32'hABCD9876}; 
  enqueue_transaction(1'b1, 1'b1, 4'd0, tb_test_data, BURST_SINGLE, 1'b0, 2'd0);
  
  // Run the transactions via the model
  execute_transactions(1);

  #(CLK_PERIOD * 10)

  //*****************************************************************************
  // Test Case: Singleton Write
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Single Half-Word Read";
  tb_test_case_num = tb_test_case_num + 1;

  // Reset the DUT to isolate from prior test case
  reset_dut();

  // Enqueue the needed transactions
  tb_Buffer_Occupancy = 1;
  tb_test_data = '{32'hABAB}; 
  tb_RX_Data = 8'hAB;
  enqueue_transaction(1'b1, 1'b0, 4'd0, tb_test_data, BURST_SINGLE, 1'b0, 2'd2);
  tb_RX_Data = 8'hAB;
  enqueue_transaction(1'b1, 1'b0, 4'd0, tb_test_data, BURST_SINGLE, 1'b0, 2'd2);
  tb_RX_Data = 8'hAB;
  enqueue_transaction(1'b1, 1'b0, 4'd0, tb_test_data, BURST_SINGLE, 1'b0, 2'd2);
  tb_RX_Data = 8'hAB;
  enqueue_transaction(1'b1, 1'b0, 4'd0, tb_test_data, BURST_SINGLE, 1'b0, 2'd2);
  // Run the transactions via the model
  execute_transactions(4);

  #(CLK_PERIOD * 10)
  tb_RX_Data = 0;
  tb_Buffer_Occupancy = 0;

  //*****************************************************************************
  // Test Case: Write and read size 2 to TX Packet Contorl register and Flush Buffer Control Register
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Two byte write to addres C and D";
  tb_test_case_num = tb_test_case_num + 1;

  // Reset the DUT to isolate from prior test case
  reset_dut();

  // Enqueue the needed transactions
  tb_test_data = '{32'hEF}; 
  enqueue_transaction(1'b1, 1'b1, 4'hc, tb_test_data, BURST_SINGLE, 1'b0, 2'd0);
  tb_test_data = '{32'hBE}; 
  enqueue_transaction(1'b1, 1'b1, 4'hd, tb_test_data, BURST_SINGLE, 1'b0, 2'd0);
  // Run the transactions via the model
  execute_transactions(2);
  #(CLK_PERIOD * 10);
  // read 
  tb_test_data = '{32'hEF}; 
  enqueue_transaction(1'b1, 1'b0, 4'hc, tb_test_data, BURST_SINGLE, 1'b0, 2'd0);
  tb_test_data = '{32'hBE}; 
  enqueue_transaction(1'b1, 1'b0, 4'hd, tb_test_data, BURST_SINGLE, 1'b0, 2'd0);
  // Run the transactions via the model
  execute_transactions(1);


  //*****************************************************************************
  // Test Case: Back-to-Back Write/Read
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Back to back Write/Read";
  tb_test_case_num = tb_test_case_num + 1;

  // Reset the DUT to isolate from prior test case
  reset_dut();

  // Enqueue the needed transactions
  tb_test_data = '{32'h8000ABCD};
  // Enqueue the write
  enqueue_transaction(1'b1, 1'b1, 8'hd, tb_test_data, BURST_SINGLE, 1'b0, 2'd0);
  // Enqueue the 'check' read
  tb_test_data = '{32'hCD};
  enqueue_transaction(1'b1, 1'b0, 8'hd, tb_test_data, BURST_SINGLE, 1'b0, 2'd0);
  
  // Run the transactions via the model
  execute_transactions(2);

  #(CLK_PERIOD * 10)
  
  //*****************************************************************************
  // Test Case: Erroneous Singleton Write
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Erroneous Single Word Write";
  tb_test_case_num = tb_test_case_num + 1;

  // Reset the DUT to isolate from prior test case
  reset_dut();

  // Enqueue the needed transactions
  tb_test_data = '{32'd1000}; 
  enqueue_transaction(1'b1, 1'b1, 8'hf, tb_test_data, BURST_SINGLE, 1'b1, 2'd2);
  
  // Run the transactions via the model
  execute_transactions(1);


//*****************************************************************************
  // Test Case: Erroneous Singleton Read
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Erroneous Single Word Read";
  tb_test_case_num = tb_test_case_num + 1;

  // Reset the DUT to isolate from prior test case
  reset_dut();

  // Enqueue the needed transactions
  tb_test_data = '{32'h9}; 
  enqueue_transaction(1'b1, 1'b0, 8'hf, tb_test_data, BURST_SINGLE, 1'b1, 2'd2);
  
  // Run the transactions via the model
  execute_transactions(1);

   $stop();
end

endmodule