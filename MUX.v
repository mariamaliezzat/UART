module MUX (
    input   [1:0]          mux_sel,
    input                  start_bit,
    input                  stop_bit,
    input                  serial_data,
    input                  parity_bit,
    output         reg     TX_OUT
);
assign  start_bit = 'd0;
assign  stop_bit  = 'd1;
localparam IDLE   ='d1 ;
always @(*) begin
    case (mux_sel)
       2'b00 :
        begin
            TX_OUT = start_bit;
        end 
       2'b01 :
       begin
           TX_OUT = stop_bit;
       end 
       2'b10 :
        begin
            TX_OUT = serial_data;
        end 
       2'b11 :
        begin
            TX_OUT = parity_bit;
        end 
        default: TX_OUT = IDLE;
    endcase
end
endmodule