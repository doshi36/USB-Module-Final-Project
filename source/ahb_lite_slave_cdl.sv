module ahb_lite_slave_cdl
(
    input logic clk, n_rst, hsel, hwrite, rx_data_ready, rx_transfer_active, rx_error, tx_error, tx_transfer_active,
    input logic [3:0] haddr,
    input logic [1:0] htrans, hsize,
    input logic [31:0] hwdata,
    output logic [31:0] hrdata,
    output logic hresp, hready, d_mode, get_rx_data, store_tx_data, clear,
    input logic [2:0] rx_packet,
    input logic [6:0] buffer_occ,
    input logic [7:0] rx_data,
    output logic [7:0] tx_data,
    output logic [2:0] tx_packet 
);

typedef enum logic [2:0] {idle, byte1, byte2, byte3, byte4} state_name;
state_name state;
state_name next_state;

logic [1:0] prev_hsize, prev_htrans;
logic [2:0] next_tx_packet;
logic next_hready, next_hresp, prev_hwrite, prev_hsel, next_clear, next_get_rx_data, next_store_tx_data;
logic [3:0] read_select, write_select, next_write_select, prev_haddr;
logic [31:0] next_hrdata;
logic [7:0] next_tx_data;

assign read_select = haddr;
assign next_write_select = haddr;

