`timescale 1ns / 1ps

module readMux(
    input [31:0] dataMemReadData,
    input [31:0] instMemReadData,
    input [31:0] btnReadData,

    input selDataMem,
    input selInstMem,
    input selBtn,
    input readEnable,
    
    output reg  [31:0] readData
);
    always @(*) begin
        if (readEnable && selDataMem) readData <= dataMemReadData;
        else if (readEnable && selInstMem) readData <= instMemReadData;
        else if (readEnable && selBtn) readData <= btnReadData;
        else readData <= 32'h0;
    end
endmodule

