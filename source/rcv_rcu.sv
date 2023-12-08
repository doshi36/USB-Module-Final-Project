
module rcv_rcu (
    input logic clk, 
    input logic n_rst,
    input logic edge_sig, 
    input logic byte_finish, 
    input logic eop, 
    input logic packet_done,
    input logic [7:0] rx_shift_register, 
    input logic [1:0] reg_state,

    output logic flush, 
    output logic rx_transfer_active, 
    output logic rx_data_ready, 
    output logic rx_error, 
    output logic store_rx_packet_data,
    output logic [2:0] rx_packet
);

    typedef enum logic [4:0] {
        idle_state, 
        rx_sync_state, 
        rx_chk_state, 
        error_state, 
        rx_pid_state, 
        rx_chk_pid_state, 
        eop_state, 
        none_state, 
        rx_data_state, 
        load_state, 
        rx_rdy_state, 
        eidle_state,
        wait_state
    } state_type;

    state_type state, nxt_state;

    always_ff @ (posedge clk, negedge n_rst) begin 

        if(n_rst == 'b0) begin 
            state <= idle_state;
        end 
        else begin 
            state <= nxt_state;
        end 

    end

    always_comb begin : NEXT_STATE_LOGIC

        nxt_state = state;

        case(state) 

            idle_state:   
                        begin
                            if (edge_sig) begin
                                nxt_state = rx_sync_state;
                            end
                            else begin
                                nxt_state = idle_state;
                            end
                        end

            rx_sync_state :   nxt_state = (byte_finish) ? rx_chk_state : rx_sync_state;

            rx_chk_state  :   
                            begin 
                                if(rx_shift_register == 8'b0000001) begin 
                                    nxt_state = rx_pid_state;
                                end else begin 
                                    nxt_state = error_state;
                                end
                            end

            rx_pid_state  :   nxt_state = (byte_finish) ? rx_chk_pid_state : rx_pid_state;

            rx_chk_pid_state  :   
                                begin 
                                    if(((rx_shift_register) == 8'b01011010) || ((rx_shift_register) == 8'b01001011)) begin       // ack, nak packets
                                        nxt_state = none_state;
                                    end 
                                    else if (((rx_shift_register) == 8'b10000111) || ((rx_shift_register) == 8'b10010110)) begin // in, out data packets
                                        nxt_state = none_state;
                                    end 
                                    else if (((rx_shift_register) == 8'b11000011) || ((rx_shift_register) == 8'b11010010)) begin // data0, data1 packets 
                                        nxt_state = rx_data_state;
                                    end else begin 
                                        nxt_state = error_state;
                                    end
                                end

            rx_data_state :   
                            begin 
                                if(byte_finish) begin 
                                    nxt_state = load_state;
                                end 
                                else if(eop) begin
                                    nxt_state = error_state;
                                end
                            end

            load_state    :   nxt_state = wait_state;

            wait_state    :   
                            begin 
                                if(!eop && packet_done) begin 
                                    nxt_state = rx_data_state;
                                end 
                                else if(packet_done && eop) begin 
                                    nxt_state = eop_state;
                                end 
                            end

            rx_rdy_state  :   
                        begin 
                            if(edge_sig) begin 
                                nxt_state = rx_sync_state;
                            end
                        end

            none_state   :   
                        begin 
                            if(packet_done & eop) begin 
                                nxt_state = eop_state;
                            end
                        end

            eop_state    :   
                        begin
                            if((reg_state == 2 || reg_state == 1)) begin 
                                nxt_state = eidle_state;
                            end 
                            else if (reg_state == 3) begin
                                nxt_state = rx_rdy_state;
                            end 
                        end  

            error_state  :   
                            begin
                                if (reg_state == 3) begin
                                    nxt_state = eidle_state;
                                end
                            end
        endcase
    end

    
    always_comb begin : RXCU_OUTPUT_LOGIC

        rx_data_ready = (state == rx_rdy_state);
        rx_error = (state == eidle_state || state == error_state);
        rx_transfer_active = (state != eidle_state) && (state != idle_state) && (state != rx_rdy_state);
        flush = (state == rx_sync_state);

        if(rx_shift_register == 8'b01001011) begin      //ACK packet
            rx_packet = 'h5;
        end 
        else if(rx_shift_register == 8'b01011010) begin //NAK packet
            rx_packet = 'h6;
        end 
        else if(rx_shift_register == 8'b10000111) begin //OUT packet
            rx_packet = 'h2;
        end 
        else if(rx_shift_register == 8'b10010110) begin //IN packet
            rx_packet = 'h1;
        end 
        else begin 
            rx_packet = 'h0;
        end

        store_rx_packet_data = (state == wait_state);

    end


endmodule