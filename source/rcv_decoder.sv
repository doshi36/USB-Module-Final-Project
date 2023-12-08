module rcv_decoder (
    input logic clk,
    input logic n_rst,
    input logic d_plus_sync,
    input logic packet_done, 

    output logic d_prim
);
    logic tmpreg_d;

    always_ff @ (posedge clk, negedge n_rst) begin
       if(n_rst == 1'b0) begin 
            tmpreg_d <= 'b1;
       end 
       else if(packet_done) begin
            tmpreg_d <= d_plus_sync; 
       end 
       else begin 
            tmpreg_d <= tmpreg_d;
       endcd
    end

    always_comb begin
        if (tmpreg_d ~^ d_plus_sync) begin
            d_prim = '1;
        end
        else begin
            d_prim = '0;
        end
    end

endmodule