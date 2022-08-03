module parity_calc (
    input                   Data_Valid ,
    input                   Parity_Type,
    input   [7:0]           P_Data,
    output         reg      parity_bit

);
always @(*) begin
    if (Data_Valid) 
    begin
        if (Parity_Type) 
        begin
            //odd parity
            parity_bit = ~(^P_Data);
        end 
        else 
        begin
            //even parity
            parity_bit = (^P_Data);
        end
    end
    else 
    begin
        parity_bit = parity_bit;
    end
    
end 
    
endmodule