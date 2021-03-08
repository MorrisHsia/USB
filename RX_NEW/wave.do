onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_RX/DUT/clk
add wave -noupdate /tb_RX/DUT/n_rst
add wave -noupdate /tb_RX/DUT/Dplus
add wave -noupdate /tb_RX/DUT/Dminus
add wave -noupdate /tb_RX/DUT/packet_done
add wave -noupdate /tb_RX/DUT/receiving
add wave -noupdate /tb_RX/DUT/Dplus_sync
add wave -noupdate /tb_RX/DUT/Dminus_sync
add wave -noupdate /tb_RX/DUT/EOP
add wave -noupdate /tb_RX/DUT/Edge
add wave -noupdate /tb_RX/DUT/BIT
add wave -noupdate /tb_RX/DUT/sync_rst
add wave -noupdate /tb_RX/DUT/shift_stop
add wave -noupdate /tb_RX/DUT/shift_en
add wave -noupdate /tb_RX/DUT/crc_en
add wave -noupdate /tb_RX/DUT/clear
add wave -noupdate /tb_RX/DUT/byte_received
add wave -noupdate /tb_RX/DUT/part_received
add wave -noupdate /tb_RX/DUT/CRC16_result
add wave -noupdate /tb_RX/DUT/CRC5_result
add wave -noupdate /tb_RX/DUT/RX_Packet_Data
add wave -noupdate /tb_RX/DUT/Store_RX_Packet_Data
add wave -noupdate /tb_RX/DUT/RX_Packet
add wave -noupdate /tb_RX/DUT/D_parallel
add wave -noupdate /tb_RX/tb_test_num
add wave -noupdate /tb_RX/DUT/FSM/state
add wave -noupdate /tb_RX/DUT/FSM/nxt_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {12502922 ps} 0}
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
WaveRestoreZoom {0 ps} {1075410 ps}
