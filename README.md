
# USB Full-Speed Bulk-Transfer Endpoint AHB-Lite SoC Module

A guide to the project files for the cooperative design lab in ECE33700.

## Team Members

 - Parth R. Doshi
 - Austin Bohlmann
 - Abhiram Saridena

## Documentation

All files for this project can be found in
```
  ~mg121/ece337/cdl
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
- rcv_usb.sv - top level file for usb rx
- rcv_timer.sv - timer for rcv
- rcv_sync_low.sv - low synchronizer for rx
- rcv_sync_high.sv - high synchronizer for rx
- rcv_rcu.sv - rx control unit
- rcv_flex_stp_sr.sv - serial to parallel shift register
- rcv_flex_counter.sv - flexible counter for rx
- rcv_eop_detector.sv - detects end of packet for rx
- rcv_edge_detector.sv - detects an edge input from d_minus, d_plus
- rcv_decoder.sv - uses NRZI decoding
- tb_rcv_usb.sv - testbench for USB RX

#### Reports/
- ahb_lite_slave_cdl.log - synthesis report file for AHB_Lite design
- rcv_usb.rep - synthesis report file for USB RX
- rcv_usb.do - waveform for USB RX

