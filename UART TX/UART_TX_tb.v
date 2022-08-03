`timescale 1ns/1ps
module UART_TX_tb;
////////////////////////////////////////////////////////
/////////////////// DUT Signals //////////////////////// 
////////////////////////////////////////////////////////
reg          parity_enable_tb ;
reg          Parity_Type_tb   ;
reg          clk_tb           ;
reg          rst_tb           ;
reg          Data_Valid_tb    ;
reg  [7:0]   P_Data_tb        ;
wire         busy_tb          ;
wire         TX_OUT_tb        ;

reg [3:0] clock_period ;
initial
    begin
        // Save Waveform
        $dumpfile("UART_TX.vcd") ;       
        $dumpvars; 
        clock_period = 'd5;
        //initialization
        initialize();
        //reset
        reset();
        /******test case 1  without parity ********/
        $display("case 1 without parity");
        $display("**************************************************");
        without_parity();

        /******test case 2  with even parity ********/
        $display("case 2 with even parity ");
        $display("**************************************************");
        even_parity();

        /******test case 3  with odd parity ********/
        $display("case 3 with odd parity ");
        $display("**************************************************");
        odd_parity();

        /******test case 4  2 successive frames********/
        $display("case 4 2 successive frames");
        $display("**************************************************");
        successive_frames();




        #clock_period
        #clock_period
        $finish;


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
task without_parity;
    begin
        $display(" test 1 at idle state tx_out = 1");
        if (TX_OUT_tb == 'd1) 
            begin
                $display(" test 1 passed ");
            end 
        else 
            begin
               $display(" test 1 failed "); 
            end
        #clock_period
        parity_enable_tb = 'd0;
        Data_Valid_tb    = 'd1;
        P_Data_tb        = 'b00001111;
        #clock_period
        $display(" test 2 start bit of the frame = 0");
        if (TX_OUT_tb == 'd0) 
            begin
                $display(" test 2 passed ");
            end 
        else 
            begin
                $display(" test 2 failed "); 
            end
        #clock_period
        $display(" data = 00001111");
        $display(" test 3 P_Data[0] = 1");
        if (TX_OUT_tb == 'd1) 
            begin
                $display(" test 3 passed ");
            end 
        else 
            begin
                $display(" test 3 failed "); 
            end
        #clock_period
        $display(" test 4 P_Data[1] = 1");
        if (TX_OUT_tb == 'd1) 
            begin
                $display(" test 4 passed ");
            end 
        else 
            begin
                $display(" test 4 failed "); 
            end
        #clock_period
        $display(" test 5 P_Data[2]= 1");
        if (TX_OUT_tb == 'd1) 
            begin
                $display(" test 5 passed ");
            end 
        else 
            begin
                $display(" test 5 failed "); 
            end
        #clock_period
        $display(" test 6 P_Data[3] = 1");
        if (TX_OUT_tb == 'd1) 
            begin
                $display(" test 6 passed ");
            end 
        else 
            begin
                $display(" test 6 failed "); 
            end
        #clock_period
        $display(" test 7 P_Data[4] = 0");
        if (TX_OUT_tb == 'd0) 
            begin
                $display(" test 7 passed ");
            end 
        else 
            begin
                $display(" test 7 failed "); 
            end
        #clock_period
        $display(" test 8 P_Data[5]= 0");
        if (TX_OUT_tb == 'd0) 
            begin
                $display(" test 8 passed ");
            end 
        else 
            begin
                $display(" test 8 failed "); 
            end
        #clock_period
        $display(" test 9 P_Data[6] = 0");
        if (TX_OUT_tb == 'd0) 
            begin
                $display(" test 9 passed ");
            end 
        else 
            begin
                $display(" test 9 failed "); 
            end
        #clock_period
        $display(" test 10 P_Data[7] = 0");
        if (TX_OUT_tb == 'd0) 
            begin
                $display(" test 10 passed ");
            end 
        else 
            begin
                $display(" test 10 failed "); 
            end
        Data_Valid_tb = 'd0;
        #clock_period
        $display(" test 11 stop bit of the frame = 1");
        if (TX_OUT_tb == 'd1) 
            begin
                $display(" test 11 passed ");
            end 
        else 
            begin
                $display(" test 11 failed "); 
            end
        #clock_period
        $display(" test 12 vaild data=0 tx_out = 1 idle state");
        if (TX_OUT_tb == 'd1) 
            begin
                $display(" test 12 passed ");
            end 
        else 
            begin
                $display(" test 12 failed "); 
            end
    end
endtask

task even_parity;
    begin
       $display(" test 1 at idle state tx_out = 1");
        if (TX_OUT_tb == 'd1) 
            begin
                $display(" test 1 passed ");
            end 
        else 
            begin
               $display(" test 1 failed "); 
            end
        #clock_period
        parity_enable_tb = 'd1;
        Parity_Type_tb   = 'd0;
        Data_Valid_tb    = 'd1;
        P_Data_tb        = 'b00000101;
        #clock_period
        $display(" test 2 start bit of the frame = 0");
        if (TX_OUT_tb == 'd0) 
            begin
                $display(" test 2 passed ");
            end 
        else 
            begin
                $display(" test 2 failed "); 
            end
        #clock_period
        $display(" data = 00000101");
        $display(" test 3 P_Data[0]= 1");
        if (TX_OUT_tb == 'd1) 
            begin
                $display(" test 3 passed ");
            end 
        else 
            begin
                $display(" test 3 failed "); 
            end
        #clock_period
        $display(" test 4 P_Data[1] = 0");
        if (TX_OUT_tb == 'd0) 
            begin
                $display(" test 4 passed ");
            end 
        else 
            begin
                $display(" test 4 failed "); 
            end
        #clock_period
        $display(" test 5 P_Data[2] = 1");
        if (TX_OUT_tb == 'd1) 
            begin
                $display(" test 5 passed ");
            end 
        else 
            begin
                $display(" test 5 failed "); 
            end
        #clock_period
        $display(" test 6 P_Data[3] = 0");
        if (TX_OUT_tb == 'd0) 
            begin
                $display(" test 6 passed ");
            end 
        else 
            begin
                $display(" test 6 failed "); 
            end
        #clock_period
        $display(" test 7 P_Data[4]= 0");
        if (TX_OUT_tb == 'd0) 
            begin
                $display(" test 7 passed ");
            end 
        else 
            begin
                $display(" test 7 failed "); 
            end
        #clock_period
        $display(" test 8 P_Data[5] = 0");
        if (TX_OUT_tb == 'd0) 
            begin
                $display(" test 8 passed ");
            end 
        else 
            begin
                $display(" test 8 failed "); 
            end
        #clock_period
        $display(" test 9 P_Data[6] = 0");
        if (TX_OUT_tb == 'd0) 
            begin
                $display(" test 9 passed ");
            end 
        else 
            begin
                $display(" test 9 failed "); 
            end
        #clock_period
        $display(" test 10 P_Data[7] = 0");
        if (TX_OUT_tb == 'd0) 
            begin
                $display(" test 10 passed ");
            end 
        else 
            begin
                $display(" test 10 failed "); 
            end
        Data_Valid_tb = 'd0;
        #clock_period
        $display(" test 11 parity bit of data = 0");
        if (TX_OUT_tb == 'd0) 
            begin
                $display(" test 11 passed ");
            end 
        else 
            begin
                $display(" test 11 failed "); 
            end
        #clock_period
        $display(" test 12 stop bit of the frame = 1");
        if (TX_OUT_tb == 'd1) 
            begin
                $display(" test 12 passed ");
            end 
        else 
            begin
                $display(" test 12 failed "); 
            end
        #clock_period
        $display(" test 13 valid data =0  tx_out = 1 idle state");
        if (TX_OUT_tb == 'd1) 
            begin
                $display(" test 13 passed ");
            end 
        else 
            begin
                $display(" test 13 failed "); 
            end 
    end
endtask

task odd_parity;
    begin
       $display(" test 1 at idle state tx_out = 1");
        if (TX_OUT_tb == 'd1) 
            begin
                $display(" test 1 passed ");
            end 
        else 
            begin
               $display(" test 1 failed "); 
            end
        #clock_period
        parity_enable_tb = 'd1       ;
        Parity_Type_tb   = 'd1       ;
        Data_Valid_tb    = 'd1       ;
        P_Data_tb        = 'b11000011;
        #clock_period
        $display(" test 2 start bit of the frame = 0");
        if (TX_OUT_tb == 'd0) 
            begin
                $display(" test 2 passed ");
            end 
        else 
            begin
                $display(" test 2 failed "); 
            end
        #clock_period
        $display(" data = 11000011");
        $display(" test 3 P_Data[0] = 1");
        if (TX_OUT_tb == 'd1) 
            begin
                $display(" test 3 passed ");
            end 
        else 
            begin
                $display(" test 3 failed "); 
            end
        #clock_period
        $display(" test 4 P_Data[1] = 1");
        if (TX_OUT_tb == 'd1) 
            begin
                $display(" test 4 passed ");
            end 
        else 
            begin
                $display(" test 4 failed "); 
            end
        #clock_period
        $display(" test 5 P_Data[2] = 0");
        if (TX_OUT_tb == 'd0) 
            begin
                $display(" test 5 passed ");
            end 
        else 
            begin
                $display(" test 5 failed "); 
            end
        #clock_period
        $display(" test 6 P_Data[3]= 0");
        if (TX_OUT_tb == 'd0) 
            begin
                $display(" test 6 passed ");
            end 
        else 
            begin
                $display(" test 6 failed "); 
            end
        #clock_period
        $display(" test 7 P_Data[4] = 0");
        if (TX_OUT_tb == 'd0) 
            begin
                $display(" test 7 passed ");
            end 
        else 
            begin
                $display(" test 7 failed "); 
            end
        #clock_period
        $display(" test 8 P_Data[5]= 0");
        if (TX_OUT_tb == 'd0) 
            begin
                $display(" test 8 passed ");
            end 
        else 
            begin
                $display(" test 8 failed "); 
            end
        #clock_period
        $display(" test 9 P_Data[6] = 1");
        if (TX_OUT_tb == 'd1) 
            begin
                $display(" test 9 passed ");
            end 
        else 
            begin
                $display(" test 9 failed "); 
            end
        #clock_period
        $display(" test 10 P_Data[7] = 1");
        if (TX_OUT_tb == 'd1) 
            begin
                $display(" test 10 passed ");
            end 
        else 
            begin
                $display(" test 10 failed "); 
            end
        Data_Valid_tb = 'd0;
        #clock_period
        $display(" test 11 parity bit of data = 1");
        if (TX_OUT_tb == 'd1) 
            begin
                $display(" test 11 passed ");
            end 
        else 
            begin
                $display(" test 11 failed "); 
            end
        #clock_period
        $display(" test 12 stop bit of the frame = 1");
        if (TX_OUT_tb == 'd1) 
            begin
                $display(" test 12 passed ");
            end 
        else 
            begin
                $display(" test 12 failed "); 
            end
        #clock_period
        $display(" test 13 valid data =0 tx_out  = 1 idle state");
        if (TX_OUT_tb == 'd1) 
            begin
                $display(" test 13 passed ");
            end 
        else 
            begin
                $display(" test 13 failed "); 
            end 
    end
endtask

task successive_frames;
    begin
        $display(" test 1 at idle state tx_out= 1");
        if (TX_OUT_tb == 'd1) 
            begin
                $display(" test 1 passed ");
            end 
        else 
            begin
               $display(" test 1 failed "); 
            end
        #clock_period
        parity_enable_tb = 'd1       ;
        Parity_Type_tb   = 'd0       ;
        Data_Valid_tb    = 'd1       ;
        P_Data_tb        = 'b00000001;
        #clock_period
        $display(" test 2 start bit of the frame = 0");
        if (TX_OUT_tb == 'd0) 
            begin
                $display(" test 2 passed ");
            end 
        else 
            begin
                $display(" test 2 failed "); 
            end
        #clock_period
        $display(" data = 00000001");
        $display(" test 3 P_Data[0] = 1");
        if (TX_OUT_tb == 'd1) 
            begin
                $display(" test 3 passed ");
            end 
        else 
            begin
                $display(" test 3 failed "); 
            end
        #clock_period
        $display(" test 4 P_Data[1] = 1");
        if (TX_OUT_tb == 'd0) 
            begin
                $display(" test 4 passed ");
            end 
        else 
            begin
                $display(" test 4 failed "); 
            end
        #clock_period
        $display(" test 5 P_Data[2] = 0");
        if (TX_OUT_tb == 'd0) 
            begin
                $display(" test 5 passed ");
            end 
        else 
            begin
                $display(" test 5 failed "); 
            end
        #clock_period
        $display(" test 6 P_Data[3]= 0");
        if (TX_OUT_tb == 'd0) 
            begin
                $display(" test 6 passed ");
            end 
        else 
            begin
                $display(" test 6 failed "); 
            end
        #clock_period
        $display(" test 7 P_Data[4] = 0");
        if (TX_OUT_tb == 'd0) 
            begin
                $display(" test 7 passed ");
            end 
        else 
            begin
                $display(" test 7 failed "); 
            end
        #clock_period
        $display(" test 8 P_Data[5]= 0");
        if (TX_OUT_tb == 'd0) 
            begin
                $display(" test 8 passed ");
            end 
        else 
            begin
                $display(" test 8 failed "); 
            end
        #clock_period
        $display(" test 9 P_Data[6] = 0");
        if (TX_OUT_tb == 'd0) 
            begin
                $display(" test 9 passed ");
            end 
        else 
            begin
                $display(" test 9 failed "); 
            end
        #clock_period
        $display(" test 10 P_Data[7] = 0");
        if (TX_OUT_tb == 'd0) 
            begin
                $display(" test 10 passed ");
            end 
        else 
            begin
                $display(" test 10 failed "); 
            end
        #clock_period
        $display(" test 11 parity bit of data = 1");
        if (TX_OUT_tb == 'd1) 
            begin
                $display(" test 11 passed ");
            end 
        else 
            begin
                $display(" test 11 failed "); 
            end
        #clock_period
        P_Data_tb='b11110000;
        $display(" test 12 stop bit of the frame = 1");
        if (TX_OUT_tb == 'd1) 
            begin
                $display(" test 12 passed ");
            end 
        else 
            begin
                $display(" test 12 failed "); 
            end
        #clock_period
        $display(" test 13 vaild data = 1  strat frame");
        if (TX_OUT_tb == 'd0) 
            begin
                $display(" test 13 passed ");
            end 
        else 
            begin
                $display(" test 13 failed "); 
            end 
        #clock_period
        $display(" test 14  P_Data[0]=0");
        if (TX_OUT_tb == 'd0) 
            begin
                $display(" test 14 passed ");
            end 
        else 
            begin
                $display(" test 14 failed "); 
            end 
        #clock_period
        $display(" test 15  P_Data[1]=0 ");
        if (TX_OUT_tb == 'd0) 
            begin
                $display(" test 15 passed ");
            end 
        else 
            begin
                $display(" test 15 failed "); 
            end 
         #clock_period
        $display(" test 16 P_Data[2]=0");
        if (TX_OUT_tb == 'd0) 
            begin
                $display(" test 16 passed ");
            end 
        else 
            begin
                $display(" test 16 failed "); 
            end 
        #clock_period
        $display(" test 17  P_Data[3]=0");
        if (TX_OUT_tb == 'd0) 
            begin
                $display(" test 17 passed ");
            end 
        else 
            begin
                $display(" test 17 failed "); 
            end
         #clock_period
        $display(" test 18  P_Data[4]=1");
        if (TX_OUT_tb == 'd1) 
            begin
                $display(" test 18 passed ");
            end 
        else 
            begin
                $display(" test 18 failed "); 
            end  

         #clock_period
        $display(" test 19  P_Data[5]=1");
        if (TX_OUT_tb == 'd1) 
            begin
                $display(" test 19 passed ");
            end 
        else 
            begin
                $display(" test 19 failed "); 
            end

         #clock_period
        $display(" test 20  P_Data[6]=1");
        if (TX_OUT_tb == 'd1) 
            begin
                $display(" test 20 passed ");
            end 
        else 
            begin
                $display(" test 20 failed "); 
            end
         #clock_period
        $display(" test 21  P_Data[7]=1");
        if (TX_OUT_tb == 'd1) 
            begin
                $display(" test 21 passed ");
            end 
        else 
            begin
                $display(" test 21 failed "); 
            end
         #clock_period
        $display(" test 22  parity bit=0 ");
        if (TX_OUT_tb == 'd0) 
            begin
                $display(" test 22 passed ");
            end 
        else 
            begin
                $display(" test 22 failed "); 
            end
         #clock_period
        $display(" test 23  stop bit = 1");
        if (TX_OUT_tb == 'd1) 
            begin
                $display(" test 23 passed ");
            end 
        else 
            begin
                $display(" test 23 failed "); 
            end
    end
endtask
////////////////////////////////////////////////////////
////////////////// Clock Generator  ////////////////////
////////////////////////////////////////////////////////
always #(clock_period/2.0)  clk_tb = !clk_tb ;

////////////////////////////////////////////////////////
/////////////////// DUT Instantation ///////////////////
////////////////////////////////////////////////////////

UART_TX DUT (
.parity_enable(parity_enable_tb),
.Parity_Type(Parity_Type_tb),
.clk(clk_tb),
.rst(rst_tb),
.Data_Valid(Data_Valid_tb),
.P_Data(P_Data_tb),
.busy(busy_tb),
.TX_OUT(TX_OUT_tb)
);

endmodule