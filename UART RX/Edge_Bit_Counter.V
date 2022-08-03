module Edge_Bit_Counter (
    input                        enable,
    input                        clk,
    input                        rst,
    input           [4:0]        Prescale,
    output   reg    [4:0]        edge_counter,
    output   reg    [3:0]        bit_counter
);
    localparam [4:0] prescale_32 = 'd32 ;
    localparam [4:0] prescale_16 = 'd16 ;
    localparam [4:0] prescale_8  = 'd8  ;
    always @(posedge clk ,negedge rst) 
        begin
            if (!rst) 
                begin
                    bit_counter  <='d0;
                    edge_counter <='d0;
                end 
            else 
                begin
                    if (enable) 
                        begin        
                            case (Prescale)
                                prescale_32:
                                    begin
                                        if (edge_counter == 'd32) 
                                            begin
                                                edge_counter <= 'd0;
                                                bit_counter  <= bit_counter + 'd1; 
                                            end 
                                        else 
                                            begin
                                                edge_counter <= edge_counter + 'd1;
                                                bit_counter  <= bit_counter;
                                            end
                                    end 
                                prescale_16:
                                    begin
                                        if (edge_counter == 'd16) 
                                            begin
                                                edge_counter <= 'd0;
                                                bit_counter  <= bit_counter + 'd1; 
                                            end 
                                        else 
                                            begin
                                                edge_counter <= edge_counter + 'd1;
                                                bit_counter  <= bit_counter;
                                            end
                                    end
                                prescale_8:
                                    begin
                                        if (edge_counter == 'd8) 
                                            begin
                                                edge_counter <= 'd0;
                                                bit_counter  <= bit_counter + 'd1; 
                                            end 
                                        else 
                                            begin
                                                edge_counter <= edge_counter + 'd1;
                                                bit_counter  <= bit_counter;
                                            end
                                    end  
                                default:
                                    begin
                                        edge_counter <= 'd0;
                                        bit_counter  <= 'd0;
                                    end 
                            endcase
                        end 
                    else 
                        begin
                            bit_counter  <= 'd0;
                            edge_counter <= 'd0;
                        end
                end
        end
endmodule