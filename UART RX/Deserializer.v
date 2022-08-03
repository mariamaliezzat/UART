module Deserializer (
    input              deserializer_enable,
    input              sampled_bit,
    input       [4:0]  Prescale,
    input       [3:0]  bit_counter,
    input       [4:0]  edge_counter,
    output  reg [7:0]  P_Data
);
localparam [4:0] prescale_32 = 'd32 ;
localparam [4:0] prescale_16 = 'd16 ;
localparam [4:0] prescale_8  = 'd8  ;

reg        [4:0] MAX;
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
always @(*) 
    begin
        if (deserializer_enable) 
            begin
                case (bit_counter)
                    'd1: 
                        begin
                            if (edge_counter==MAX) 
                            begin
                              P_Data = {7'b0000000,sampled_bit} ;  
                            end
                            
                        end
                    'd2: 
                        begin
                          if (edge_counter==MAX) 
                            begin
                              P_Data=P_Data | {6'b000000,sampled_bit,1'b0} ; 
                            end 
                        end
                    'd3: 
                        begin
                          if (edge_counter==MAX) 
                            begin
                              P_Data=P_Data | {5'b00000,sampled_bit,2'b00} ; 
                            end 
                        end
                    'd4: 
                        begin
                            if (edge_counter==MAX) 
                            begin
                              P_Data=P_Data | {4'b0000,sampled_bit,3'b000} ;   
                            end
                        end
                    'd5: 
                        begin
                          if (edge_counter==MAX) 
                            begin
                              P_Data=P_Data | {3'b000,sampled_bit,4'b0000} ;   
                            end
                        end
                    'd6: 
                        begin
                          if (edge_counter==MAX) 
                            begin
                              P_Data=P_Data | {2'b00,sampled_bit,5'b00000} ;   
                            end 
                        end
                    'd7: 
                        begin
                          if (edge_counter==MAX) 
                            begin
                              P_Data=P_Data | {1'b0,sampled_bit,6'b000000} ;  
                            end 
                        end
                    'd8: 
                        begin
                          if (edge_counter==MAX) 
                            begin
                              P_Data=P_Data | {sampled_bit,7'b0000000} ;  
                            end 
                        end
                    default:
                        begin
                            P_Data=P_Data |1'b0;
                        end 
                endcase   
            end 
        else 
            begin
                P_Data = P_Data | 8'd0;
            end
    end
    
endmodule