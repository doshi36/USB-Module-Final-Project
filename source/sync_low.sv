module sync_low(
    input logic clk,
    input logic n_rst,
    input logic async_in,
    output logic sync_out
);
    logic temp;
    always_ff @ (posedge clk, negedge n_rst) begin 
        if (1'b0 == n_rst) begin
            temp <= '0;
            sync_out <= '0;
        end
        else begin
            temp <= async_in;
            sync_out <= temp;
        end
    end

endmodule