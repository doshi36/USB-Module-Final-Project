/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Fri Dec  8 10:47:23 2023
/////////////////////////////////////////////////////////////


module ahb_lite_slave_cdl ( clk, n_rst, hsel, hwrite, rx_data_ready, 
        rx_transfer_active, rx_error, tx_error, tx_transfer_active, haddr, 
        htrans, hsize, hwdata, hrdata, hresp, hready, d_mode, get_rx_data, 
        store_tx_data, clear, rx_packet, buffer_occ, rx_data, tx_data, 
        tx_packet );
  input [3:0] haddr;
  input [1:0] htrans;
  input [1:0] hsize;
  input [31:0] hwdata;
  output [31:0] hrdata;
  input [2:0] rx_packet;
  input [6:0] buffer_occ;
  input [7:0] rx_data;
  output [7:0] tx_data;
  output [2:0] tx_packet;
  input clk, n_rst, hsel, hwrite, rx_data_ready, rx_transfer_active, rx_error,
         tx_error, tx_transfer_active;
  output hresp, hready, d_mode, get_rx_data, store_tx_data, clear;
  wire   prev_hwrite, prev_hsel, next_hready, next_hresp, next_clear, N75, N76,
         N77, N80, N81, N82, N87, N88, N89, N90, N91, N92, N93, N94, N95, N96,
         N97, N98, N99, N100, N101, N102, N103, N104, N105, N106, N107, N108,
         N109, N110, N111, n352, n386, n403, n404, n406, n442, n443, n444,
         n445, n446, n447, n448, n449, n450, n451, n741, n742, n743, n744,
         n745, n746, n747, n748, n749, n750, n751, n752, n753, n754, n755,
         n756, n757, n758, n759, n760, n761, n762, n763, n764, n765, n766,
         n767, n768, n769, n770, n771, n772, n773, n774, n775, n776, n777,
         n778, n779, n780, n781, n782, n783, n784, n785, n786, n787, n788,
         n789, n790, n791, n792, n793, n794, n795, n796, n797, n798, n799,
         n800, n801, n802, n803, n804, n805, n806, n807, n808, n809, n810,
         n811, n812, n813, n814, n815, n816, n817, n818, n819, n820, n821,
         n822, n823, n824, n825, n826, n827, n828, n829, n830, n831, n832,
         n833, n834, n835, n836, n837, n838, n839, n840, n841, n842, n843,
         n844, n845, n846, n847, n848, n849, n850, n851, n852, n853, n854,
         n855, n856, n857, n858, n859, n860, n861, n862, n863, n864, n865,
         n866, n867, n868, n869, n870, n871, n872, n873, n874, n875, n876,
         n877, n878, n879, n880, n881, n882, n883, n884, n885, n886, n887,
         n888, n889, n890, n891, n892, n893, n894, n895, n896, n897, n898,
         n899, n900, n901, n902, n903, n904, n905, n906, n907, n908, n909,
         n910, n911, n912, n913, n914, n915, n916, n917, n918, n919, n920,
         n921, n922, n923, n924, n925, n926, n927, n928, n929, n930, n931,
         n932, n933, n934, n935, n936, n937, n938, n939, n940, n941, n942,
         n943, n944, n945, n946, n947, n948, n949, n950, n951, n952, n953,
         n954, n955, n956, n957, n958, n959, n960, n961, n962, n963, n964,
         n965, n966, n967, n968, n969, n970, n971, n972, n973, n974, n975,
         n976, n977, n978, n979, n980, n981, n982, n983, n984, n985, n986,
         n987, n988, n989, n990, n991, n992, n993, n994, n995, n996, n997,
         n998, n999, n1000, n1001, n1002, n1003, n1004, n1005, n1006, n1007,
         n1008, n1009, n1010, n1011, n1012, n1013, n1014, n1015, n1016, n1017,
         n1018, n1019, n1020, n1021, n1022, n1023, n1024, n1025, n1026, n1027,
         n1028, n1029, n1030, n1031, n1032, n1033, n1034, n1035, n1036, n1037,
         n1038, n1039, n1040, n1041, n1042, n1043, n1044, n1045, n1046, n1047,
         n1048, n1049, n1050, n1051, n1052, n1053, n1054, n1055, n1056, n1057,
         n1058, n1059, n1060, n1061, n1062, n1063, n1064, n1065, n1066, n1067,
         n1068, n1069, n1070, n1071, n1072, n1073, n1074, n1075, n1076, n1077,
         n1078, n1079, n1080, n1081, n1082, n1083, n1084, n1085, n1086, n1087,
         n1088, n1089, n1090, n1091, n1092, n1093, n1094, n1095, n1096, n1097,
         n1098, n1099, n1100, n1101, n1102, n1103, n1104, n1105, n1106, n1107,
         n1108, n1109, n1110, n1111, n1112, n1113, n1114, n1115, n1116, n1117,
         n1118, n1119, n1120, n1121, n1122, n1123, n1124, n1125, n1126, n1127,
         n1128, n1129, n1130, n1131, n1132, n1133, n1134, n1135, n1136, n1137,
         n1138, n1139, n1140, n1141, n1142, n1143, n1144, n1145, n1146, n1147,
         n1148, n1149;
  wire   [1:0] prev_hsize;
  wire   [1:0] prev_htrans;
  wire   [3:0] prev_haddr;
  wire   [2:0] state;
  wire   [2:0] next_tx_packet;
  wire   [7:0] next_tx_data;
  wire   [3:0] write_select;

  DFFSR \prev_hsize_reg[1]  ( .D(hsize[1]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(prev_hsize[1]) );
  DFFSR \prev_hsize_reg[0]  ( .D(hsize[0]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(prev_hsize[0]) );
  DFFSR \prev_htrans_reg[1]  ( .D(htrans[1]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(prev_htrans[1]) );
  DFFSR \prev_htrans_reg[0]  ( .D(htrans[0]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(prev_htrans[0]) );
  DFFSR \prev_haddr_reg[3]  ( .D(haddr[3]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(prev_haddr[3]) );
  DFFSR \prev_haddr_reg[2]  ( .D(haddr[2]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(prev_haddr[2]) );
  DFFSR \prev_haddr_reg[1]  ( .D(haddr[1]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(prev_haddr[1]) );
  DFFSR \prev_haddr_reg[0]  ( .D(haddr[0]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(prev_haddr[0]) );
  DFFSR prev_hwrite_reg ( .D(hwrite), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        prev_hwrite) );
  DFFSR prev_hsel_reg ( .D(hsel), .CLK(clk), .R(n_rst), .S(1'b1), .Q(prev_hsel) );
  DFFPOSX1 \write_select_reg[3]  ( .D(n406), .CLK(clk), .Q(write_select[3]) );
  DFFPOSX1 \write_select_reg[2]  ( .D(n1124), .CLK(clk), .Q(write_select[2])
         );
  DFFPOSX1 \write_select_reg[1]  ( .D(n404), .CLK(clk), .Q(write_select[1]) );
  DFFPOSX1 \write_select_reg[0]  ( .D(n403), .CLK(clk), .Q(write_select[0]) );
  DFFSR \state_reg[0]  ( .D(n451), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[0]) );
  DFFSR hready_reg ( .D(next_hready), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hready) );
  DFFSR \tx_packet_reg[1]  ( .D(next_tx_packet[1]), .CLK(clk), .R(n_rst), .S(
        1'b1), .Q(tx_packet[1]) );
  DFFSR \tx_packet_reg[2]  ( .D(next_tx_packet[2]), .CLK(clk), .R(n_rst), .S(
        1'b1), .Q(tx_packet[2]) );
  DFFSR clear_reg ( .D(next_clear), .CLK(clk), .R(n_rst), .S(1'b1), .Q(clear)
         );
  DFFSR hresp_reg ( .D(next_hresp), .CLK(clk), .R(n_rst), .S(1'b1), .Q(hresp)
         );
  DFFSR \state_reg[2]  ( .D(n449), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[2]) );
  DFFSR \state_reg[1]  ( .D(n450), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[1]) );
  DFFSR \tx_data_reg[7]  ( .D(next_tx_data[7]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(tx_data[7]) );
  DFFSR \tx_data_reg[6]  ( .D(next_tx_data[6]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(tx_data[6]) );
  DFFSR \tx_data_reg[5]  ( .D(next_tx_data[5]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(tx_data[5]) );
  DFFSR \tx_data_reg[4]  ( .D(next_tx_data[4]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(tx_data[4]) );
  DFFSR \tx_data_reg[3]  ( .D(next_tx_data[3]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(tx_data[3]) );
  DFFSR \tx_data_reg[2]  ( .D(next_tx_data[2]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(tx_data[2]) );
  DFFSR \tx_data_reg[1]  ( .D(next_tx_data[1]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(tx_data[1]) );
  DFFSR \tx_data_reg[0]  ( .D(next_tx_data[0]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(tx_data[0]) );
  DFFPOSX1 store_tx_data_reg ( .D(n386), .CLK(clk), .Q(store_tx_data) );
  DFFSR \tx_packet_reg[0]  ( .D(next_tx_packet[0]), .CLK(clk), .R(n_rst), .S(
        1'b1), .Q(tx_packet[0]) );
  DFFSR \hrdata_reg[0]  ( .D(n448), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[0]) );
  DFFSR \hrdata_reg[8]  ( .D(n1126), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[8]) );
  DFFSR \hrdata_reg[16]  ( .D(n1134), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[16]) );
  DFFSR \hrdata_reg[24]  ( .D(n1142), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[24]) );
  DFFSR \hrdata_reg[3]  ( .D(n445), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[3]) );
  DFFSR \hrdata_reg[11]  ( .D(n1129), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[11]) );
  DFFSR \hrdata_reg[19]  ( .D(n1137), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[19]) );
  DFFSR \hrdata_reg[27]  ( .D(n1145), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[27]) );
  DFFSR \hrdata_reg[4]  ( .D(n444), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[4]) );
  DFFSR \hrdata_reg[12]  ( .D(n1130), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[12]) );
  DFFSR \hrdata_reg[20]  ( .D(n1138), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[20]) );
  DFFSR \hrdata_reg[28]  ( .D(n1146), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[28]) );
  DFFSR \hrdata_reg[5]  ( .D(n443), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[5]) );
  DFFSR \hrdata_reg[13]  ( .D(n1131), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[13]) );
  DFFSR \hrdata_reg[21]  ( .D(n1139), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[21]) );
  DFFSR \hrdata_reg[29]  ( .D(n1147), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[29]) );
  DFFSR \hrdata_reg[6]  ( .D(n442), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[6]) );
  DFFSR \hrdata_reg[14]  ( .D(n1132), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[14]) );
  DFFSR \hrdata_reg[22]  ( .D(n1140), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[22]) );
  DFFSR \hrdata_reg[30]  ( .D(n1148), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[30]) );
  DFFSR \hrdata_reg[7]  ( .D(n1125), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[7]) );
  DFFSR \hrdata_reg[15]  ( .D(n1133), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[15]) );
  DFFSR \hrdata_reg[23]  ( .D(n1141), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[23]) );
  DFFSR \hrdata_reg[31]  ( .D(n1149), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[31]) );
  DFFSR \hrdata_reg[26]  ( .D(n1144), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[26]) );
  DFFSR \hrdata_reg[18]  ( .D(n1136), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[18]) );
  DFFSR \hrdata_reg[10]  ( .D(n1128), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[10]) );
  DFFSR \hrdata_reg[2]  ( .D(n446), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[2]) );
  DFFSR \hrdata_reg[25]  ( .D(n1143), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[25]) );
  DFFSR \hrdata_reg[17]  ( .D(n1135), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[17]) );
  DFFSR \hrdata_reg[9]  ( .D(n1127), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[9]) );
  DFFSR \hrdata_reg[1]  ( .D(n447), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[1]) );
  DFFPOSX1 get_rx_data_reg ( .D(n352), .CLK(clk), .Q(get_rx_data) );
  INVX2 U756 ( .A(n1024), .Y(n742) );
  INVX2 U757 ( .A(n1061), .Y(n893) );
  INVX4 U758 ( .A(n1022), .Y(n870) );
  NAND2X1 U759 ( .A(n782), .B(n906), .Y(n774) );
  AOI21X1 U760 ( .A(haddr[3]), .B(haddr[1]), .C(n786), .Y(n763) );
  AOI22X1 U761 ( .A(rx_data_ready), .B(n781), .C(rx_error), .D(haddr[1]), .Y(
        n748) );
  NAND2X1 U762 ( .A(n780), .B(n906), .Y(n747) );
  AOI22X1 U763 ( .A(tx_packet[0]), .B(n780), .C(clear), .D(haddr[0]), .Y(n744)
         );
  NAND3X1 U764 ( .A(haddr[0]), .B(n782), .C(hrdata[0]), .Y(n743) );
  OAI21X1 U765 ( .A(n782), .B(n744), .C(n743), .Y(n745) );
  NAND2X1 U766 ( .A(n745), .B(haddr[3]), .Y(n746) );
  OAI21X1 U767 ( .A(n748), .B(n747), .C(n746), .Y(n750) );
  NAND2X1 U768 ( .A(haddr[3]), .B(n782), .Y(n764) );
  NAND3X1 U769 ( .A(n763), .B(n780), .C(n783), .Y(n749) );
  AOI22X1 U770 ( .A(n750), .B(n763), .C(buffer_occ[0]), .D(n787), .Y(n751) );
  OAI21X1 U771 ( .A(n763), .B(n779), .C(n751), .Y(N80) );
  OAI22X1 U772 ( .A(n906), .B(n781), .C(haddr[1]), .D(haddr[0]), .Y(n756) );
  AOI22X1 U773 ( .A(haddr[1]), .B(n756), .C(n782), .D(n785), .Y(n758) );
  NOR2X1 U774 ( .A(n782), .B(haddr[3]), .Y(n775) );
  AOI22X1 U775 ( .A(n741), .B(n775), .C(hrdata[1]), .D(n786), .Y(n754) );
  NOR2X1 U776 ( .A(n906), .B(n782), .Y(n752) );
  AOI22X1 U777 ( .A(n752), .B(tx_packet[1]), .C(buffer_occ[1]), .D(n783), .Y(
        n753) );
  NAND2X1 U778 ( .A(n754), .B(n753), .Y(n755) );
  NAND3X1 U779 ( .A(n756), .B(n758), .C(n755), .Y(n757) );
  OAI21X1 U780 ( .A(n758), .B(n1056), .C(n757), .Y(N81) );
  NAND3X1 U781 ( .A(n780), .B(n781), .C(haddr[3]), .Y(n762) );
  AOI22X1 U782 ( .A(buffer_occ[2]), .B(n782), .C(tx_packet[2]), .D(haddr[2]), 
        .Y(n761) );
  AOI21X1 U783 ( .A(n781), .B(haddr[2]), .C(n775), .Y(n759) );
  NAND2X1 U784 ( .A(n762), .B(n759), .Y(n773) );
  NAND2X1 U785 ( .A(hrdata[2]), .B(n784), .Y(n760) );
  OAI21X1 U786 ( .A(n762), .B(n761), .C(n760), .Y(N82) );
  OAI21X1 U787 ( .A(n780), .B(n764), .C(n763), .Y(n768) );
  AOI22X1 U788 ( .A(buffer_occ[3]), .B(n787), .C(hrdata[3]), .D(n768), .Y(n765) );
  AOI22X1 U789 ( .A(buffer_occ[4]), .B(n787), .C(hrdata[4]), .D(n768), .Y(n766) );
  AOI22X1 U790 ( .A(buffer_occ[5]), .B(n787), .C(hrdata[5]), .D(n768), .Y(n767) );
  AOI22X1 U791 ( .A(buffer_occ[6]), .B(n787), .C(hrdata[6]), .D(n768), .Y(n769) );
  AND2X1 U792 ( .A(hrdata[7]), .B(n784), .Y(N87) );
  AOI22X1 U793 ( .A(rx_transfer_active), .B(n781), .C(haddr[1]), .D(tx_error), 
        .Y(n770) );
  NOR2X1 U794 ( .A(n780), .B(n770), .Y(n771) );
  NAND3X1 U795 ( .A(n773), .B(n906), .C(n771), .Y(n772) );
  OAI21X1 U796 ( .A(n773), .B(n896), .C(n772), .Y(N88) );
  AND2X1 U797 ( .A(hrdata[10]), .B(n784), .Y(N90) );
  AND2X1 U798 ( .A(hrdata[11]), .B(n784), .Y(N91) );
  AND2X1 U799 ( .A(hrdata[12]), .B(n784), .Y(N92) );
  AND2X1 U800 ( .A(hrdata[13]), .B(n784), .Y(N93) );
  AND2X1 U801 ( .A(hrdata[14]), .B(n784), .Y(N94) );
  AND2X1 U802 ( .A(hrdata[15]), .B(n784), .Y(N95) );
  AND2X1 U803 ( .A(hrdata[16]), .B(n784), .Y(N96) );
  AND2X1 U804 ( .A(hrdata[17]), .B(n784), .Y(N97) );
  AND2X1 U805 ( .A(hrdata[18]), .B(n784), .Y(N98) );
  AND2X1 U806 ( .A(hrdata[19]), .B(n784), .Y(N99) );
  AND2X1 U807 ( .A(hrdata[20]), .B(n784), .Y(N100) );
  AND2X1 U808 ( .A(hrdata[21]), .B(n784), .Y(N101) );
  AND2X1 U809 ( .A(hrdata[22]), .B(n784), .Y(N102) );
  AND2X1 U810 ( .A(hrdata[23]), .B(n784), .Y(N103) );
  AND2X1 U811 ( .A(hrdata[24]), .B(n784), .Y(N104) );
  AND2X1 U812 ( .A(hrdata[25]), .B(n784), .Y(N105) );
  AND2X1 U813 ( .A(hrdata[26]), .B(n784), .Y(N106) );
  AND2X1 U814 ( .A(hrdata[27]), .B(n784), .Y(N107) );
  AND2X1 U815 ( .A(hrdata[28]), .B(n784), .Y(N108) );
  AND2X1 U816 ( .A(hrdata[29]), .B(n784), .Y(N109) );
  AND2X1 U817 ( .A(hrdata[30]), .B(n784), .Y(N110) );
  AND2X1 U818 ( .A(hrdata[31]), .B(n784), .Y(N111) );
  OR2X1 U819 ( .A(n786), .B(state[0]), .Y(N75) );
  AND2X1 U820 ( .A(state[1]), .B(n774), .Y(N76) );
  AND2X1 U821 ( .A(state[2]), .B(n774), .Y(N77) );
  NAND2X1 U822 ( .A(n775), .B(n781), .Y(n778) );
  NAND2X1 U823 ( .A(haddr[0]), .B(tx_transfer_active), .Y(n777) );
  NAND2X1 U824 ( .A(hrdata[9]), .B(n784), .Y(n776) );
  OAI21X1 U825 ( .A(n778), .B(n777), .C(n776), .Y(N89) );
  INVX2 U826 ( .A(hrdata[0]), .Y(n779) );
  INVX2 U827 ( .A(haddr[0]), .Y(n780) );
  INVX2 U828 ( .A(haddr[1]), .Y(n781) );
  INVX2 U829 ( .A(haddr[2]), .Y(n782) );
  INVX2 U830 ( .A(n764), .Y(n783) );
  INVX2 U831 ( .A(n773), .Y(n784) );
  INVX2 U832 ( .A(n756), .Y(n785) );
  INVX2 U833 ( .A(n774), .Y(n786) );
  INVX2 U834 ( .A(n749), .Y(n787) );
  NOR2X1 U835 ( .A(n788), .B(n789), .Y(next_tx_packet[2]) );
  NOR2X1 U836 ( .A(n788), .B(n790), .Y(next_tx_packet[1]) );
  NAND2X1 U837 ( .A(n791), .B(n792), .Y(next_tx_packet[0]) );
  INVX1 U838 ( .A(n793), .Y(n791) );
  OAI22X1 U839 ( .A(n794), .B(n788), .C(n795), .D(hready), .Y(n793) );
  OR2X1 U840 ( .A(n796), .B(write_select[0]), .Y(n788) );
  OAI21X1 U841 ( .A(n797), .B(n798), .C(n799), .Y(next_tx_data[7]) );
  OAI21X1 U842 ( .A(n800), .B(n801), .C(n802), .Y(n799) );
  OAI22X1 U843 ( .A(n803), .B(n804), .C(n795), .D(n805), .Y(n801) );
  NOR2X1 U844 ( .A(n806), .B(n807), .Y(n800) );
  OAI21X1 U845 ( .A(n797), .B(n808), .C(n809), .Y(next_tx_data[6]) );
  OAI21X1 U846 ( .A(n810), .B(n811), .C(n802), .Y(n809) );
  OAI22X1 U847 ( .A(n803), .B(n812), .C(n795), .D(n813), .Y(n811) );
  NOR2X1 U848 ( .A(n806), .B(n814), .Y(n810) );
  OAI21X1 U849 ( .A(n797), .B(n815), .C(n816), .Y(next_tx_data[5]) );
  OAI21X1 U850 ( .A(n817), .B(n818), .C(n802), .Y(n816) );
  OAI22X1 U851 ( .A(n803), .B(n819), .C(n795), .D(n820), .Y(n818) );
  NOR2X1 U852 ( .A(n806), .B(n821), .Y(n817) );
  OAI21X1 U853 ( .A(n797), .B(n822), .C(n823), .Y(next_tx_data[4]) );
  OAI21X1 U854 ( .A(n824), .B(n825), .C(n802), .Y(n823) );
  OAI22X1 U855 ( .A(n803), .B(n826), .C(n795), .D(n827), .Y(n825) );
  NOR2X1 U856 ( .A(n806), .B(n828), .Y(n824) );
  OAI21X1 U857 ( .A(n797), .B(n829), .C(n830), .Y(next_tx_data[3]) );
  OAI21X1 U858 ( .A(n831), .B(n832), .C(n802), .Y(n830) );
  OAI22X1 U859 ( .A(n803), .B(n833), .C(n795), .D(n834), .Y(n832) );
  NOR2X1 U860 ( .A(n806), .B(n835), .Y(n831) );
  OAI21X1 U861 ( .A(n789), .B(n797), .C(n836), .Y(next_tx_data[2]) );
  OAI21X1 U862 ( .A(n837), .B(n838), .C(n802), .Y(n836) );
  OAI22X1 U863 ( .A(n803), .B(n839), .C(n795), .D(n840), .Y(n838) );
  NOR2X1 U864 ( .A(n806), .B(n841), .Y(n837) );
  OAI21X1 U865 ( .A(n790), .B(n797), .C(n842), .Y(next_tx_data[1]) );
  OAI21X1 U866 ( .A(n843), .B(n844), .C(n802), .Y(n842) );
  OAI22X1 U867 ( .A(n803), .B(n845), .C(n795), .D(n846), .Y(n844) );
  NOR2X1 U868 ( .A(n806), .B(n847), .Y(n843) );
  OAI21X1 U869 ( .A(n797), .B(n794), .C(n848), .Y(next_tx_data[0]) );
  OAI21X1 U870 ( .A(n849), .B(n850), .C(n802), .Y(n848) );
  OAI22X1 U871 ( .A(n803), .B(n851), .C(n795), .D(n852), .Y(n850) );
  NOR2X1 U872 ( .A(n806), .B(n853), .Y(n849) );
  INVX1 U873 ( .A(hwdata[0]), .Y(n794) );
  OAI21X1 U874 ( .A(n854), .B(n855), .C(n856), .Y(next_hresp) );
  NAND3X1 U875 ( .A(n857), .B(n858), .C(n859), .Y(n856) );
  OR2X1 U876 ( .A(n860), .B(n861), .Y(next_hready) );
  OAI21X1 U877 ( .A(n862), .B(n863), .C(n864), .Y(n861) );
  AOI22X1 U878 ( .A(n865), .B(n866), .C(n867), .D(n868), .Y(n864) );
  INVX1 U879 ( .A(n869), .Y(n862) );
  NAND3X1 U880 ( .A(n796), .B(n870), .C(n871), .Y(n860) );
  AOI21X1 U881 ( .A(n872), .B(n873), .C(n874), .Y(n871) );
  INVX1 U882 ( .A(n875), .Y(n874) );
  OAI21X1 U883 ( .A(n876), .B(n877), .C(n878), .Y(n872) );
  NAND3X1 U884 ( .A(n879), .B(n803), .C(n806), .Y(n878) );
  AOI21X1 U885 ( .A(n880), .B(n881), .C(n882), .Y(n876) );
  INVX1 U886 ( .A(prev_hsize[1]), .Y(n881) );
  OAI21X1 U887 ( .A(prev_hsize[0]), .B(n879), .C(n806), .Y(n880) );
  NOR2X1 U888 ( .A(n883), .B(n884), .Y(next_clear) );
  OR2X1 U889 ( .A(n853), .B(n796), .Y(n884) );
  NAND2X1 U890 ( .A(n885), .B(n886), .Y(n796) );
  INVX1 U891 ( .A(n855), .Y(n885) );
  MUX2X1 U892 ( .B(n887), .A(n782), .S(n_rst), .Y(n1124) );
  INVX1 U893 ( .A(n888), .Y(n1125) );
  AOI22X1 U894 ( .A(n889), .B(n890), .C(hrdata[7]), .D(n891), .Y(n888) );
  OAI21X1 U895 ( .A(n798), .B(n870), .C(n892), .Y(n889) );
  AOI21X1 U896 ( .A(N87), .B(n893), .C(n894), .Y(n892) );
  INVX1 U897 ( .A(hwdata[7]), .Y(n798) );
  OAI21X1 U898 ( .A(n895), .B(n896), .C(n897), .Y(n1126) );
  OAI21X1 U899 ( .A(n898), .B(n899), .C(n900), .Y(n897) );
  OAI21X1 U900 ( .A(n853), .B(n870), .C(n901), .Y(n899) );
  NAND2X1 U901 ( .A(N88), .B(n893), .Y(n901) );
  INVX1 U902 ( .A(hwdata[8]), .Y(n853) );
  OAI21X1 U903 ( .A(n902), .B(n903), .C(n904), .Y(n898) );
  NAND2X1 U904 ( .A(tx_error), .B(n905), .Y(n903) );
  NAND3X1 U905 ( .A(haddr[2]), .B(n906), .C(haddr[1]), .Y(n902) );
  INVX1 U906 ( .A(hrdata[8]), .Y(n896) );
  INVX1 U907 ( .A(n907), .Y(n895) );
  INVX1 U908 ( .A(n908), .Y(n1127) );
  AOI22X1 U909 ( .A(n909), .B(n900), .C(hrdata[9]), .D(n907), .Y(n908) );
  OAI21X1 U910 ( .A(n847), .B(n870), .C(n910), .Y(n909) );
  AOI21X1 U911 ( .A(N89), .B(n893), .C(n911), .Y(n910) );
  INVX1 U912 ( .A(hwdata[9]), .Y(n847) );
  INVX1 U913 ( .A(n912), .Y(n1128) );
  AOI22X1 U914 ( .A(n913), .B(n900), .C(hrdata[10]), .D(n907), .Y(n912) );
  OAI21X1 U915 ( .A(n841), .B(n870), .C(n914), .Y(n913) );
  AOI21X1 U916 ( .A(N90), .B(n893), .C(n915), .Y(n914) );
  INVX1 U917 ( .A(hwdata[10]), .Y(n841) );
  INVX1 U918 ( .A(n916), .Y(n1129) );
  AOI22X1 U919 ( .A(n917), .B(n900), .C(hrdata[11]), .D(n907), .Y(n916) );
  OAI21X1 U920 ( .A(n835), .B(n870), .C(n918), .Y(n917) );
  AOI21X1 U921 ( .A(N91), .B(n893), .C(n919), .Y(n918) );
  INVX1 U922 ( .A(hwdata[11]), .Y(n835) );
  INVX1 U923 ( .A(n920), .Y(n1130) );
  AOI22X1 U924 ( .A(n921), .B(n900), .C(hrdata[12]), .D(n907), .Y(n920) );
  OAI21X1 U925 ( .A(n828), .B(n870), .C(n922), .Y(n921) );
  AOI21X1 U926 ( .A(N92), .B(n893), .C(n923), .Y(n922) );
  INVX1 U927 ( .A(hwdata[12]), .Y(n828) );
  INVX1 U928 ( .A(n924), .Y(n1131) );
  AOI22X1 U929 ( .A(n925), .B(n900), .C(hrdata[13]), .D(n907), .Y(n924) );
  OAI21X1 U930 ( .A(n821), .B(n870), .C(n926), .Y(n925) );
  AOI21X1 U931 ( .A(N93), .B(n893), .C(n927), .Y(n926) );
  INVX1 U932 ( .A(hwdata[13]), .Y(n821) );
  INVX1 U933 ( .A(n928), .Y(n1132) );
  AOI22X1 U934 ( .A(n929), .B(n900), .C(hrdata[14]), .D(n907), .Y(n928) );
  OAI21X1 U935 ( .A(n814), .B(n870), .C(n930), .Y(n929) );
  AOI21X1 U936 ( .A(N94), .B(n893), .C(n931), .Y(n930) );
  INVX1 U937 ( .A(hwdata[14]), .Y(n814) );
  INVX1 U938 ( .A(n932), .Y(n1133) );
  AOI22X1 U939 ( .A(n933), .B(n900), .C(hrdata[15]), .D(n907), .Y(n932) );
  NAND2X1 U940 ( .A(n900), .B(n934), .Y(n907) );
  NAND2X1 U941 ( .A(n935), .B(n936), .Y(n900) );
  OAI21X1 U942 ( .A(n807), .B(n870), .C(n937), .Y(n933) );
  AOI21X1 U943 ( .A(N95), .B(n893), .C(n894), .Y(n937) );
  INVX1 U944 ( .A(hwdata[15]), .Y(n807) );
  INVX1 U945 ( .A(n938), .Y(n1134) );
  AOI22X1 U946 ( .A(n939), .B(n940), .C(hrdata[16]), .D(n941), .Y(n938) );
  OAI21X1 U947 ( .A(n851), .B(n870), .C(n942), .Y(n939) );
  AOI21X1 U948 ( .A(N96), .B(n893), .C(n943), .Y(n942) );
  INVX1 U949 ( .A(hwdata[16]), .Y(n851) );
  INVX1 U950 ( .A(n944), .Y(n1135) );
  AOI22X1 U951 ( .A(n945), .B(n940), .C(hrdata[17]), .D(n941), .Y(n944) );
  OAI21X1 U952 ( .A(n845), .B(n870), .C(n946), .Y(n945) );
  AOI21X1 U953 ( .A(N97), .B(n893), .C(n911), .Y(n946) );
  INVX1 U954 ( .A(hwdata[17]), .Y(n845) );
  INVX1 U955 ( .A(n947), .Y(n1136) );
  AOI22X1 U956 ( .A(n948), .B(n940), .C(hrdata[18]), .D(n941), .Y(n947) );
  OAI21X1 U957 ( .A(n839), .B(n870), .C(n949), .Y(n948) );
  AOI21X1 U958 ( .A(N98), .B(n893), .C(n915), .Y(n949) );
  INVX1 U959 ( .A(hwdata[18]), .Y(n839) );
  INVX1 U960 ( .A(n950), .Y(n1137) );
  AOI22X1 U961 ( .A(n951), .B(n940), .C(hrdata[19]), .D(n941), .Y(n950) );
  OAI21X1 U962 ( .A(n833), .B(n870), .C(n952), .Y(n951) );
  AOI21X1 U963 ( .A(N99), .B(n893), .C(n919), .Y(n952) );
  INVX1 U964 ( .A(hwdata[19]), .Y(n833) );
  INVX1 U965 ( .A(n953), .Y(n1138) );
  AOI22X1 U966 ( .A(n954), .B(n940), .C(hrdata[20]), .D(n941), .Y(n953) );
  OAI21X1 U967 ( .A(n826), .B(n870), .C(n955), .Y(n954) );
  AOI21X1 U968 ( .A(N100), .B(n893), .C(n923), .Y(n955) );
  INVX1 U969 ( .A(hwdata[20]), .Y(n826) );
  INVX1 U970 ( .A(n956), .Y(n1139) );
  AOI22X1 U971 ( .A(n957), .B(n940), .C(hrdata[21]), .D(n941), .Y(n956) );
  OAI21X1 U972 ( .A(n819), .B(n870), .C(n958), .Y(n957) );
  AOI21X1 U973 ( .A(N101), .B(n893), .C(n927), .Y(n958) );
  INVX1 U974 ( .A(hwdata[21]), .Y(n819) );
  INVX1 U975 ( .A(n959), .Y(n1140) );
  AOI22X1 U976 ( .A(n960), .B(n940), .C(hrdata[22]), .D(n941), .Y(n959) );
  OAI21X1 U977 ( .A(n812), .B(n870), .C(n961), .Y(n960) );
  AOI21X1 U978 ( .A(N102), .B(n893), .C(n931), .Y(n961) );
  INVX1 U979 ( .A(hwdata[22]), .Y(n812) );
  INVX1 U980 ( .A(n962), .Y(n1141) );
  AOI22X1 U981 ( .A(n963), .B(n940), .C(hrdata[23]), .D(n941), .Y(n962) );
  NAND2X1 U982 ( .A(n940), .B(n934), .Y(n941) );
  OAI21X1 U983 ( .A(n803), .B(n964), .C(n935), .Y(n940) );
  OAI21X1 U984 ( .A(n804), .B(n870), .C(n965), .Y(n963) );
  AOI21X1 U985 ( .A(N103), .B(n893), .C(n894), .Y(n965) );
  INVX1 U986 ( .A(hwdata[23]), .Y(n804) );
  INVX1 U987 ( .A(n966), .Y(n1142) );
  AOI22X1 U988 ( .A(n967), .B(n968), .C(hrdata[24]), .D(n969), .Y(n966) );
  OAI21X1 U989 ( .A(n852), .B(n870), .C(n970), .Y(n967) );
  AOI21X1 U990 ( .A(N104), .B(n893), .C(n943), .Y(n970) );
  INVX1 U991 ( .A(n904), .Y(n943) );
  INVX1 U992 ( .A(hwdata[24]), .Y(n852) );
  INVX1 U993 ( .A(n971), .Y(n1143) );
  AOI22X1 U994 ( .A(n972), .B(n968), .C(hrdata[25]), .D(n969), .Y(n971) );
  OAI21X1 U995 ( .A(n846), .B(n870), .C(n973), .Y(n972) );
  AOI21X1 U996 ( .A(N105), .B(n893), .C(n911), .Y(n973) );
  INVX1 U997 ( .A(n974), .Y(n911) );
  INVX1 U998 ( .A(hwdata[25]), .Y(n846) );
  INVX1 U999 ( .A(n975), .Y(n1144) );
  AOI22X1 U1000 ( .A(n976), .B(n968), .C(hrdata[26]), .D(n969), .Y(n975) );
  OAI21X1 U1001 ( .A(n840), .B(n870), .C(n977), .Y(n976) );
  AOI21X1 U1002 ( .A(N106), .B(n893), .C(n915), .Y(n977) );
  INVX1 U1003 ( .A(hwdata[26]), .Y(n840) );
  INVX1 U1004 ( .A(n978), .Y(n1145) );
  AOI22X1 U1005 ( .A(n979), .B(n968), .C(hrdata[27]), .D(n969), .Y(n978) );
  OAI21X1 U1006 ( .A(n834), .B(n870), .C(n980), .Y(n979) );
  AOI21X1 U1007 ( .A(N107), .B(n893), .C(n919), .Y(n980) );
  INVX1 U1008 ( .A(n981), .Y(n919) );
  INVX1 U1009 ( .A(hwdata[27]), .Y(n834) );
  INVX1 U1010 ( .A(n982), .Y(n1146) );
  AOI22X1 U1011 ( .A(n983), .B(n968), .C(hrdata[28]), .D(n969), .Y(n982) );
  OAI21X1 U1012 ( .A(n827), .B(n870), .C(n984), .Y(n983) );
  AOI21X1 U1013 ( .A(N108), .B(n893), .C(n923), .Y(n984) );
  INVX1 U1014 ( .A(n985), .Y(n923) );
  INVX1 U1015 ( .A(hwdata[28]), .Y(n827) );
  INVX1 U1016 ( .A(n986), .Y(n1147) );
  AOI22X1 U1017 ( .A(n987), .B(n968), .C(hrdata[29]), .D(n969), .Y(n986) );
  OAI21X1 U1018 ( .A(n820), .B(n870), .C(n988), .Y(n987) );
  AOI21X1 U1019 ( .A(N109), .B(n893), .C(n927), .Y(n988) );
  INVX1 U1020 ( .A(n989), .Y(n927) );
  INVX1 U1021 ( .A(hwdata[29]), .Y(n820) );
  INVX1 U1022 ( .A(n990), .Y(n1148) );
  AOI22X1 U1023 ( .A(n991), .B(n968), .C(hrdata[30]), .D(n969), .Y(n990) );
  OAI21X1 U1024 ( .A(n813), .B(n870), .C(n992), .Y(n991) );
  AOI21X1 U1025 ( .A(N110), .B(n893), .C(n931), .Y(n992) );
  INVX1 U1026 ( .A(n993), .Y(n931) );
  INVX1 U1027 ( .A(hwdata[30]), .Y(n813) );
  INVX1 U1028 ( .A(n994), .Y(n1149) );
  AOI22X1 U1029 ( .A(n995), .B(n968), .C(hrdata[31]), .D(n969), .Y(n994) );
  NAND2X1 U1030 ( .A(n968), .B(n934), .Y(n969) );
  OAI21X1 U1031 ( .A(n795), .B(n964), .C(n935), .Y(n968) );
  OAI21X1 U1032 ( .A(n805), .B(n870), .C(n996), .Y(n995) );
  AOI21X1 U1033 ( .A(N111), .B(n893), .C(n894), .Y(n996) );
  AND2X1 U1034 ( .A(rx_data[7]), .B(n873), .Y(n894) );
  INVX1 U1035 ( .A(hwdata[31]), .Y(n805) );
  NAND2X1 U1036 ( .A(n997), .B(n998), .Y(n451) );
  OAI21X1 U1037 ( .A(n999), .B(n1000), .C(state[0]), .Y(n998) );
  OAI21X1 U1038 ( .A(n1001), .B(n1002), .C(n870), .Y(n997) );
  OAI21X1 U1039 ( .A(n936), .B(n868), .C(n1003), .Y(n1002) );
  NAND2X1 U1040 ( .A(N75), .B(n1004), .Y(n1003) );
  OAI21X1 U1041 ( .A(n1005), .B(n1006), .C(n1007), .Y(n1001) );
  AOI21X1 U1042 ( .A(n1008), .B(n1009), .C(n1010), .Y(n1007) );
  INVX1 U1043 ( .A(n1011), .Y(n1010) );
  NOR2X1 U1044 ( .A(write_select[3]), .B(write_select[2]), .Y(n1009) );
  AND2X1 U1045 ( .A(hready), .B(n1012), .Y(n1008) );
  INVX1 U1046 ( .A(n1013), .Y(n1006) );
  INVX1 U1047 ( .A(n999), .Y(n1005) );
  OAI21X1 U1048 ( .A(n1014), .B(n1015), .C(n1016), .Y(n450) );
  OAI21X1 U1049 ( .A(n1017), .B(n1018), .C(n870), .Y(n1016) );
  INVX1 U1050 ( .A(n1019), .Y(n1018) );
  AOI21X1 U1051 ( .A(n1004), .B(N76), .C(n1020), .Y(n1019) );
  OAI22X1 U1052 ( .A(n1014), .B(n1021), .C(n1022), .D(n1023), .Y(n449) );
  AOI22X1 U1053 ( .A(N77), .B(n1004), .C(n1024), .D(n873), .Y(n1023) );
  INVX1 U1054 ( .A(n803), .Y(n1024) );
  NOR2X1 U1055 ( .A(n1025), .B(n863), .Y(n1004) );
  AOI21X1 U1056 ( .A(n1026), .B(n999), .C(n1000), .Y(n1014) );
  NAND3X1 U1057 ( .A(n875), .B(n870), .C(n1027), .Y(n1000) );
  INVX1 U1058 ( .A(n1028), .Y(n1027) );
  MUX2X1 U1059 ( .B(n1029), .A(n1030), .S(n873), .Y(n1028) );
  NAND3X1 U1060 ( .A(n803), .B(n795), .C(n1031), .Y(n1030) );
  NOR2X1 U1061 ( .A(n1032), .B(n1033), .Y(n1031) );
  NAND3X1 U1062 ( .A(n1034), .B(n1015), .C(state[2]), .Y(n795) );
  OAI21X1 U1063 ( .A(n886), .B(n1035), .C(n1012), .Y(n1029) );
  INVX1 U1064 ( .A(n854), .Y(n1035) );
  MUX2X1 U1065 ( .B(n1036), .A(write_select[3]), .S(n887), .Y(n854) );
  NOR2X1 U1066 ( .A(n887), .B(n1036), .Y(n886) );
  NAND2X1 U1067 ( .A(write_select[3]), .B(n1037), .Y(n1036) );
  NAND3X1 U1068 ( .A(n1038), .B(n1039), .C(hready), .Y(n875) );
  NOR2X1 U1069 ( .A(n863), .B(n865), .Y(n999) );
  INVX1 U1070 ( .A(n859), .Y(n863) );
  OR2X1 U1071 ( .A(n857), .B(n869), .Y(n1026) );
  OAI21X1 U1072 ( .A(haddr[3]), .B(n782), .C(n1040), .Y(n869) );
  NOR2X1 U1073 ( .A(n1041), .B(n1042), .Y(n1040) );
  OAI21X1 U1074 ( .A(n1043), .B(n1044), .C(n1045), .Y(n448) );
  NAND2X1 U1075 ( .A(hrdata[0]), .B(n891), .Y(n1045) );
  AND2X1 U1076 ( .A(n1046), .B(n1047), .Y(n1044) );
  AOI21X1 U1077 ( .A(N80), .B(n893), .C(n1048), .Y(n1047) );
  OAI21X1 U1078 ( .A(n1049), .B(n1050), .C(n904), .Y(n1048) );
  NAND2X1 U1079 ( .A(rx_data[0]), .B(n873), .Y(n904) );
  AOI22X1 U1080 ( .A(n1051), .B(haddr[2]), .C(tx_packet[0]), .D(n1052), .Y(
        n1049) );
  MUX2X1 U1081 ( .B(n1053), .A(n1054), .S(n906), .Y(n1051) );
  MUX2X1 U1082 ( .B(rx_error), .A(rx_data_ready), .S(n781), .Y(n1054) );
  NAND3X1 U1083 ( .A(haddr[0]), .B(n781), .C(clear), .Y(n1053) );
  AOI22X1 U1084 ( .A(buffer_occ[0]), .B(n1055), .C(n1022), .D(hwdata[0]), .Y(
        n1046) );
  INVX1 U1085 ( .A(n890), .Y(n1043) );
  MUX2X1 U1086 ( .B(n1056), .A(n1057), .S(n890), .Y(n447) );
  NOR2X1 U1087 ( .A(n1058), .B(n1059), .Y(n1057) );
  OAI21X1 U1088 ( .A(n790), .B(n870), .C(n1060), .Y(n1059) );
  NAND2X1 U1089 ( .A(N81), .B(n893), .Y(n1060) );
  INVX1 U1090 ( .A(hwdata[1]), .Y(n790) );
  OAI21X1 U1091 ( .A(n1062), .B(n1050), .C(n974), .Y(n1058) );
  NAND2X1 U1092 ( .A(rx_data[1]), .B(n873), .Y(n974) );
  AND2X1 U1093 ( .A(n1063), .B(n1064), .Y(n1062) );
  AOI22X1 U1094 ( .A(n1065), .B(n741), .C(tx_packet[1]), .D(n1052), .Y(n1064)
         );
  INVX1 U1095 ( .A(n1066), .Y(n1052) );
  AND2X1 U1096 ( .A(n1067), .B(rx_packet[1]), .Y(n741) );
  NOR2X1 U1097 ( .A(rx_packet[2]), .B(rx_packet[0]), .Y(n1067) );
  NOR2X1 U1098 ( .A(haddr[3]), .B(n1068), .Y(n1065) );
  AOI22X1 U1099 ( .A(buffer_occ[1]), .B(n1042), .C(hrdata[1]), .D(n1069), .Y(
        n1063) );
  INVX1 U1100 ( .A(n1070), .Y(n1042) );
  INVX1 U1101 ( .A(hrdata[1]), .Y(n1056) );
  OAI21X1 U1102 ( .A(n1071), .B(n1072), .C(n1073), .Y(n446) );
  OAI21X1 U1103 ( .A(n1074), .B(n1075), .C(n890), .Y(n1073) );
  OAI21X1 U1104 ( .A(n789), .B(n870), .C(n1076), .Y(n1075) );
  NAND2X1 U1105 ( .A(buffer_occ[2]), .B(n1055), .Y(n1076) );
  INVX1 U1106 ( .A(hwdata[2]), .Y(n789) );
  OAI21X1 U1107 ( .A(n1061), .B(n1077), .C(n1078), .Y(n1074) );
  AOI21X1 U1108 ( .A(n1079), .B(tx_packet[2]), .C(n915), .Y(n1078) );
  AND2X1 U1109 ( .A(rx_data[2]), .B(n873), .Y(n915) );
  NOR2X1 U1110 ( .A(n1050), .B(n1066), .Y(n1079) );
  NAND3X1 U1111 ( .A(haddr[3]), .B(n780), .C(n1041), .Y(n1066) );
  INVX1 U1112 ( .A(N82), .Y(n1077) );
  INVX1 U1113 ( .A(hrdata[2]), .Y(n1072) );
  OAI21X1 U1114 ( .A(n1071), .B(n1080), .C(n1081), .Y(n445) );
  OAI21X1 U1115 ( .A(n1082), .B(n1083), .C(n890), .Y(n1081) );
  OAI21X1 U1116 ( .A(n829), .B(n870), .C(n1084), .Y(n1083) );
  NAND2X1 U1117 ( .A(buffer_occ[3]), .B(n1055), .Y(n1084) );
  INVX1 U1118 ( .A(hwdata[3]), .Y(n829) );
  OAI21X1 U1119 ( .A(n1061), .B(n765), .C(n981), .Y(n1082) );
  NAND2X1 U1120 ( .A(rx_data[3]), .B(n873), .Y(n981) );
  INVX1 U1121 ( .A(hrdata[3]), .Y(n1080) );
  OAI21X1 U1122 ( .A(n1071), .B(n1085), .C(n1086), .Y(n444) );
  OAI21X1 U1123 ( .A(n1087), .B(n1088), .C(n890), .Y(n1086) );
  OAI21X1 U1124 ( .A(n822), .B(n870), .C(n1089), .Y(n1088) );
  NAND2X1 U1125 ( .A(buffer_occ[4]), .B(n1055), .Y(n1089) );
  INVX1 U1126 ( .A(hwdata[4]), .Y(n822) );
  OAI21X1 U1127 ( .A(n1061), .B(n766), .C(n985), .Y(n1087) );
  NAND2X1 U1128 ( .A(rx_data[4]), .B(n873), .Y(n985) );
  INVX1 U1129 ( .A(hrdata[4]), .Y(n1085) );
  OAI21X1 U1130 ( .A(n1071), .B(n1090), .C(n1091), .Y(n443) );
  OAI21X1 U1131 ( .A(n1092), .B(n1093), .C(n890), .Y(n1091) );
  OAI21X1 U1132 ( .A(n815), .B(n870), .C(n1094), .Y(n1093) );
  NAND2X1 U1133 ( .A(buffer_occ[5]), .B(n1055), .Y(n1094) );
  INVX1 U1134 ( .A(hwdata[5]), .Y(n815) );
  OAI21X1 U1135 ( .A(n1061), .B(n767), .C(n989), .Y(n1092) );
  NAND2X1 U1136 ( .A(rx_data[5]), .B(n873), .Y(n989) );
  INVX1 U1137 ( .A(hrdata[5]), .Y(n1090) );
  OAI21X1 U1138 ( .A(n1071), .B(n1095), .C(n1096), .Y(n442) );
  OAI21X1 U1139 ( .A(n1097), .B(n1098), .C(n890), .Y(n1096) );
  OAI21X1 U1140 ( .A(n808), .B(n870), .C(n1099), .Y(n1098) );
  NAND2X1 U1141 ( .A(buffer_occ[6]), .B(n1055), .Y(n1099) );
  NOR2X1 U1142 ( .A(n1070), .B(n1050), .Y(n1055) );
  NAND3X1 U1143 ( .A(haddr[3]), .B(n780), .C(n1100), .Y(n1070) );
  NOR2X1 U1144 ( .A(haddr[2]), .B(haddr[1]), .Y(n1100) );
  INVX1 U1145 ( .A(hwdata[6]), .Y(n808) );
  OAI21X1 U1146 ( .A(n1061), .B(n769), .C(n993), .Y(n1097) );
  NAND2X1 U1147 ( .A(rx_data[6]), .B(n873), .Y(n993) );
  NAND2X1 U1148 ( .A(n865), .B(n1101), .Y(n1061) );
  INVX1 U1149 ( .A(hrdata[6]), .Y(n1095) );
  INVX1 U1150 ( .A(n891), .Y(n1071) );
  NAND2X1 U1151 ( .A(n890), .B(n934), .Y(n891) );
  NAND2X1 U1152 ( .A(n905), .B(n1069), .Y(n934) );
  OR2X1 U1153 ( .A(n857), .B(n1013), .Y(n1069) );
  NOR2X1 U1154 ( .A(n906), .B(n1102), .Y(n857) );
  OAI21X1 U1155 ( .A(haddr[1]), .B(haddr[0]), .C(n1068), .Y(n1102) );
  INVX1 U1156 ( .A(n1041), .Y(n1068) );
  NOR2X1 U1157 ( .A(n782), .B(haddr[1]), .Y(n1041) );
  INVX1 U1158 ( .A(n1050), .Y(n905) );
  NAND2X1 U1159 ( .A(n1101), .B(n1025), .Y(n1050) );
  INVX1 U1160 ( .A(n865), .Y(n1025) );
  NAND2X1 U1161 ( .A(n935), .B(n1103), .Y(n890) );
  NOR2X1 U1162 ( .A(n859), .B(n1022), .Y(n935) );
  NOR2X1 U1163 ( .A(n858), .B(n873), .Y(n1022) );
  MUX2X1 U1164 ( .B(n1104), .A(n906), .S(n_rst), .Y(n406) );
  INVX1 U1165 ( .A(haddr[3]), .Y(n906) );
  MUX2X1 U1166 ( .B(n1037), .A(n781), .S(n_rst), .Y(n404) );
  INVX1 U1167 ( .A(write_select[1]), .Y(n1037) );
  MUX2X1 U1168 ( .B(n883), .A(n780), .S(n_rst), .Y(n403) );
  INVX1 U1169 ( .A(write_select[0]), .Y(n883) );
  MUX2X1 U1170 ( .B(n1105), .A(n792), .S(n_rst), .Y(n386) );
  NOR2X1 U1171 ( .A(n1106), .B(n1020), .Y(n792) );
  OAI21X1 U1172 ( .A(n1107), .B(n797), .C(n1011), .Y(n1020) );
  NAND3X1 U1173 ( .A(n1033), .B(n802), .C(prev_hsize[1]), .Y(n1011) );
  INVX1 U1174 ( .A(n806), .Y(n1033) );
  NAND2X1 U1175 ( .A(n802), .B(n1032), .Y(n797) );
  INVX1 U1176 ( .A(n879), .Y(n1032) );
  INVX1 U1177 ( .A(n1108), .Y(n802) );
  NOR2X1 U1178 ( .A(prev_hsize[0]), .B(prev_hsize[1]), .Y(n1107) );
  OAI22X1 U1179 ( .A(n1109), .B(n855), .C(n742), .D(n1108), .Y(n1106) );
  NAND3X1 U1180 ( .A(prev_hwrite), .B(n873), .C(hwrite), .Y(n1108) );
  NAND2X1 U1181 ( .A(n1101), .B(n1012), .Y(n855) );
  NOR2X1 U1182 ( .A(n1038), .B(n1110), .Y(n1012) );
  INVX1 U1183 ( .A(n1039), .Y(n1110) );
  NAND3X1 U1184 ( .A(prev_htrans[1]), .B(prev_hsel), .C(n1111), .Y(n1038) );
  NOR2X1 U1185 ( .A(prev_htrans[0]), .B(n882), .Y(n1111) );
  INVX1 U1186 ( .A(prev_hwrite), .Y(n882) );
  NOR2X1 U1187 ( .A(n873), .B(n1112), .Y(n1101) );
  NAND2X1 U1188 ( .A(n1104), .B(n887), .Y(n1109) );
  INVX1 U1189 ( .A(write_select[2]), .Y(n887) );
  INVX1 U1190 ( .A(write_select[3]), .Y(n1104) );
  INVX1 U1191 ( .A(store_tx_data), .Y(n1105) );
  MUX2X1 U1192 ( .B(n1113), .A(n1114), .S(n_rst), .Y(n352) );
  NOR2X1 U1193 ( .A(n1017), .B(n1115), .Y(n1114) );
  OAI21X1 U1194 ( .A(n803), .B(n964), .C(n1116), .Y(n1115) );
  NAND3X1 U1195 ( .A(n859), .B(n858), .C(n1013), .Y(n1116) );
  NOR2X1 U1196 ( .A(haddr[2]), .B(haddr[3]), .Y(n1013) );
  INVX1 U1197 ( .A(n1112), .Y(n858) );
  NOR2X1 U1198 ( .A(n1117), .B(n1118), .Y(n1112) );
  NAND3X1 U1199 ( .A(n1119), .B(n1120), .C(n1121), .Y(n1118) );
  XNOR2X1 U1200 ( .A(haddr[1]), .B(prev_haddr[1]), .Y(n1121) );
  XNOR2X1 U1201 ( .A(haddr[2]), .B(prev_haddr[2]), .Y(n1120) );
  XNOR2X1 U1202 ( .A(haddr[0]), .B(prev_haddr[0]), .Y(n1119) );
  NAND3X1 U1203 ( .A(prev_hwrite), .B(n877), .C(n1122), .Y(n1117) );
  XNOR2X1 U1204 ( .A(haddr[3]), .B(prev_haddr[3]), .Y(n1122) );
  NOR2X1 U1205 ( .A(n1039), .B(n873), .Y(n859) );
  NAND3X1 U1206 ( .A(htrans[1]), .B(hsel), .C(n1123), .Y(n1039) );
  NOR2X1 U1207 ( .A(hwrite), .B(htrans[0]), .Y(n1123) );
  NAND3X1 U1208 ( .A(state[0]), .B(n1021), .C(state[1]), .Y(n803) );
  OAI22X1 U1209 ( .A(n936), .B(n868), .C(n865), .D(n1103), .Y(n1017) );
  INVX1 U1210 ( .A(n866), .Y(n1103) );
  NOR2X1 U1211 ( .A(n964), .B(n879), .Y(n866) );
  NAND3X1 U1212 ( .A(n1015), .B(n1021), .C(state[0]), .Y(n879) );
  INVX1 U1213 ( .A(state[1]), .Y(n1015) );
  NOR2X1 U1214 ( .A(hsize[1]), .B(hsize[0]), .Y(n865) );
  INVX1 U1215 ( .A(hsize[1]), .Y(n868) );
  INVX1 U1216 ( .A(n867), .Y(n936) );
  NOR2X1 U1217 ( .A(n964), .B(n806), .Y(n867) );
  NAND3X1 U1218 ( .A(n1034), .B(n1021), .C(state[1]), .Y(n806) );
  INVX1 U1219 ( .A(state[2]), .Y(n1021) );
  INVX1 U1220 ( .A(state[0]), .Y(n1034) );
  NAND2X1 U1221 ( .A(n877), .B(n873), .Y(n964) );
  INVX1 U1222 ( .A(hready), .Y(n873) );
  INVX1 U1223 ( .A(hwrite), .Y(n877) );
  INVX1 U1224 ( .A(get_rx_data), .Y(n1113) );
endmodule

