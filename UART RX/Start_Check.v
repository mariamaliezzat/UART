module Start_Check (
    input               start_check_enable,
    input               sampled_bit,
    output    reg       strat_glitch
);
    always @(*) 
        begin
            if (start_check_enable ) 
                begin
                    if (sampled_bit == 'd0) 
                        begin
                            strat_glitch = 'd0;
                        end 
                    else 
                        begin
                            strat_glitch = 'd1;
                        end    
                end 
            else 
                begin
                    strat_glitch ='d0;
                end
        end
endmodule