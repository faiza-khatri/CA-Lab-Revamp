`timescale 1ns / 1ps

module readMux(
    input [31:0] dataMemReadData,
    input [31:0] switchReadData,

    input selDataMem,
    input selSwitch,
    input readEnable,
    
    output reg  [31:0] readData = 0
);
    always @(*) begin
        if (readEnable && selDataMem) readData = dataMemReadData;
        else if (readEnable && selSwitch) readData = switchReadData;
        else readData = 32'h0;
    end
endmodule

