`timescale 1ns / 1ps

module topTest();

reg clk;
reg btnC; 
wire [7:0] leds;


top uut (
    .clk(clk),
    .btnC(btnC),
    .led(leds)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end


initial begin
    btnC = 1;
    #20;
    btnC = 0;

    #500;

    btnC = 1;
    #20;
    btnC = 0;

    #500;
 
end

endmodule
