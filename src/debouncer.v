`timescale 1ns / 1ps

module debouncer(
    input clk,
    input pbin,
    output pbout
    );
    
wire slowClk;
wire Q1,Q2,Q2_bar,Q0;

clockDiv u1(clk,slowClk);

// value of pbin propagates through the circuit and takes three slow clock cycles to stabilize
myDff d0(slowClk, pbin,Q0 );
myDff d1(slowClk, Q0,Q1 );
myDff d2(slowClk, Q1,Q2 );

assign Q2_bar = ~Q2;
assign pbout = Q1 & Q2_bar; // button was low and just became high, stable button press

endmodule

// Slow clock for debouncing 
module clockDiv(
    input Clk_100M, 
    output reg slowClk
);
    reg [26:0] counter=0;
    always @(posedge Clk_100M)
    begin
        counter <= (counter>=249999)?0:counter+1;
        slowClk <= (counter < 125000)?1'b0:1'b1;
    end
endmodule

// D-flip-flop for debouncing module 
module myDff(input DFFCLOCK, D, output reg Q);
    always @ (posedge DFFCLOCK) begin
        Q <= D;
    end

endmodule