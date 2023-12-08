onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_rcv_usb/tb_clk
add wave -noupdate /tb_rcv_usb/tb_n_rst
add wave -noupdate /tb_rcv_usb/tb_test_num
add wave -noupdate -color Wheat /tb_rcv_usb/tb_test_case
add wave -noupdate -expand -group {FSM Operations} -color Cyan /tb_rcv_usb/DUT/final_mod8/state
add wave -noupdate -group DATA /tb_rcv_usb/tb_d_plus
add wave -noupdate -group DATA /tb_rcv_usb/tb_d_minus
add wave -noupdate -group DATA /tb_rcv_usb/DUT/d_plus_sync
add wave -noupdate -group DATA /tb_rcv_usb/DUT/d_minus_sync
add wave -noupdate -group DATA /tb_rcv_usb/DUT/d_prim
add wave -noupdate -group FLUSH /tb_rcv_usb/tb_expected_flush
add wave -noupdate -group FLUSH -color Yellow /tb_rcv_usb/DUT/flush
add wave -noupdate -group {DATA READY} /tb_rcv_usb/tb_expected_rx_data_ready
add wave -noupdate -group {DATA READY} -color Yellow /tb_rcv_usb/DUT/rx_data_ready
add wave -noupdate -group {RX ERROR} /tb_rcv_usb/tb_expected_rx_error
add wave -noupdate -group {RX ERROR} -color Yellow /tb_rcv_usb/DUT/rx_error
add wave -noupdate -expand -group {RX PACKET DATA} /tb_rcv_usb/tb_expected_rx_packet_data
add wave -noupdate -expand -group {RX PACKET DATA} -color Yellow /tb_rcv_usb/DUT/rx_packet_data
add wave -noupdate -group {RX PACKET} -radix decimal /tb_rcv_usb/tb_expected_rx_packet
add wave -noupdate -group {RX PACKET} -color Yellow -radix unsigned /tb_rcv_usb/DUT/rx_packet
add wave -noupdate -group {RX TRANSFER ACTIVE} /tb_rcv_usb/tb_expected_rx_transfer_active
add wave -noupdate -group {RX TRANSFER ACTIVE} -color Yellow /tb_rcv_usb/DUT/rx_transfer_active
add wave -noupdate -group {STORE RX PACKET DATA} /tb_rcv_usb/tb_expected_store_rx_packet_data
add wave -noupdate -group {STORE RX PACKET DATA} -color Yellow /tb_rcv_usb/DUT/store_rx_packet_data
add wave -noupdate -group {INTERMEDIATE SIGNALS} -color Red /tb_rcv_usb/DUT/byte_finish
add wave -noupdate -group {INTERMEDIATE SIGNALS} -color Red /tb_rcv_usb/DUT/eop
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1720159 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 260
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {3830800 ps}
