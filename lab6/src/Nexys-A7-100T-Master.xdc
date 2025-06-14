## Clock signal
set_property PACKAGE_PIN E3 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

## Reset button
set_property PACKAGE_PIN C12 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]

## Control button
set_property PACKAGE_PIN M13 [get_ports control]
set_property IOSTANDARD LVCMOS33 [get_ports control]

## 7-segment display segments (active low)
set_property PACKAGE_PIN W7 [get_ports {seg1[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg1[0]}]
set_property PACKAGE_PIN W6 [get_ports {seg1[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg1[1]}]
set_property PACKAGE_PIN U8 [get_ports {seg1[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg1[2]}]
set_property PACKAGE_PIN V8 [get_ports {seg1[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg1[3]}]
set_property PACKAGE_PIN U5 [get_ports {seg1[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg1[4]}]
set_property PACKAGE_PIN V5 [get_ports {seg1[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg1[5]}]
set_property PACKAGE_PIN U7 [get_ports {seg1[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg1[6]}]

set_property PACKAGE_PIN V7 [get_ports {seg2[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg2[0]}]
set_property PACKAGE_PIN U2 [get_ports {seg2[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg2[1]}]
set_property PACKAGE_PIN U4 [get_ports {seg2[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg2[2]}]
set_property PACKAGE_PIN V4 [get_ports {seg2[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg2[3]}]
set_property PACKAGE_PIN W4 [get_ports {seg2[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg2[4]}]
set_property PACKAGE_PIN V5 [get_ports {seg2[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg2[5]}]
set_property PACKAGE_PIN U5 [get_ports {seg2[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg2[6]}] 