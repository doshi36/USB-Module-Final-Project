module rcu (

    input logic clk,
    input logic n_rst, 
    input logic new_packet_detected,
    input logic packet_done,
    input logic framing_error,

    output logic sbc_clear,
    output logic sbc_enable,
    output logic load_buffer,
    output logic enable_timer
);

typedef enum logic [5:0] {IDLE,  
                          ENT, 
                          RCVS, 
                          EIDLE, 
                          ERROR, 
                          CHKS,
                          RCVPID,
                          CHKP,
                          RCVD,
                          LOAD,
                          WAIT1,
                          WAIT2,
                          END1,
                          END2,
                          DATARDY} state_type;

    state_type state;
    state_type nxt_state;

    always_ff @(posedge clk, negedge n_rst) begin
        if (!n_rst)
            state <= IDLE;
        else 
            state <= nxt_state;
    end

    always_comb begin : NEXT_STATE_LOGIC
        nxt_state = state;
        
        case (state)
            IDLE    :
            ENT     : 
            RCVS    :
            EIDLE   :
            ERROR   :
            CHKS    :
            RCVPID  :
            CHKP    :
            RCVD    :
            LOAD    :
            WAIT1   :
            WAIT2   :
            END1    :
            END2    :
            DATARDY :
        endcase
    end

    always_comb begin : OUTPUT_LOGIC

    end
    
endmodule