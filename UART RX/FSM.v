module FSM (
    input              clk,
    input              rst,
    input              RX_IN,
    input              PAR_EN,
    input   [4:0]      edge_counter,
    input   [3:0]      bit_counter,
    input              partiy_error,
    input              stop_error,
    input              strat_glitch,
    input   [4:0]      Prescale,

    output   reg       data_sample_enable,
    output   reg       enable,
    output   reg       deserializer_enable,
    output   reg       data_Valid,
    output   reg       stop_check_enable,
    output   reg       start_check_enable,
    output   reg       parity_check_enable
);
localparam [2:0] IDLE_STATE            ='d1 ;
localparam [2:0] SOF_STATE             ='d2 ;
localparam [2:0] DATA_STATE            ='d3 ;
localparam [2:0] PARITY_STATE          ='d4 ;
localparam [2:0] EOF_STATE             ='d5 ;
localparam [2:0] OUT_STATE             ='d6 ;
reg        [2:0] current_state;
reg        [2:0] next_state;

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
always @( posedge clk , negedge rst ) 
    begin
        if (!rst) 
            begin
                current_state <= IDLE_STATE;
            end 
        else 
            begin
                current_state <= next_state;
            end
    end
always @(*) 
    begin
        case (current_state)
            IDLE_STATE:
                begin
                    if (RX_IN) 
                        begin
                           next_state = IDLE_STATE;
                        end 
                    else 
                        begin
                            next_state = SOF_STATE;
                        end
                end
            SOF_STATE:
                begin
                    case (Prescale)
                        prescale_32:
                            begin
                                if (edge_counter == 'd18 && strat_glitch == 'd1) 
                                    begin
                                        next_state = IDLE_STATE;
                                    end 
                                else if (bit_counter == 'd0 && edge_counter == MAX) 
                                    begin
                                        next_state = DATA_STATE;
                                    end 
                                else 
                                    begin
                                        next_state = SOF_STATE;
                                    end 
                                    
                            end 
                        prescale_16:
                            begin
                                if (edge_counter == 'd10 && strat_glitch == 'd1) 
                                    begin
                                        next_state = IDLE_STATE;
                                    end 
                                else if (bit_counter == 'd0 && edge_counter == MAX) 
                                    begin
                                        next_state = DATA_STATE;
                                    end 
                                else 
                                    begin
                                        next_state = SOF_STATE;
                                    end 
                            end 
                        prescale_8:
                            begin
                                if (edge_counter == 'd6 && strat_glitch == 'd1) 
                                    begin
                                        next_state = IDLE_STATE;
                                    end 
                                else if (bit_counter == 'd0 && edge_counter == 'd8) 
                                    begin
                                        next_state = DATA_STATE;
                                    end 
                                else 
                                    begin
                                        next_state = SOF_STATE;
                                    end 
                            end 
                        default:
                            begin
                                next_state = SOF_STATE;
                            end 
                    endcase
                    
                end
            DATA_STATE:
                begin
                    if (bit_counter == 'd8 && edge_counter == MAX) 
                        begin
                            if (PAR_EN) 
                                begin
                                   next_state = PARITY_STATE; 
                                end 
                            else 
                                begin
                                    next_state = EOF_STATE; 
                                end
                        end 
                    else 
                        begin
                            next_state = DATA_STATE;
                        end
                end
            PARITY_STATE:
                begin
                     if (bit_counter == 'd9 && edge_counter == MAX) 
                        begin
                            next_state = EOF_STATE;
                        end 
                    else 
                        begin
                            next_state = PARITY_STATE;
                        end
                end
            EOF_STATE:
                begin
                    if (bit_counter == 'd10 && edge_counter == MAX && PAR_EN == 'd1) 
                        begin
                            if (partiy_error=='d0&&stop_error=='d0) 
                            begin
                               next_state = OUT_STATE; 
                            end 
                            else 
                            begin
                               next_state = IDLE_STATE;  
                            end
                            
                        end 
                    else if (bit_counter == 'd9 && edge_counter == MAX && PAR_EN == 'd0) 
                        begin
                            if (partiy_error=='d0&&stop_error=='d0) 
                            begin
                               next_state = OUT_STATE; 
                            end 
                            else 
                            begin
                               next_state = IDLE_STATE;  
                            end
                        end
                    else
                        begin
                            next_state = EOF_STATE;
                        end
                end 
            OUT_STATE:
                begin
                    next_state = IDLE_STATE;
                end
            default:
                begin
                    next_state = IDLE_STATE;
                end 
        endcase
    end
always @(*) 
    begin
        case (current_state)
            IDLE_STATE:
                begin
                    data_sample_enable ='d0;
                    enable ='d0;
                    deserializer_enable ='d0;
                    data_Valid ='d0;
                    stop_check_enable ='d0;
                    parity_check_enable ='d0;
                end
            SOF_STATE:
                begin
                    data_sample_enable ='d1;
                    enable ='d1;
                    start_check_enable ='d1;
                    deserializer_enable='d0;
                    data_Valid ='d0;
                    stop_check_enable ='d0;
                    parity_check_enable ='d0; 
                end
            DATA_STATE:
                begin
                    data_sample_enable ='d1;
                    enable ='d1;
                    deserializer_enable ='d1;
                    data_Valid ='d0;
                    start_check_enable ='d0;
                    parity_check_enable ='d0;
                    stop_check_enable   ='d0;            
                end
            PARITY_STATE:
                begin
                    data_sample_enable ='d1;
                    enable ='d1;
                    deserializer_enable ='d0;
                    start_check_enable  ='d0;
                    parity_check_enable ='d1;
                    data_Valid='d0;
                    stop_check_enable   ='d0;
                end
            EOF_STATE:
                begin
                    data_sample_enable ='d1;
                    enable = 'd1;
                    deserializer_enable ='d0;
                    stop_check_enable ='d1;
                    start_check_enable ='d0;
                    parity_check_enable ='d0;
                    data_Valid = 'd0;
                end 
            OUT_STATE:
                begin
                    data_sample_enable ='d0;
                    enable ='d0;
                    deserializer_enable ='d0;
                    stop_check_enable ='d0;
                    start_check_enable ='d0;
                    parity_check_enable ='d0;
                    data_Valid ='d1;
                end
            default:
                begin
                    data_sample_enable ='d0;
                    enable ='d0;
                    deserializer_enable ='d0;
                    stop_check_enable ='d0;
                    start_check_enable ='d0;
                    parity_check_enable ='d0;
                    data_Valid ='d0;
                end 
        endcase
    end
endmodule