module FSM (
    input                 parity_enable,
    input                 Data_Valid,
    input                 serial_done,
    input                 rst,
    input                 clk,
    output   reg          busy, 
    output   reg          serial_enable, 
    output   reg [1:0]    mux_sel
); 
localparam [3:0]  IDLE_STATE                  = 'd0;
localparam [3:0]  SOF_STATE                   = 'd1;
localparam [3:0]  TRANSMITTING_STATE          = 'd3; 
localparam [3:0]  EOF_NOPARITY_STATE          = 'd2; 
localparam [3:0]  EOF_WITHPARITY_STATE        = 'd5; 
reg        [3:0] current_state;
reg        [3:0] next_state;

always @(posedge clk ) begin
    if (!rst) begin
        current_state <= IDLE_STATE;
    end else begin
        current_state <= next_state;
    end
end  
always @(*) 
    begin
        case (current_state)
            IDLE_STATE:
                begin
                    if (Data_Valid) 
                        begin
                        next_state = SOF_STATE; 
                        end 
                    else
                        begin
                        next_state = IDLE_STATE;
                        end
                end 
            SOF_STATE:
                begin
                    next_state = TRANSMITTING_STATE;
                end
            TRANSMITTING_STATE :
            begin
                if (serial_done) 
                    begin
                        if (parity_enable) 
                            begin
                                next_state = EOF_WITHPARITY_STATE;
                            end 
                        else 
                            begin
                                next_state = EOF_NOPARITY_STATE;
                            end
                    end 
                else 
                    begin
                        next_state = TRANSMITTING_STATE;
                    end
            end 
            EOF_WITHPARITY_STATE :
                begin
                    begin
                        next_state = EOF_NOPARITY_STATE;
                    end 
                end
                EOF_NOPARITY_STATE :
                begin
                    begin
                        if (Data_Valid == 'd1) 
                            begin
                               next_state = SOF_STATE; 
                            end 
                        else 
                            begin
                                next_state = IDLE_STATE;
                            end
                        
                    end 
                end
            default: next_state = IDLE_STATE;
        endcase
    end
    always @(*) 
        begin
            case (current_state)
                IDLE_STATE:
                    begin
                        busy          = 'd0;
                        serial_enable = 'd0;
                        mux_sel       = 2'bxx;

                    end 
                    SOF_STATE :
                    begin
                        busy          = 'd1;
                        serial_enable = 'd1;
                        mux_sel       = 'd0;
                    end
                TRANSMITTING_STATE :
                    begin
                        busy          = 'd1;
                        serial_enable = 'd1;
                        mux_sel       = 'd2;
                    end 
                EOF_WITHPARITY_STATE :
                    begin
                        busy          = 'd1;
                        serial_enable = 'd0;
                        mux_sel       = 'd3;
                    end 
                EOF_NOPARITY_STATE :
                    begin
                        busy          = 'd1;
                        serial_enable = 'd0;
                        mux_sel       = 'd1;
                    end    
                default: 
                    begin
                        busy          = 'd0;
                        serial_enable = 'd0;
                        mux_sel       = 2'bxx;
                    end
            endcase
        end
    
endmodule