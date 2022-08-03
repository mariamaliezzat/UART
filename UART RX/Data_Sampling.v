module Data_Sampling (
    input              data_sample_enable,
    input  [4:0]       edge_counter,
    input              RX_IN,
    input              clk,
    input              rst,
    input  [4:0]       Prescale,
    output  reg        sampled_bit                       
);
localparam [4:0] prescale_32 = 'd32 ;
localparam [4:0] prescale_16 = 'd16 ;
localparam [4:0] prescale_8  = 'd8  ;
reg                        sample1  ;  
reg                        sample2  ;  
reg                        sample3  ;
wire [2:0]              all_samples ;
assign all_samples = {sample1,sample2,sample3};
always @(posedge clk,negedge rst)
    begin
        if (!rst) 
            begin
                sampled_bit <= 'd1;
            end 
        else 
            begin
                case (all_samples)
                    'b000:
                        begin
                            sampled_bit <= 'd0;         
                        end
                    'b001:
                        begin
                            sampled_bit <= 'd0;
                        end
                    'b010:
                        begin
                            sampled_bit <= 'd0;
                        end
                    'b011:
                        begin
                            sampled_bit <= 'd1;
                        end
                    'b100:
                        begin
                            sampled_bit <= 'd1; 
                        end
                    'b101:
                        begin
                            sampled_bit <= 'd1;
                        end
                    'b110:
                        begin
                            sampled_bit <= 'd1;
                        end
                    'b111:
                        begin
                            sampled_bit <= 'd1;
                        end    
                    default:
                        begin
                            sampled_bit <= 'd1;
                        end 
                endcase
            end          
    end
always @(posedge clk, negedge rst) 
    begin
        if (!rst) 
            begin
                sample1 <='d1;
                sample2 <='d1;
                sample3 <='d1;
            end 
        else 
            begin
                if (data_sample_enable) 
                    begin
                        case (Prescale)
                            prescale_32:
                                begin
                                    case (edge_counter)
                                        'd15:
                                            begin
                                                sample1 <= RX_IN;
                                            end 
                                        'd16:
                                            begin
                                                sample2 <= RX_IN;
                                            end 
                                        'd17:
                                            begin
                                                sample3 <= RX_IN;
                                            end 
                                        default: 
                                            begin
                                                sample1 <=sample1;
                                                sample2 <=sample2;
                                                sample3 <=sample3;
                                            end 
                                    endcase
                                end
                            prescale_16:
                                begin
                                    case (edge_counter)
                                        'd7:
                                            begin
                                                sample1 <= RX_IN;
                                            end 
                                        'd8:
                                            begin
                                                sample2 <= RX_IN;
                                            end 
                                        'd9:
                                            begin
                                                sample3 <= RX_IN;
                                            end 
                                        default: 
                                            begin
                                                sample1 <=sample1;
                                                sample2 <=sample2;
                                                sample3 <=sample3;
                                            end 
                                    endcase
                                end 
                            prescale_8 :
                                begin
                                    case (edge_counter)
                                        'd3:
                                            begin
                                                sample1 <= RX_IN;                                            end 
                                        'd4:
                                            begin
                                                sample2 <= RX_IN;
                                            end 
                                        'd5:
                                            begin
                                                sample3 <= RX_IN;
                                            end 
                                        default: 
                                            begin
                                                sample1 <=sample1;
                                                sample2 <=sample2;
                                                sample3 <=sample3;
                                            end 
                                    endcase        
                                end  
                            default:
                                begin
                                    sample1 <='d1;
                                    sample2 <='d1;
                                    sample3 <='d1;
                                end 
                        endcase 
                    end 
                else 
                    begin
                        sample1 <='d1;
                        sample2 <='d1;
                        sample3 <='d1;
                    end
                
            end
        
    end
    
endmodule