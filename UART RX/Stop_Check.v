module Stop_Check (
    input      stop_check_enable,
    input      sampled_bit,
    output reg stop_error
);
    always @(*) 
        begin
            if (stop_check_enable) 
                begin
                    if (sampled_bit == 'd1) 
                        begin
                            stop_error = 'd0;
                        end 
                    else 
                        begin
                            stop_error = 'd1;
                        end
                end 
            else 
                begin
                    stop_error = 'd0;
                end
        end
endmodule