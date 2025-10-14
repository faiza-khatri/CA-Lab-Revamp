`timescale 1ns / 1ps
module topButton (
    input clk, btnC,
    output reg led
);
    initial led = 0;
    wire buttonPressed; 
    debouncer btnDebouncer(
        .clk(clk),
        .pbin(btnC),
        .pbout(buttonPressed)
        );
    always @(posedge clk) begin
        if(buttonPressed) led <= ~led;
    end
endmodule
