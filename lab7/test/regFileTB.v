`timescale 1ns / 1ps

module regFileTB();
reg [63:0] writeData;
reg [4:0] rs1;
reg [4:0] rs2;
reg [4:0] rd;
reg regWrite;
reg clk;
reg rst;

wire [63:0] readData1;
wire [63:0] readData2;


registerFile regFileInst (
    .writeData(writeData),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .regWrite(regWrite),
    .clk(clk),
    .rst(rst),
    .readData1(readData1),
    .readData2(readData2)
);


initial begin
    clk = 0;
   
end
always begin
     #5 clk = ~clk; 
end

initial begin
    rst = 1;
    regWrite = 0;
    writeData = 0;
    rs1 = 0;
    rs2 = 0;
    rd = 0;

    #15;
    rst = 0;

    rs1 = 5'd1; 
    rs2 = 5'd2; 
    #10;

    rd = 5'd3;
    writeData = 64'd100;
    regWrite = 1;
    #10;

    regWrite = 0; 
    rs1 = 5'd3;   
    rs2 = 5'd1;   
    #10;

    rd = 5'd3;
    writeData = 64'd200;
    regWrite = 1;
    #10;

    regWrite = 0;
    #10;

    rst = 1;
    #10;
    rst = 0;

    rs1 = 5'd3;
    rs2 = 5'd2;
    #10;

    $finish;
end

endmodule
