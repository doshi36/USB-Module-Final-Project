
# USB Full-Speed Bulk-Transfer Endpoint AHB-Lite SoC Module

A guide to the project files for the cooperative design lab in ECE33700.

## Team Members

 - Parth R. Doshi
 - Austin Bohlmann
 - Abhiram Saridena

## Documentation

All files for this project can be found in
```
  ~mg103/ece337/cdl
```
#### Source/
- ahb_lite_slave_cdl.sv - top level code for AHB_Lite 
- tb_ahb_lite_slave_cdl.sv - testbench for testing design of AHB_Lite
- tx_top.sv - top level code for USB TX
- tx_timer.sv - timing control for USB TX
- tx_pisoreg.sv - PISO shift register for USB TX
- tx_fsm.sv - state machine controlling flags and outputs for USB TX
- tx_encoder.sv - encodes transmitted data stream for TX
- tb_tx_top.sv - testbench for testing design of TX
- tb_buffer.sv - testbench for testing data buffer
- db_write.sv - Data buffer writing controller block
- db_read.sv - Data buffer reading controller block
- db_fifo - FIFO RAM  for data buffer
- buffer.sv - top level code for data buffer

#### Reports/
- ahb_lite_slave_cdl.log - synthesis report file for AHB_Lite design

