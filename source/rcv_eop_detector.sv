module rcv_eop_detector (
    input logic clk,
    input logic n_rst, 
    input logic packet_done,
    input logic d_plus_sync, 
    input logic d_minus_sync,

    output logic eop,
    output logic [1:0] reg_state
);

    typedef enum logic [2:0] {
        idle_state, 
        mid1_state, 
        mid2_state, 
        eop_state, 
        transit_err_state, 
        error_state
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
        
        nxt_state = state;  //default to avoid any latches 
        case(state) 
            idle_state:   
                        begin 
                            if (~d_minus_sync && ~d_plus_sync && packet_done) begin 
                                nxt_state = mid1_state;
                            end
                        end
            mid1_state:   
                        begin 
                            if (~d_minus_sync && ~d_plus_sync && packet_done) begin 
                                nxt_state = mid2_state;
                            end 
                            else if (packet_done) begin 
                                nxt_state = transit_err_state;
                            end
                        end
            transit_err_state:   nxt_state = idle_state;
            mid2_state:   
                        begin
                            if (~d_minus_sync && d_plus_sync && packet_done) begin 
                                nxt_state = eop_state;
                            end 
                            else if (packet_done) begin 
                                nxt_state = error_state;
                            end
                        end
            eop_state:    nxt_state = idle_state;
                        
            error_state:  nxt_state = idle_state;
        endcase

    end

    always_comb begin : OUTPUT_LOGIC

        eop = packet_done && ~d_plus_sync && ~d_minus_sync;
        
        case(state)  
            idle_state         :   reg_state = 0;
            error_state        :   reg_state = 2;
            eop_state          :   reg_state = 3;
            transit_err_state  :   reg_state = 1;
            default            :   reg_state = 0;
        endcase

    end
endmodule