module serializer (
    input  [7:0]     P_Data,
    input            serial_enable,
    input            clk,
    input            rst,
    output   reg     serial_done,
    output   reg     serial_data
);
reg [7:0] counter;

always @(posedge clk )
    begin
        
        if (serial_enable) 
            begin
                if (counter < 'd8) 
                    begin
                       if (counter == 'd7) begin
                        serial_done <='d1;
                       end else begin
                        serial_done <='d0;
                       end
                       counter     <= counter +'d1;
                       serial_data <= P_Data[counter]; 
                       
                    end 
                else 
                    begin
                       counter     <= 'd0;
                       serial_done <= 'd1; 
                    end
            end 
        else 
            begin
                serial_done <= 'd0;
                counter     <= 'd0;
            end
    end        
endmodule