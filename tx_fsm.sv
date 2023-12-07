// $Id: $
// File name:   tx_fsm.sv
// Created:     12/6/2023
// Author:      Austin Bohlmann
// Lab Section: 337-009
// Version:     1.0  Initial Design Entry
// Description: Finite State Machine for TX module of CDL
module tx_fsm(input logic clk, input logic n_rst,
                input logic [1:0] TX_packet, input logic [6:0] buff_occ,
                input logic cnt_7bits, input logic shift_en, 
                output logic TX_Error, output logic TX_Transfer_Active, 
                output logic Get_TX_Data, output logic timer_en, output logic load_data,
                output logic [2:0] bit_type);

typedef enum logic [4:0] {IDLE, PRESYNC, SYNC, ACK1, ACK2, NAK1, NAK2, STALL1, STALL2,
                         DATA1, DATA2, READ_DATA, ERR, HOLD_DATA, PULL_PACKET, EOP, EOP_IDLE} fsm;
fsm state, next_state;

logic [2:0] nbit;

logic [3:0] outsigs;
logic [3:0] nout;
assign TX_Error = outsigs[3];
assign TX_Transfer_Active = outsigs[2];
assign load_data = outsigs[1];
assign timer_en = outsigs[0];

logic ngetdata;

//State Transitioning, register all outputs
always_ff @ (posedge clk, negedge n_rst) begin
    if(~n_rst) begin
        state <= IDLE;
        bit_type <= 3'b000;
        outsigs <= 4'b0000;
        Get_TX_Data <= 1'b0;
    end else begin
        state <= next_state;
        bit_type <= nbit;
        outsigs <= nout;
        Get_TX_Data <= ngetdata;
    end
end

