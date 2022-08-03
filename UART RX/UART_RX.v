module UART_RX (
    input          clk,
    input          rst,
    input          PAR_TYP, 
    input          PAR_EN, 
    input  [4:0]   Prescale, 
    input          RX_IN,
    output [7:0]   P_Data, 
    output         Data_valid
);
    wire [4:0] edge_counter1;
    wire [3:0] bit_counter1;
    wire partiy_error1   ;
    wire stop_error1     ;
    wire strat_glitch1   ;
    wire data_sample_enable1;
    wire enable1;
    wire deserializer_enable1;
    wire stop_check_enable1;
    wire start_check_enable1;
    wire parity_check_enable1;
    FSM FSM1 (
    .clk(clk),
    .rst(rst),
    .RX_IN(RX_IN),
    .PAR_EN(PAR_EN),
    .edge_counter(edge_counter1),
    .bit_counter(bit_counter1),
    .partiy_error(partiy_error1),
    .stop_error(stop_error1),
    .strat_glitch(strat_glitch1),
    .Prescale(Prescale),
    .data_sample_enable(data_sample_enable1),
    .enable(enable1),
    .deserializer_enable(deserializer_enable1),
    .data_Valid(Data_valid),
    .stop_check_enable(stop_check_enable1),
    .start_check_enable(start_check_enable1),
    .parity_check_enable(parity_check_enable1)
    );
    wire sampled_bit1;
    Parity_Check Parity_Check1 (
    .parity_check_enable(parity_check_enable1),
    .Prescale(Prescale),
    .sampled_bit(sampled_bit1),
    .PAR_TYP(PAR_TYP),
    .edge_counter(edge_counter1),
    .bit_counter(bit_counter1),
    .P_Data(P_Data),
    .partiy_error(partiy_error1)
    );
    Start_Check Start_Check1 (
    .start_check_enable(start_check_enable1),
    .sampled_bit(sampled_bit1),
    .strat_glitch(strat_glitch1)
    );
    Stop_Check Stop_Check1 (
    .stop_check_enable(stop_check_enable1),
    .sampled_bit(sampled_bit1),
    .stop_error(stop_error1)
    );
    Edge_Bit_Counter Edge_Bit_Counter1(
    .enable(enable1),
    .clk(clk),
    .rst(rst),
    .Prescale(Prescale),
    .edge_counter(edge_counter1),
    .bit_counter(bit_counter1)
    );
    Deserializer Deserializer1 (
    .deserializer_enable(deserializer_enable1),
    .sampled_bit(sampled_bit1),
    .Prescale(Prescale),
    .bit_counter(bit_counter1),
    .edge_counter(edge_counter1),
    .P_Data(P_Data)
    );
    Data_Sampling Data_Sampling1 (
    .data_sample_enable(data_sample_enable1),
    .edge_counter(edge_counter1),
    .RX_IN(RX_IN),
    .clk(clk),
    .rst(rst),
    .Prescale(Prescale),
    .sampled_bit(sampled_bit1)             
    );

endmodule

