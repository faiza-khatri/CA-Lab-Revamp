`timescale 1ns / 1ps

module switches(
    input clk, rst,
    input [15:0] btns,
    input [31:0] writeData, //  not to be written
    input writeEnable, // not to be used
    input readEnable,
    input [29:0] memAddress,
    input [15:0] switches,
    
    output reg  [31:0] readData
    );
    
    reg [7:0] switchData [3:0]; 
    
    integer i;
    initial begin
        for(i=0; i<4; i=i+1) begin
            switchData[i] = 8'd0;
        end
    end
    
    always @(*) begin
        switchData[0] = switches[7:0];
        switchData[1] = switches[15:8];
    end
    
    always @(*) begin
        if(readEnable) readData <= {switchData[memAddress+3],
			switchData[memAddress+2],
			switchData[memAddress+1],
			switchData[memAddress]};
    end
endmodule

        

    