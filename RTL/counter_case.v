`timescale 1ns / 1ps

module counter_case(
    input clk,rst_n,
    input enable,
    input up ,
    input two,
    output reg [11:0] val,
    output reg wrapped
    );
    
    reg [11:0] val_next;
    reg wrapped_next;
    
    always @* begin
        case({up,two})
            2'b00: val_next=val-1;
            2'b01: val_next=val-2;
            2'b10: val_next=val+1;
            2'b11: val_next=val+2;
        endcase
        wrapped_next=up?((val==4095 && !two) || (val==4094 && two) || (val==4095 && two))
                  :((val==0 && !two) || (val==1 && two) || (val==0 && two));
    end 
    
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            val<=0;
            wrapped<=0;
        end 
        else 
        wrapped<=0;
        if (enable) begin
            val<=val_next;
            wrapped<=wrapped_next;
        end
    end 
    
endmodule
