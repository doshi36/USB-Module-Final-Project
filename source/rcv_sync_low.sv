module rcv_sync_low(
    input logic clk,
    input logic n_rst,
    input logic async_in,
    output logic sync_out
);
    logic temp;
    always_ff @ (posedge clk, negedge n_rst) begin 
        if (n_rst == 1'b0) begin
            temp <= '0;
            sync_out <= '0;
        end
        else begin
            temp <= async_in;
            sync_out <= temp;
        end
    end

endmodule