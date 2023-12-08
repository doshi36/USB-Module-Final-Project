/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Fri Dec  8 12:49:57 2023
/////////////////////////////////////////////////////////////


module rcv_sync_low ( clk, n_rst, async_in, sync_out );
  input clk, n_rst, async_in;
  output sync_out;
  wire   temp;

  DFFSR temp_reg ( .D(async_in), .CLK(clk), .R(n_rst), .S(1'b1), .Q(temp) );
  DFFSR sync_out_reg ( .D(temp), .CLK(clk), .R(n_rst), .S(1'b1), .Q(sync_out)
         );
endmodule


module rcv_sync_high ( clk, n_rst, async_in, sync_out );
  input clk, n_rst, async_in;
  output sync_out;
  wire   temp;

  DFFSR temp_reg ( .D(async_in), .CLK(clk), .R(1'b1), .S(n_rst), .Q(temp) );
  DFFSR sync_out_reg ( .D(temp), .CLK(clk), .R(1'b1), .S(n_rst), .Q(sync_out)
         );
endmodule


module rcv_flex_counter_NUM_CNT_BITS4_1 ( clk, n_rst, clear, count_enable, 
        rollover_val, count_out, rollover_flag );
  input [3:0] rollover_val;
  output [3:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   n50, n51, n52, n53, n54, n1, n2, n3, n4, n5, n6, n7, n8, n9, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44,
         n45;

  DFFSR \count_out_reg[0]  ( .D(n54), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR \count_out_reg[3]  ( .D(n51), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[3]) );
  DFFSR \count_out_reg[1]  ( .D(n53), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[1]) );
  DFFSR \count_out_reg[2]  ( .D(n52), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR rollover_flag_reg ( .D(n50), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        rollover_flag) );
  MUX2X1 U7 ( .B(n1), .A(n2), .S(n3), .Y(n54) );
  OAI21X1 U9 ( .A(n4), .B(n1), .C(n5), .Y(n2) );
  INVX1 U10 ( .A(n6), .Y(n4) );
  MUX2X1 U11 ( .B(n7), .A(n8), .S(n9), .Y(n53) );
  NAND2X1 U12 ( .A(n15), .B(count_out[0]), .Y(n8) );
  INVX1 U13 ( .A(n16), .Y(n52) );
  MUX2X1 U14 ( .B(n17), .A(n18), .S(n19), .Y(n16) );
  MUX2X1 U15 ( .B(n20), .A(n21), .S(n22), .Y(n51) );
  INVX1 U16 ( .A(count_out[3]), .Y(n22) );
  NAND2X1 U17 ( .A(n18), .B(count_out[2]), .Y(n21) );
  INVX1 U18 ( .A(n23), .Y(n18) );
  NAND3X1 U19 ( .A(count_out[1]), .B(count_out[0]), .C(n15), .Y(n23) );
  AOI21X1 U20 ( .A(n15), .B(n19), .C(n17), .Y(n20) );
  OAI21X1 U21 ( .A(count_out[1]), .B(n24), .C(n7), .Y(n17) );
  AOI21X1 U22 ( .A(n1), .B(n15), .C(n25), .Y(n7) );
  INVX1 U23 ( .A(count_out[2]), .Y(n19) );
  INVX1 U24 ( .A(n24), .Y(n15) );
  NAND3X1 U25 ( .A(n3), .B(n5), .C(n6), .Y(n24) );
  NAND3X1 U26 ( .A(n26), .B(n27), .C(n28), .Y(n6) );
  AOI21X1 U27 ( .A(rollover_val[1]), .B(n9), .C(n29), .Y(n28) );
  XNOR2X1 U28 ( .A(rollover_val[0]), .B(count_out[0]), .Y(n27) );
  XNOR2X1 U29 ( .A(count_out[3]), .B(rollover_val[3]), .Y(n26) );
  MUX2X1 U30 ( .B(n30), .A(n31), .S(n3), .Y(n50) );
  INVX1 U31 ( .A(n25), .Y(n3) );
  NOR2X1 U32 ( .A(count_enable), .B(clear), .Y(n25) );
  NAND3X1 U33 ( .A(n32), .B(n33), .C(n34), .Y(n31) );
  NOR2X1 U34 ( .A(n35), .B(n36), .Y(n34) );
  NAND2X1 U35 ( .A(n37), .B(n5), .Y(n36) );
  INVX1 U36 ( .A(clear), .Y(n5) );
  OAI21X1 U37 ( .A(n38), .B(n9), .C(n39), .Y(n37) );
  XNOR2X1 U38 ( .A(count_out[3]), .B(n40), .Y(n35) );
  OAI21X1 U39 ( .A(rollover_val[2]), .B(n41), .C(rollover_val[3]), .Y(n40) );
  MUX2X1 U40 ( .B(n42), .A(n29), .S(n41), .Y(n33) );
  INVX1 U41 ( .A(n39), .Y(n41) );
  OAI21X1 U42 ( .A(rollover_val[1]), .B(n9), .C(n38), .Y(n29) );
  XNOR2X1 U43 ( .A(count_out[2]), .B(rollover_val[2]), .Y(n38) );
  NOR2X1 U44 ( .A(rollover_val[3]), .B(rollover_val[2]), .Y(n42) );
  MUX2X1 U45 ( .B(n43), .A(n44), .S(rollover_val[0]), .Y(n32) );
  OAI21X1 U46 ( .A(count_out[1]), .B(n45), .C(n1), .Y(n44) );
  INVX1 U47 ( .A(count_out[0]), .Y(n1) );
  INVX1 U48 ( .A(rollover_val[1]), .Y(n45) );
  OAI21X1 U49 ( .A(n39), .B(n9), .C(count_out[0]), .Y(n43) );
  INVX1 U50 ( .A(count_out[1]), .Y(n9) );
  NOR2X1 U51 ( .A(rollover_val[0]), .B(rollover_val[1]), .Y(n39) );
  INVX1 U52 ( .A(rollover_flag), .Y(n30) );
endmodule


module rcv_flex_counter_NUM_CNT_BITS4_0 ( clk, n_rst, clear, count_enable, 
        rollover_val, count_out, rollover_flag );
  input [3:0] rollover_val;
  output [3:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n15, n16, n17, n18, n19, n20, n21,
         n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35,
         n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49,
         n51;

  DFFSR \count_out_reg[0]  ( .D(n46), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR \count_out_reg[3]  ( .D(n49), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[3]) );
  DFFSR \count_out_reg[1]  ( .D(n47), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[1]) );
  DFFSR \count_out_reg[2]  ( .D(n48), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR rollover_flag_reg ( .D(n51), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        rollover_flag) );
  MUX2X1 U7 ( .B(n1), .A(n2), .S(n3), .Y(n46) );
  OAI21X1 U9 ( .A(n4), .B(n1), .C(n5), .Y(n2) );
  INVX1 U10 ( .A(n6), .Y(n4) );
  MUX2X1 U11 ( .B(n7), .A(n8), .S(n9), .Y(n47) );
  NAND2X1 U12 ( .A(n15), .B(count_out[0]), .Y(n8) );
  INVX1 U13 ( .A(n16), .Y(n48) );
  MUX2X1 U14 ( .B(n17), .A(n18), .S(n19), .Y(n16) );
  MUX2X1 U15 ( .B(n20), .A(n21), .S(n22), .Y(n49) );
  INVX1 U16 ( .A(count_out[3]), .Y(n22) );
  NAND2X1 U17 ( .A(n18), .B(count_out[2]), .Y(n21) );
  INVX1 U18 ( .A(n23), .Y(n18) );
  NAND3X1 U19 ( .A(count_out[1]), .B(count_out[0]), .C(n15), .Y(n23) );
  AOI21X1 U20 ( .A(n15), .B(n19), .C(n17), .Y(n20) );
  OAI21X1 U21 ( .A(count_out[1]), .B(n24), .C(n7), .Y(n17) );
  AOI21X1 U22 ( .A(n1), .B(n15), .C(n25), .Y(n7) );
  INVX1 U23 ( .A(count_out[2]), .Y(n19) );
  INVX1 U24 ( .A(n24), .Y(n15) );
  NAND3X1 U25 ( .A(n3), .B(n5), .C(n6), .Y(n24) );
  NAND3X1 U26 ( .A(n26), .B(n27), .C(n28), .Y(n6) );
  AOI21X1 U27 ( .A(rollover_val[1]), .B(n9), .C(n29), .Y(n28) );
  XNOR2X1 U28 ( .A(rollover_val[0]), .B(count_out[0]), .Y(n27) );
  XNOR2X1 U29 ( .A(count_out[3]), .B(rollover_val[3]), .Y(n26) );
  MUX2X1 U30 ( .B(n30), .A(n31), .S(n3), .Y(n51) );
  INVX1 U31 ( .A(n25), .Y(n3) );
  NOR2X1 U32 ( .A(count_enable), .B(clear), .Y(n25) );
  NAND3X1 U33 ( .A(n32), .B(n33), .C(n34), .Y(n31) );
  NOR2X1 U34 ( .A(n35), .B(n36), .Y(n34) );
  NAND2X1 U35 ( .A(n37), .B(n5), .Y(n36) );
  INVX1 U36 ( .A(clear), .Y(n5) );
  OAI21X1 U37 ( .A(n38), .B(n9), .C(n39), .Y(n37) );
  XNOR2X1 U38 ( .A(count_out[3]), .B(n40), .Y(n35) );
  OAI21X1 U39 ( .A(rollover_val[2]), .B(n41), .C(rollover_val[3]), .Y(n40) );
  MUX2X1 U40 ( .B(n42), .A(n29), .S(n41), .Y(n33) );
  INVX1 U41 ( .A(n39), .Y(n41) );
  OAI21X1 U42 ( .A(rollover_val[1]), .B(n9), .C(n38), .Y(n29) );
  XNOR2X1 U43 ( .A(count_out[2]), .B(rollover_val[2]), .Y(n38) );
  NOR2X1 U44 ( .A(rollover_val[3]), .B(rollover_val[2]), .Y(n42) );
  MUX2X1 U45 ( .B(n43), .A(n44), .S(rollover_val[0]), .Y(n32) );
  OAI21X1 U46 ( .A(count_out[1]), .B(n45), .C(n1), .Y(n44) );
  INVX1 U47 ( .A(count_out[0]), .Y(n1) );
  INVX1 U48 ( .A(rollover_val[1]), .Y(n45) );
  OAI21X1 U49 ( .A(n39), .B(n9), .C(count_out[0]), .Y(n43) );
  INVX1 U50 ( .A(count_out[1]), .Y(n9) );
  NOR2X1 U51 ( .A(rollover_val[0]), .B(rollover_val[1]), .Y(n39) );
  INVX1 U52 ( .A(rollover_flag), .Y(n30) );
endmodule


module rcv_timer ( clk, n_rst, edge_sig, transfer_active, byte_finish, 
        packet_done );
  input clk, n_rst, edge_sig, transfer_active;
  output byte_finish, packet_done;
  wire   finished, n1, n2, n3, n4;
  wire   [3:0] count_out;

  rcv_flex_counter_NUM_CNT_BITS4_1 timer_1 ( .clk(clk), .n_rst(n_rst), .clear(
        edge_sig), .count_enable(transfer_active), .rollover_val({1'b1, 1'b0, 
        1'b0, 1'b0}), .count_out(count_out) );
  rcv_flex_counter_NUM_CNT_BITS4_0 timer_2 ( .clk(clk), .n_rst(n_rst), .clear(
        finished), .count_enable(packet_done), .rollover_val({1'b1, 1'b0, 1'b0, 
        1'b0}), .rollover_flag(byte_finish) );
  INVX2 U3 ( .A(n1), .Y(packet_done) );
  NAND3X1 U4 ( .A(count_out[1]), .B(n2), .C(n3), .Y(n1) );
  NOR2X1 U5 ( .A(count_out[3]), .B(count_out[2]), .Y(n3) );
  INVX1 U6 ( .A(count_out[0]), .Y(n2) );
  NAND2X1 U7 ( .A(transfer_active), .B(n4), .Y(finished) );
  INVX1 U8 ( .A(byte_finish), .Y(n4) );
endmodule


module rcv_decoder ( clk, n_rst, d_plus_sync, packet_done, d_prim );
  input clk, n_rst, d_plus_sync, packet_done;
  output d_prim;
  wire   tmpreg_d, n1, n2;

  DFFSR tmpreg_d_reg ( .D(n2), .CLK(clk), .R(1'b1), .S(n_rst), .Q(tmpreg_d) );
  INVX1 U2 ( .A(n1), .Y(n2) );
  MUX2X1 U3 ( .B(tmpreg_d), .A(d_plus_sync), .S(packet_done), .Y(n1) );
  XNOR2X1 U4 ( .A(d_plus_sync), .B(tmpreg_d), .Y(d_prim) );
endmodule


module rcv_edge_detector ( clk, n_rst, d_plus_sync, edge_sig );
  input clk, n_rst, d_plus_sync;
  output edge_sig;
  wire   temp;

  DFFSR temp_reg ( .D(d_plus_sync), .CLK(clk), .R(1'b1), .S(n_rst), .Q(temp)
         );
  XOR2X1 U4 ( .A(temp), .B(d_plus_sync), .Y(edge_sig) );
endmodule


module rcv_eop_detector ( clk, n_rst, packet_done, d_plus_sync, d_minus_sync, 
        eop, reg_state );
  output [1:0] reg_state;
  input clk, n_rst, packet_done, d_plus_sync, d_minus_sync;
  output eop;
  wire   n34, n35, n36, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15,
         n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29,
         n30, n31, n32;
  wire   [2:0] state;

  DFFSR \state_reg[0]  ( .D(n36), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[0])
         );
  DFFSR \state_reg[2]  ( .D(n34), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[2])
         );
  DFFSR \state_reg[1]  ( .D(n35), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[1])
         );
  OAI21X1 U6 ( .A(n4), .B(n5), .C(n6), .Y(reg_state[1]) );
  NAND2X1 U7 ( .A(state[0]), .B(n7), .Y(n5) );
  OAI21X1 U8 ( .A(n8), .B(n9), .C(n10), .Y(n36) );
  AOI21X1 U9 ( .A(n11), .B(n12), .C(n13), .Y(n10) );
  OAI21X1 U10 ( .A(n14), .B(n15), .C(n16), .Y(n35) );
  AOI22X1 U11 ( .A(n13), .B(n17), .C(state[1]), .D(n18), .Y(n16) );
  INVX1 U12 ( .A(n19), .Y(n17) );
  OAI21X1 U13 ( .A(n8), .B(n4), .C(n20), .Y(n34) );
  AOI22X1 U14 ( .A(n21), .B(n22), .C(n13), .D(n19), .Y(n20) );
  NAND2X1 U15 ( .A(d_plus_sync), .B(n23), .Y(n19) );
  NOR2X1 U16 ( .A(n24), .B(n25), .Y(n13) );
  INVX1 U17 ( .A(n14), .Y(n22) );
  NOR2X1 U18 ( .A(eop), .B(n25), .Y(n21) );
  INVX1 U19 ( .A(n12), .Y(n25) );
  INVX1 U20 ( .A(n18), .Y(n8) );
  OAI21X1 U21 ( .A(n7), .B(n26), .C(n12), .Y(n18) );
  OAI21X1 U22 ( .A(n11), .B(n27), .C(n28), .Y(n12) );
  OAI21X1 U23 ( .A(eop), .B(n29), .C(packet_done), .Y(n28) );
  INVX1 U24 ( .A(n15), .Y(eop) );
  NAND3X1 U25 ( .A(n23), .B(n30), .C(packet_done), .Y(n15) );
  INVX1 U26 ( .A(d_plus_sync), .Y(n30) );
  INVX1 U27 ( .A(d_minus_sync), .Y(n23) );
  NAND2X1 U28 ( .A(n14), .B(n24), .Y(n27) );
  NAND3X1 U29 ( .A(n7), .B(n4), .C(state[0]), .Y(n14) );
  INVX1 U30 ( .A(n29), .Y(n11) );
  NAND3X1 U31 ( .A(n7), .B(n4), .C(n9), .Y(n29) );
  NAND2X1 U32 ( .A(n24), .B(n31), .Y(n26) );
  INVX1 U33 ( .A(reg_state[0]), .Y(n31) );
  OAI21X1 U34 ( .A(n4), .B(n32), .C(n6), .Y(reg_state[0]) );
  NAND3X1 U35 ( .A(state[0]), .B(n4), .C(state[1]), .Y(n6) );
  NAND2X1 U36 ( .A(n9), .B(n7), .Y(n32) );
  NAND3X1 U37 ( .A(n9), .B(n4), .C(state[1]), .Y(n24) );
  INVX1 U38 ( .A(state[2]), .Y(n4) );
  INVX1 U39 ( .A(state[0]), .Y(n9) );
  INVX1 U40 ( .A(state[1]), .Y(n7) );
endmodule


module rcv_flex_stp_sr_NUM_BITS8_SHIFT_MSB1 ( clk, n_rst, shift_enable, 
        serial_in, parallel_out );
  output [7:0] parallel_out;
  input clk, n_rst, shift_enable, serial_in;
  wire   n12, n14, n16, n18, n20, n22, n24, n26, n1, n2, n3, n4, n5, n6, n7,
         n8;

  DFFSR \parallel_out_reg[0]  ( .D(n26), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[0]) );
  DFFSR \parallel_out_reg[1]  ( .D(n24), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[1]) );
  DFFSR \parallel_out_reg[2]  ( .D(n22), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[2]) );
  DFFSR \parallel_out_reg[3]  ( .D(n20), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[3]) );
  DFFSR \parallel_out_reg[4]  ( .D(n18), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[4]) );
  DFFSR \parallel_out_reg[5]  ( .D(n16), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[5]) );
  DFFSR \parallel_out_reg[6]  ( .D(n14), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[6]) );
  DFFSR \parallel_out_reg[7]  ( .D(n12), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[7]) );
  INVX1 U2 ( .A(n1), .Y(n26) );
  MUX2X1 U3 ( .B(parallel_out[0]), .A(serial_in), .S(shift_enable), .Y(n1) );
  INVX1 U4 ( .A(n2), .Y(n24) );
  MUX2X1 U5 ( .B(parallel_out[1]), .A(parallel_out[0]), .S(shift_enable), .Y(
        n2) );
  INVX1 U6 ( .A(n3), .Y(n22) );
  MUX2X1 U7 ( .B(parallel_out[2]), .A(parallel_out[1]), .S(shift_enable), .Y(
        n3) );
  INVX1 U8 ( .A(n4), .Y(n20) );
  MUX2X1 U9 ( .B(parallel_out[3]), .A(parallel_out[2]), .S(shift_enable), .Y(
        n4) );
  INVX1 U10 ( .A(n5), .Y(n18) );
  MUX2X1 U11 ( .B(parallel_out[4]), .A(parallel_out[3]), .S(shift_enable), .Y(
        n5) );
  INVX1 U12 ( .A(n6), .Y(n16) );
  MUX2X1 U13 ( .B(parallel_out[5]), .A(parallel_out[4]), .S(shift_enable), .Y(
        n6) );
  INVX1 U14 ( .A(n7), .Y(n14) );
  MUX2X1 U15 ( .B(parallel_out[6]), .A(parallel_out[5]), .S(shift_enable), .Y(
        n7) );
  INVX1 U16 ( .A(n8), .Y(n12) );
  MUX2X1 U17 ( .B(parallel_out[7]), .A(parallel_out[6]), .S(shift_enable), .Y(
        n8) );
endmodule


module rcv_rcu ( clk, n_rst, edge_sig, byte_finish, eop, packet_done, 
        rx_shift_register, reg_state, flush, rx_transfer_active, rx_data_ready, 
        rx_error, store_rx_packet_data, rx_packet );
  input [7:0] rx_shift_register;
  input [1:0] reg_state;
  output [2:0] rx_packet;
  input clk, n_rst, edge_sig, byte_finish, eop, packet_done;
  output flush, rx_transfer_active, rx_data_ready, rx_error,
         store_rx_packet_data;
  wire   n118, n119, n120, n121, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14,
         n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28,
         n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42,
         n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56,
         n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70,
         n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84,
         n85, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96;
  wire   [4:0] state;

  DFFSR \state_reg[0]  ( .D(n121), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[0]) );
  DFFSR \state_reg[3]  ( .D(n120), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[3]) );
  DFFSR \state_reg[1]  ( .D(n118), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[1]) );
  DFFSR \state_reg[2]  ( .D(n119), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[2]) );
  AOI21X1 U7 ( .A(rx_error), .B(state[3]), .C(n5), .Y(rx_transfer_active) );
  OAI21X1 U8 ( .A(state[2]), .B(n6), .C(n7), .Y(n5) );
  NAND2X1 U9 ( .A(n8), .B(n9), .Y(rx_packet[1]) );
  NAND2X1 U10 ( .A(n10), .B(n11), .Y(rx_packet[0]) );
  INVX1 U11 ( .A(n12), .Y(rx_error) );
  OAI21X1 U12 ( .A(n13), .B(n14), .C(n15), .Y(n121) );
  OAI21X1 U13 ( .A(n16), .B(n17), .C(n18), .Y(n15) );
  NAND2X1 U14 ( .A(n19), .B(n20), .Y(n17) );
  AOI22X1 U15 ( .A(n21), .B(n22), .C(flush), .D(n23), .Y(n19) );
  XNOR2X1 U16 ( .A(reg_state[1]), .B(n24), .Y(n22) );
  OAI21X1 U17 ( .A(n6), .B(n25), .C(n26), .Y(n16) );
  NOR2X1 U18 ( .A(rx_data_ready), .B(n27), .Y(n26) );
  MUX2X1 U19 ( .B(byte_finish), .A(edge_sig), .S(n28), .Y(n25) );
  NAND3X1 U20 ( .A(n29), .B(n30), .C(n14), .Y(n6) );
  NAND3X1 U21 ( .A(n31), .B(n32), .C(n33), .Y(n120) );
  AOI21X1 U22 ( .A(state[3]), .B(n34), .C(n35), .Y(n33) );
  OAI22X1 U23 ( .A(n36), .B(n23), .C(n37), .D(n24), .Y(n35) );
  AOI21X1 U24 ( .A(store_rx_packet_data), .B(n38), .C(n39), .Y(n32) );
  INVX1 U25 ( .A(n40), .Y(store_rx_packet_data) );
  AOI22X1 U26 ( .A(reg_state[1]), .B(n41), .C(n42), .D(n43), .Y(n31) );
  INVX1 U27 ( .A(n44), .Y(n42) );
  OAI21X1 U28 ( .A(n12), .B(n24), .C(n37), .Y(n41) );
  INVX1 U29 ( .A(reg_state[0]), .Y(n24) );
  NAND3X1 U30 ( .A(state[1]), .B(n28), .C(state[0]), .Y(n12) );
  OR2X1 U31 ( .A(n45), .B(n46), .Y(n119) );
  OAI21X1 U32 ( .A(n13), .B(n28), .C(n47), .Y(n46) );
  OAI21X1 U33 ( .A(n48), .B(n49), .C(n50), .Y(n45) );
  AOI21X1 U34 ( .A(n43), .B(n51), .C(n39), .Y(n50) );
  INVX1 U35 ( .A(n52), .Y(n39) );
  NAND3X1 U36 ( .A(n8), .B(n53), .C(n10), .Y(n51) );
  NAND3X1 U37 ( .A(rx_shift_register[4]), .B(n54), .C(n55), .Y(n10) );
  INVX1 U38 ( .A(rx_packet[2]), .Y(n53) );
  NAND2X1 U39 ( .A(n9), .B(n11), .Y(rx_packet[2]) );
  NAND2X1 U40 ( .A(n56), .B(n57), .Y(n11) );
  NAND3X1 U41 ( .A(n56), .B(n54), .C(rx_shift_register[4]), .Y(n9) );
  INVX1 U42 ( .A(n58), .Y(n56) );
  NAND3X1 U43 ( .A(rx_shift_register[1]), .B(n59), .C(n60), .Y(n58) );
  NOR2X1 U44 ( .A(n61), .B(n62), .Y(n60) );
  NAND2X1 U45 ( .A(n55), .B(n57), .Y(n8) );
  NOR3X1 U46 ( .A(n63), .B(rx_shift_register[6]), .C(n64), .Y(n55) );
  INVX1 U47 ( .A(n65), .Y(n48) );
  OAI21X1 U48 ( .A(n13), .B(n29), .C(n66), .Y(n118) );
  OAI21X1 U49 ( .A(n67), .B(n68), .C(n18), .Y(n66) );
  NAND2X1 U50 ( .A(n69), .B(n47), .Y(n68) );
  INVX1 U51 ( .A(n70), .Y(n47) );
  OAI21X1 U52 ( .A(n40), .B(n38), .C(n71), .Y(n70) );
  MUX2X1 U53 ( .B(flush), .A(n27), .S(n23), .Y(n69) );
  INVX1 U54 ( .A(byte_finish), .Y(n23) );
  NAND2X1 U55 ( .A(n20), .B(n37), .Y(n67) );
  AOI22X1 U56 ( .A(n49), .B(n65), .C(n44), .D(n43), .Y(n20) );
  NAND3X1 U57 ( .A(n72), .B(n64), .C(n73), .Y(n44) );
  NOR2X1 U58 ( .A(n62), .B(n63), .Y(n73) );
  NAND3X1 U59 ( .A(rx_shift_register[7]), .B(rx_shift_register[1]), .C(n74), 
        .Y(n63) );
  NOR2X1 U60 ( .A(rx_shift_register[5]), .B(rx_shift_register[3]), .Y(n74) );
  INVX1 U61 ( .A(rx_shift_register[2]), .Y(n64) );
  INVX1 U62 ( .A(n75), .Y(n72) );
  AOI21X1 U63 ( .A(n54), .B(rx_shift_register[4]), .C(n57), .Y(n75) );
  NAND3X1 U64 ( .A(n57), .B(n59), .C(n76), .Y(n49) );
  NOR2X1 U65 ( .A(rx_shift_register[1]), .B(n77), .Y(n76) );
  NAND2X1 U66 ( .A(n61), .B(n62), .Y(n77) );
  INVX1 U67 ( .A(rx_shift_register[6]), .Y(n62) );
  INVX1 U68 ( .A(rx_shift_register[3]), .Y(n61) );
  NOR3X1 U69 ( .A(rx_shift_register[5]), .B(rx_shift_register[7]), .C(
        rx_shift_register[2]), .Y(n59) );
  NOR2X1 U70 ( .A(n54), .B(rx_shift_register[4]), .Y(n57) );
  INVX1 U71 ( .A(rx_shift_register[0]), .Y(n54) );
  INVX1 U72 ( .A(n34), .Y(n13) );
  NAND2X1 U73 ( .A(n78), .B(n18), .Y(n34) );
  INVX1 U74 ( .A(n79), .Y(n18) );
  OAI21X1 U75 ( .A(packet_done), .B(n80), .C(n81), .Y(n79) );
  AOI22X1 U76 ( .A(n82), .B(n38), .C(rx_data_ready), .D(n83), .Y(n81) );
  INVX1 U77 ( .A(edge_sig), .Y(n83) );
  INVX1 U78 ( .A(eop), .Y(n38) );
  OAI21X1 U79 ( .A(byte_finish), .B(n36), .C(n80), .Y(n82) );
  INVX1 U80 ( .A(n84), .Y(n80) );
  OAI21X1 U81 ( .A(packet_done), .B(n40), .C(n71), .Y(n84) );
  MUX2X1 U82 ( .B(n85), .A(n86), .S(n37), .Y(n78) );
  INVX1 U83 ( .A(n21), .Y(n37) );
  NOR2X1 U84 ( .A(n87), .B(n28), .Y(n21) );
  NOR2X1 U85 ( .A(n88), .B(n89), .Y(n86) );
  NAND3X1 U86 ( .A(n52), .B(n90), .C(n91), .Y(n89) );
  NOR2X1 U87 ( .A(n27), .B(n65), .Y(n91) );
  NOR2X1 U88 ( .A(n87), .B(state[2]), .Y(n65) );
  NAND3X1 U89 ( .A(n14), .B(n30), .C(state[1]), .Y(n87) );
  INVX1 U90 ( .A(n36), .Y(n27) );
  NAND3X1 U91 ( .A(n14), .B(n29), .C(n92), .Y(n36) );
  INVX1 U92 ( .A(n43), .Y(n90) );
  NOR2X1 U93 ( .A(n28), .B(n93), .Y(n43) );
  INVX1 U94 ( .A(state[2]), .Y(n28) );
  NAND3X1 U95 ( .A(n92), .B(n29), .C(state[0]), .Y(n52) );
  NAND3X1 U96 ( .A(n71), .B(n40), .C(n94), .Y(n88) );
  NOR2X1 U97 ( .A(rx_data_ready), .B(flush), .Y(n94) );
  NOR2X1 U98 ( .A(n93), .B(state[2]), .Y(flush) );
  NAND3X1 U99 ( .A(n29), .B(n30), .C(state[0]), .Y(n93) );
  INVX1 U100 ( .A(n7), .Y(rx_data_ready) );
  NAND3X1 U101 ( .A(n92), .B(n14), .C(state[1]), .Y(n7) );
  INVX1 U102 ( .A(state[0]), .Y(n14) );
  NOR2X1 U103 ( .A(n30), .B(state[2]), .Y(n92) );
  INVX1 U104 ( .A(state[3]), .Y(n30) );
  NAND3X1 U105 ( .A(state[2]), .B(state[3]), .C(n95), .Y(n40) );
  NOR2X1 U106 ( .A(state[1]), .B(state[0]), .Y(n95) );
  NAND3X1 U107 ( .A(state[2]), .B(state[0]), .C(n96), .Y(n71) );
  NOR2X1 U108 ( .A(state[3]), .B(n29), .Y(n96) );
  INVX1 U109 ( .A(state[1]), .Y(n29) );
  NOR2X1 U110 ( .A(reg_state[1]), .B(reg_state[0]), .Y(n85) );
