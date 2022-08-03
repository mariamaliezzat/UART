`timescale 1ns/1ps
module UART_RX_tb;
reg        clk_tb;
reg        rst_tb;
reg        PAR_TYP_tb;
reg        PAR_EN_tb;
reg  [4:0] Prescale_tb;
reg        RX_IN_tb;
wire [7:0] P_Data_tb; 
wire       Data_valid_tb;
localparam clock_period = 'd50 ;
initial 
    begin
        initialize();
        reset();
        //          

    end
task initialize;
    begin
        clk_tb = 'd1;
        rst_tb = 'd1;
    end
endtask
task reset;
    begin
        #(clock_period/4.0)
        rst_tb = 'd0;
        #(clock_period*2)
        rst_tb = 'd1;
    end
endtask
////////////////////////////////////////////////////////
////////////////// Clock Generator  ////////////////////
////////////////////////////////////////////////////////
always #(clock_period/2.0)  clk_tb = !clk_tb ;

////////////////////////////////////////////////////////
/////////////////// DUT Instantation ///////////////////
////////////////////////////////////////////////////////

UART_RX DUT (
    .clk(clk_tb),
    .rst(rst_tb),
    .PAR_TYP(PAR_TYP_tb), 
    .PAR_EN(PAR_EN_tb), 
    .Prescale(Prescale_tb), 
    .RX_IN(RX_IN_tb),
    .P_Data(P_Data_tb), 
    .Data_valid(Data_valid_tb)
);
endmodule