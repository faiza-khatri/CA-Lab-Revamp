`timescale 1ns / 1ps
module dataMemory(
//    input [63:0] memAddress,
//    input [63:0] writeData,
    input clk, rst,
    input writeEnable, readEnable,
    input [63:0] memAddress,
    input [31:0] writeData,
    output reg [31:0] readData
//	output reg [63:0] readData
	);

reg [7:0] dataMemory [63:0];
integer i;
initial begin
    for(i=0; i<64; i=i+1) begin
        dataMemory[i] = 8'd0 + i;
    end
end
always @ (posedge clk) begin
    if (writeEnable)
    begin
        dataMemory[memAddress] = writeData[7:0];
        dataMemory[memAddress+1] = writeData[15:8];
        dataMemory[memAddress+2] = writeData[23:16];
        dataMemory[memAddress+3] = writeData[31:24];
//        dataMemory[memAddress+4] = writeData[39:32];
//        dataMemory[memAddress+5] = writeData[47:40];
//        dataMemory[memAddress+6] = writeData[55:48];
//        dataMemory[memAddress+7] = writeData[63:56]; // made memory 31 bit for consistency
    end
end

always @ (*) begin
	if (readEnable) begin
			readData <= {dataMemory[memAddress+3],
			dataMemory[memAddress+2],
			dataMemory[memAddress+1],
			dataMemory[memAddress]};
	end else begin
	readData <= 64'b0; end
	end
endmodule