always_ff @ (posedge clk, negedge n_rst)
begin
    if (n_rst == 1'b0) begin
        hresp <= 0;
        hrdata <= '0;
        tx_packet <= '0;
        tx_data <= '0;
        clear <= '0;
        prev_hsize <= '0;
        prev_htrans <= '0;
        prev_haddr <= '0;
        prev_hwrite <= '0;
        prev_hsel <= '0;
        hready <= 0;
        state <= idle;
    end
    else begin
        hready <= next_hready;
        hresp <= next_hresp;
        hrdata <= next_hrdata;
        tx_packet <= next_tx_packet;
        tx_data <= next_tx_data;
        clear <= next_clear;
        write_select <= next_write_select;
        prev_hsize <= hsize;
        prev_haddr <= haddr;
        prev_htrans <= htrans;
        prev_hwrite <= hwrite;
        prev_hsel <= hsel;
        state <= next_state;
        get_rx_data <= next_get_rx_data;
        store_tx_data <= next_store_tx_data;
    end
end

always_comb begin
    next_hready = 1;
    next_hresp = 0;
    next_hrdata = hrdata;
    next_get_rx_data = 0;
    next_store_tx_data = 0;
    next_tx_packet = 0;
    next_tx_data = '0;
    next_clear = 0;
    next_state = state;
    if (hready) begin
        if ((prev_haddr == haddr) && (prev_hwrite && ~hwrite)) begin
            next_hrdata = hwdata;
        end
        else if (hsel == 1 && htrans == 2'b10 && hwrite == 0)
        begin
            if (hsize == 2'b00)
            begin
                case(read_select)
                    4'h0, 4'h1, 4'h2, 4'h3 : begin
                                                next_state = byte1;
                                                next_hready = 0;
                                                next_get_rx_data = 1;
                    end
                    4'h4       : next_hrdata = {24'b0, 3'b0, (rx_packet == 3'd6 ? 1 : 0), (rx_packet == 3'd5 ? 1 : 0), (rx_packet == 3'd1 ? 1 : 0),(rx_packet == 3'd2 ? 1 : 0), rx_data_ready};
                    4'h5       : next_hrdata = {16'b0, 6'b0, tx_transfer_active, rx_transfer_active, 8'b0};
                    4'h6       : next_hrdata = {24'b0, 7'b0, rx_error};
                    4'h7       : next_hrdata = {16'b0, 7'b0, tx_error, 8'b0};
                    4'h8       : next_hrdata = {16'b0, 9'b0, buffer_occ};
                    4'h9, 4'ha, 4'hb : begin
                                        next_hready = 0;
                                        next_hresp = 1;
                                    end   
                    4'hc       : next_hrdata = {29'b0, tx_packet};
                    4'hd       : next_hrdata = {31'b0, clear};
                    default    : begin
                                    next_hready = 0;
                                    next_hresp = 1;
                                end
                endcase
            end
            else
            begin
                case(read_select)
                    4'h0, 4'h1, 4'h2, 4'h3 : begin
                                                next_state = byte1;
                                                next_hready = 0;
                                                next_get_rx_data = 1;
                    end
                    4'h4, 4'h5 : next_hrdata = {16'b0, 6'b0, tx_transfer_active, rx_transfer_active, 3'b0, (rx_packet == 3'd6 ? 1 : 0), (rx_packet == 3'd5 ? 1 : 0), (rx_packet == 3'd1 ? 1 : 0),(rx_packet == 3'd2 ? 1 : 0), rx_data_ready};
                    4'h6, 4'h7 : next_hrdata = {16'b0, 7'b0, tx_error, 7'b0, rx_error};
                    4'h8       : next_hrdata = {16'b0, 9'b0, buffer_occ};
                    4'h9, 4'ha, 4'hb : begin
                                        next_hready = 0;
                                        next_hresp = 1;
                                    end 
                    4'hc       : next_hrdata = {29'b0, tx_packet};
                    4'hd       : next_hrdata = {31'b0, clear};
                    default    : begin
                                    next_hready = 0;
                                    next_hresp = 1;
                                end
                endcase
            end    
        end

        else if (prev_hsel == 1 && prev_htrans == 2'b10 && prev_hwrite == 1)
        begin
            case (write_select)
                4'h0, 4'h1, 4'h2, 4'h3 : begin
                                            next_state = byte1;
                                            next_hready = 0;
                                            next_store_tx_data = 1;
                                            next_tx_packet = 3'b001;
                end
                4'hc  : next_tx_packet = hwdata[2:0];
                4'hd  : next_clear = hwdata[8];
                default    : begin
                                next_hready = 0;
                                next_hresp = 1;
                            end
            endcase
        end
    end

    else begin
        case(state)
            byte1  : begin
                        next_state = idle;
                        if (~hwrite) begin
                            next_hrdata[7:0] = rx_data;
                            if (hsize >= 2'b01) begin
                                next_get_rx_data = 1;
                                next_hready = 0;
                                next_state = byte2;  
                            end   
                        end  
                        else if (prev_hwrite) begin
                            next_tx_data = hwdata[7:0];
                            next_tx_packet = 3'b000;
                            if (prev_hsize >= 2'b01) begin
                                next_store_tx_data = 1;
                                next_hready = 0;
                                next_state = byte2; 
                                next_tx_packet = 3'b001; 
                            end   
                        end         
            end
            byte2  : begin
                        next_state = idle;
                        if (~hwrite) begin
                            next_hrdata[15:8] = rx_data;
                            if (hsize >= 2'b10) begin
                                next_get_rx_data = 1;
                                next_hready = 0;  
                                next_state = byte3;  
                            end 
                        end
                        else if (prev_hwrite) begin
                            next_tx_data = hwdata[15:8];
                            next_tx_packet = 3'b000;
                            if (prev_hsize >= 2'b10) begin
                                next_store_tx_data = 1;
                                next_hready = 0;
                                next_state = byte3; 
                                next_tx_packet = 3'b001; 
                            end   
                        end               
            end
            byte3  : begin
                        if (~hwrite) begin
                            next_hrdata[23:16] = rx_data;
                            next_get_rx_data = 1;
                            next_hready = 0;    
                        end   
                        else if (prev_hwrite) begin
                            next_tx_packet = 3'b001;
                            next_tx_data = hwdata[23:16];
                            next_store_tx_data = 1;
                            next_hready = 0;  
                        end    
                        next_state = byte4;  
            end
            byte4  : begin
                        if (~hwrite) 
                            next_hrdata[31:24] = rx_data;  
                        else if (prev_hwrite)
                            next_tx_data = hwdata[31:24];
                            next_tx_packet = 3'b001;
                        next_state = idle;         
            end
        endcase
    end

end

endmodule