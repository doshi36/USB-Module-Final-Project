module rcv_edge_detector(

    input logic clk, 
    input logic n_rst,
    input logic d_plus_sync, 

    output logic edge_sig
    
);
    logic temp;

    always_ff @ (posedge clk, negedge n_rst) begin 
        if(n_rst == 'b0) begin 
            temp <= 'b1;
        end 
        else begin 
            temp <= d_plus_sync;
        end 
    end

    assign edge_sig = temp ^ d_plus_sync; 

endmodule