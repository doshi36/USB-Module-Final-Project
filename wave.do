onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_ahb_lite_slave_cdl/tb_Buffer_Occupancy
add wave -noupdate /tb_ahb_lite_slave_cdl/tb_check
add wave -noupdate /tb_ahb_lite_slave_cdl/tb_check_tag
add wave -noupdate /tb_ahb_lite_slave_cdl/tb_n_rst
add wave -noupdate /tb_ahb_lite_slave_cdl/tb_clk
add wave -noupdate -radix hexadecimal /tb_ahb_lite_slave_cdl/tb_hready
add wave -noupdate -group {RX signals} /tb_ahb_lite_slave_cdl/tb_Get_RX_Data
add wave -noupdate -group {RX signals} /tb_ahb_lite_slave_cdl/tb_RX_Data
add wave -noupdate -group {RX signals} /tb_ahb_lite_slave_cdl/tb_RX_Data_Ready
add wave -noupdate -group {RX signals} /tb_ahb_lite_slave_cdl/tb_RX_Error
add wave -noupdate -group {RX signals} /tb_ahb_lite_slave_cdl/tb_RX_Packet
add wave -noupdate -group {RX signals} /tb_ahb_lite_slave_cdl/tb_RX_Transfer_Active
add wave -noupdate -group {TX Signals} /tb_ahb_lite_slave_cdl/tb_Store_TX_Data
add wave -noupdate -group {TX Signals} /tb_ahb_lite_slave_cdl/tb_TX_Data
add wave -noupdate -group {TX Signals} /tb_ahb_lite_slave_cdl/tb_TX_Error
add wave -noupdate -group {TX Signals} /tb_ahb_lite_slave_cdl/tb_TX_Packet
add wave -noupdate -group {TX Signals} /tb_ahb_lite_slave_cdl/tb_TX_Transfer_Active
add wave -noupdate -group h-signals -radix hexadecimal /tb_ahb_lite_slave_cdl/tb_hburst
add wave -noupdate -group h-signals -radix hexadecimal /tb_ahb_lite_slave_cdl/tb_hresp
add wave -noupdate -group h-signals -radix hexadecimal /tb_ahb_lite_slave_cdl/tb_hsel
add wave -noupdate -group h-signals -radix hexadecimal /tb_ahb_lite_slave_cdl/tb_hsize
add wave -noupdate -group h-signals -radix hexadecimal /tb_ahb_lite_slave_cdl/tb_htrans
add wave -noupdate -group h-signals -radix hexadecimal /tb_ahb_lite_slave_cdl/tb_hwrite
add wave -noupdate -group Data -radix hexadecimal /tb_ahb_lite_slave_cdl/tb_hrdata
add wave -noupdate -group Data /tb_ahb_lite_slave_cdl/tb_hwdata
add wave -noupdate /tb_ahb_lite_slave_cdl/tb_mismatch
add wave -noupdate /tb_ahb_lite_slave_cdl/tb_model_reset
add wave -noupdate /tb_ahb_lite_slave_cdl/tb_test_case
add wave -noupdate /tb_ahb_lite_slave_cdl/tb_test_case_num
add wave -noupdate /tb_ahb_lite_slave_cdl/TM/state
add wave -noupdate /tb_ahb_lite_slave_cdl/TM/write_select
add wave -noupdate -radix hexadecimal /tb_ahb_lite_slave_cdl/tb_haddr
add wave -noupdate /tb_ahb_lite_slave_cdl/tb_clear
add wave -noupdate /tb_ahb_lite_slave_cdl/tb_D_mode
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {95723 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {27176 ps} {119283 ps}