always_comb begin
    case(state)
        default : begin
            next_state = state;
            nbit = bit_type;
            nout = outsigs;
        end
        IDLE : begin
            if(TX_packet != 3'b000) begin
                next_state = PRESYNC;
                nbit = 3'b001; //SYNC
                nout = 4'b0111;
                ngetdata = 1'b0;
            end
            else begin
                next_state = IDLE;
                nbit = 3'b000;
                nout = 4'b0000;
                ngetdata = 1'b0;
            end
         end
        PRESYNC : begin
            next_state = SYNC;
            nbit = 3'b001;
            nout = 4'b0101;
            ngetdata = 1'b0;
        end
        SYNC : begin
            if(cnt_7bits) begin
                if(TX_packet == 2'b01) begin//ACK path
                    next_state = ACK1;
                    nbit = 3'b010;
                    nout = 4'b0101;
                    ngetdata = 1'b0;
                end
                else if(TX_packet == 2'b10) begin //NAK path
                    next_state = NAK1;
                    nbit = 3'b011;
                    nout = 4'b0101;
                    ngetdata = 1'b0;
                end
                else if(TX_packet == 2'b11) begin //STALL path
                    next_state = STALL1;
                    nout = 4'b0101;
                    nbit = 3'b100;
                    ngetdata = 1'b0;
                end
                else if(TX_packet == 2'b00) begin //DATA Path
                    next_state = DATA1;
                    nout = 4'b0101;
                    nbit = 3'b101;
                    ngetdata = 1'b0;
                end
                else begin
                    next_state = state;
                    nout = outsigs;
                    nbit = bit_type;
                    ngetdata = 1'b0;
                end
            end
            else begin
                next_state = state;
                nout = outsigs;
                nbit = bit_type;
                ngetdata = 1'b0;
            end
        end
        ACK1 : begin
            if(shift_en) begin
                next_state = ACK2;
                nout = 4'b0101;
                nbit = 3'b010;
                ngetdata = 1'b0;
            end else begin
                next_state = ACK1;
                nout = 4'b0101;
                nbit = 3'b010;
                ngetdata = 1'b0;
            end
        end
        ACK2 : begin
            if(cnt_7bits && shift_en) begin
                next_state = EOP;
                nout = 4'b0101;
                nbit = 3'b111;
                ngetdata = 1'b0;
            end else begin
                next_state = ACK2;
                nout = 4'b0101;
                nbit = 3'b010;
                ngetdata = 1'b0;
            end
        end
        NAK1 : begin
            if(shift_en) begin
                next_state = NAK2;
                nout = 4'b0101;
                nbit = 3'b011;
                ngetdata = 1'b0;
            end else begin
                next_state = NAK1;
                nout = 4'b0101;
                nbit = 3'b011;
                ngetdata = 1'b0;
            end
        end
        NAK2 : begin
            if(cnt_7bits && shift_en) begin
                next_state = EOP;
                nout = 4'b0101;
                nbit = 3'b111;
                ngetdata = 1'b0;
            end else begin
                next_state = NAK2;
                nout = 4'b0101;
                nbit = 3'b011;
                ngetdata = 1'b0;
            end
        end
        STALL1 : begin
            if(shift_en) begin
                next_state = STALL2;
                nout = 4'b0101;
                nbit = 3'b100;
                ngetdata = 1'b0;
            end else begin
                next_state = STALL1;
                nout = 4'b0101;
                nbit = 3'b100;
                ngetdata = 1'b0;
            end
        end
        STALL2 : begin
            if(cnt_7bits && shift_en) begin
                next_state = EOP;
                nout = 4'b0101;
                nbit = 3'b111;
                ngetdata = 1'b0;
            end else begin
                next_state = STALL2;
                nout = 4'b0101;
                nbit = 3'b100;
                ngetdata = 1'b0;
            end
        end
        DATA1 : begin
            if(shift_en) begin
                next_state = DATA2;
                nout = 4'b0101;
                nbit = 3'b101;
                ngetdata = 1'b0;
            end else begin
                next_state = DATA1;
                nout = 4'b0101;
                nbit = 3'b101;
                ngetdata = 1'b0;
            end
        end
        DATA2 : begin
            if(cnt_7bits) begin
                if(buff_occ == 0) begin //if trying to pull data from empty buffer, throw error
                    next_state = ERR;
                    nout = 4'b1100;
                    nbit = 3'b000;
                    ngetdata = 1'b0;
                end else begin
                    next_state = READ_DATA; 
                    nout = 4'b0101;
                    nbit = 3'b110;
                    ngetdata = 1'b1;
                end
            end
            else begin
                next_state = DATA2;
                nout = 4'b0101;
                nbit = 3'b101;
                ngetdata = 1'b0;
            end
        end
        READ_DATA : begin
            if(shift_en) begin
                next_state = HOLD_DATA; 
                nout = 4'b0101;
                nbit = 3'b110;
                ngetdata = 1'b0;
            end
            else begin
                next_state = READ_DATA; 
                nout = 4'b0101;
                nbit = 3'b110;
                ngetdata = 1'b1;
            end
        end
        HOLD_DATA : begin
            if(cnt_7bits) begin
                if(buff_occ != 0) begin
                    next_state = PULL_PACKET;       //HOLD -> PULL
                    nout = 4'b0101;
                    nbit = 3'b101;
                    ngetdata = 1'b1;
                end
                else if((buff_occ == 0) && shift_en) begin  //HOLD -> EOP
                    next_state = EOP;
                    nout = 4'b0101;
                    nbit = 3'b111;
                    ngetdata = 1'b0;
                end
            end else begin
                next_state = HOLD_DATA;    //stay
                nout = 4'b0101;
                nbit = 3'b110;
                ngetdata = 1'b0;
            end
        end
        PULL_PACKET : begin
            next_state = READ_DATA; 
            nout = 4'b0101;
            nbit = 3'b110;
            ngetdata = 1'b1;
        end
        EOP : begin
            if(shift_en) begin
                next_state = EOP_IDLE;
                nout = 4'b0101;
                nbit = 3'b111;
                ngetdata = 1'b0;
            end else begin
                next_state = EOP;
                nout = 4'b0101;
                nbit = 3'b111;
                ngetdata = 1'b0;
            end
        end
        EOP_IDLE : begin
            if(shift_en) begin
                next_state = IDLE;
                nout = 4'b0000;
                nbit = 3'b000;
                ngetdata = 1'b0;
            end else begin
                next_state = EOP_IDLE;
                nout = 4'b0101;
                nbit = 3'b111;
                ngetdata = 1'b0;
            end
        end
        ERR : begin
            next_state = IDLE;
            nout = 4'b0000;
            nbit = 3'b000;
            ngetdata = 1'b0;
        end
    endcase
end

endmodule
