module UART_TX (
    input          parity_enable,
    input          Parity_Type,
    input          clk,
    input          rst,
    input          Data_Valid,
    input  [7:0]   P_Data,
    output         busy,
    output         TX_OUT
);


wire serial_done1;
wire serial_enable1;
wire serial_data1;

serializer serializer1 (
    .P_Data(P_Data),
    .serial_enable(serial_enable1),
    .clk(clk),
    .rst(rst),
    .serial_done(serial_done1),
    .serial_data(serial_data1)
);

wire [1:0] mux_sel1;

FSM FSM1(
    .parity_enable(parity_enable),
    .Data_Valid(Data_Valid),
    .serial_done(serial_done1),
    .rst(rst),
    .clk(clk),
    .busy(busy), 
    .serial_enable(serial_enable1), 
    .mux_sel(mux_sel1)
);

wire parity_bit1;
parity_calc parity_calc1(
    .Data_Valid(Data_Valid),
    .Parity_Type(Parity_Type),
    .P_Data(P_Data),
    .parity_bit(parity_bit1)
);

wire start_bit1;
wire stop_bit1;
MUX MUX1(
    .mux_sel(mux_sel1),
    .start_bit(start_bit1),
    .stop_bit(stop_bit1),
    .serial_data(serial_data1),
    .parity_bit(parity_bit1),
    .TX_OUT(TX_OUT)
);
endmodule