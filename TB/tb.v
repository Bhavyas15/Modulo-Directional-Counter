`timescale 1ns / 1ps

module tb(
    );
        
    reg clk,rst_n;
    reg enable;
    reg up;
    reg two;
    wire [11:0] val;
    wire wrapped;
    
//    counter dut(
//        clk,rst_n,
//        enable,
//        up,
//        two,
//        val,
//        wrapped
//    );

    counter_case dut(
        clk,rst_n,
        enable,
        up,
        two,
        val,
        wrapped
    );
    
    always #5 clk=~clk;
    
    initial begin
        clk=0;
        rst_n=0;
        enable=0;
        up=0;
        two=1;
        
        #50;
        rst_n=1;
        #20;
        enable=1;
        #50;
        up=1;
        two=0;
        #30;
        two=1;
        #30
        two=0;
        #100;
        $finish;
    end
    
endmodule