endmodule


module rcv_usb ( clk, n_rst, d_plus_in, d_minus_in, rx_data_ready, flush, 
        store_rx_packet_data, rx_transfer_active, rx_error, rx_packet_data, 
        rx_packet );
  output [7:0] rx_packet_data;
  output [2:0] rx_packet;
  input clk, n_rst, d_plus_in, d_minus_in;
  output rx_data_ready, flush, store_rx_packet_data, rx_transfer_active,
         rx_error;
  wire   d_minus_sync, d_plus_sync, edge_sig, byte_finish, packet_done, d_prim,
         eop;
  wire   [1:0] reg_state;

  rcv_sync_low mod1 ( .clk(clk), .n_rst(n_rst), .async_in(d_minus_in), 
        .sync_out(d_minus_sync) );
  rcv_sync_high mod2 ( .clk(clk), .n_rst(n_rst), .async_in(d_plus_in), 
        .sync_out(d_plus_sync) );
  rcv_timer mod3 ( .clk(clk), .n_rst(n_rst), .edge_sig(edge_sig), 
        .transfer_active(rx_transfer_active), .byte_finish(byte_finish), 
        .packet_done(packet_done) );
  rcv_decoder mod4 ( .clk(clk), .n_rst(n_rst), .d_plus_sync(d_plus_sync), 
        .packet_done(packet_done), .d_prim(d_prim) );
  rcv_edge_detector mod5 ( .clk(clk), .n_rst(n_rst), .d_plus_sync(d_plus_sync), 
        .edge_sig(edge_sig) );
  rcv_eop_detector mod6 ( .clk(clk), .n_rst(n_rst), .packet_done(packet_done), 
        .d_plus_sync(d_plus_sync), .d_minus_sync(d_minus_sync), .eop(eop), 
        .reg_state(reg_state) );
  rcv_flex_stp_sr_NUM_BITS8_SHIFT_MSB1 mod7 ( .clk(clk), .n_rst(n_rst), 
        .shift_enable(packet_done), .serial_in(d_prim), .parallel_out(
        rx_packet_data) );
  rcv_rcu final_mod8 ( .clk(clk), .n_rst(n_rst), .edge_sig(edge_sig), 
        .byte_finish(byte_finish), .eop(eop), .packet_done(packet_done), 
        .rx_shift_register(rx_packet_data), .reg_state(reg_state), .flush(
        flush), .rx_transfer_active(rx_transfer_active), .rx_data_ready(
        rx_data_ready), .rx_error(rx_error), .store_rx_packet_data(
        store_rx_packet_data), .rx_packet(rx_packet) );
endmodule

