module Parity_Check (
    input parity_check_enable,
    input [4:0] Prescale,
    input sampled_bit,
    input PAR_TYP,
    input [4:0] edge_counter,
    input [3:0] bit_counter,
    input [7:0] P_Data,    
    output reg partiy_error
);
localparam [4:0] prescale_32 = 'd32 ;
localparam [4:0] prescale_16 = 'd16 ;
localparam [4:0] prescale_8  = 'd8  ;
reg        [4:0] MAX                ;
always @(*) 
begin
case (Prescale)
    prescale_32: 
        begin
            MAX = 'd32;
        end 
    prescale_16: 
        begin
            MAX = 'd16;
        end 
    prescale_8: 
        begin
            MAX = 'd8;
        end 
    default: 
        begin
            MAX='d8;
        end
endcase    
end
    reg parity_bit_sampled ;
    reg parity_bit_deser   ;
    always @(*) 
        begin
            if (parity_check_enable == 'd1) 
                begin
                    if (PAR_TYP) 
                        begin
                            parity_bit_deser = ~(^P_Data);
                        end 
                    else 
                        begin
                            parity_bit_deser = (^P_Data);
                        end
                    if (edge_counter == MAX) 
                    begin
                        parity_bit_sampled = sampled_bit;
                        if (parity_bit_deser==parity_bit_sampled) 
                            begin
                                partiy_error = 'd0;
                            end 
                        else 
                            begin
                                partiy_error = 'd1;
                            end
                    end 
                    else 
                    begin
                        parity_bit_sampled = parity_bit_sampled | 1'd0;
                        parity_bit_deser   = parity_bit_deser   | 1'd0;
                        partiy_error       = partiy_error       | 1'd0;
                    end
                   
                end
            else 
                begin
                    parity_bit_sampled = 'd0;
                    parity_bit_deser   = 'd0;
                    partiy_error = 'd0;                    
                end
        end
endmodule