`timescale 1ns / 1ps

module counter(
    input clk,rst_n,
    input enable,
    input up ,
    input two,
    output reg [11:0] val,
    output reg wrapped
    );

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        val<=0;
        wrapped<=0;
    end
    else begin
        wrapped<=0;
        if(up) begin
            if((val==4095 && !two) || (val==4094 && two))begin
                val<=0;
                wrapped<=1;
            end
            if(val==4095 && two) begin
                val<=1;
                wrapped<=1;
            end
            if(two) val<=val+2;
            else val<=val+1;
        end
        else begin
            if((val==0 && !two) || (val==1 && two))begin
                val<=4095;
                wrapped<=1;
            end
            if(val==0 && two) begin
                val<=4094;
                wrapped<=1;
            end
            if(two) val<=val-2;
            else val<=val-1;
        end
    end
end

endmodule

