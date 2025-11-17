`timescale 1ns / 1ps

module registerFile # (
    parameter OPERAND_LENGTH = 31
    )(
    input [OPERAND_LENGTH:0] writeData,
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input regWrite,
    input clk,
    input rst,
    output reg [OPERAND_LENGTH:0] readData1,
    output reg [OPERAND_LENGTH:0] readData2,
    
    output [15:0] leds
    );
    
reg [OPERAND_LENGTH:0] registers [31:0];

assign leds = registers[9][15:0];

integer i;

initial begin
    for(i = 0; i < OPERAND_LENGTH+1; i=i+1) begin
        registers[i] = {OPERAND_LENGTH+1{1'b0}} + i; 
    end 
end

always@(posedge clk or posedge rst) begin
    if(rst) begin
        for(i = 0; i < 32; i=i+1) begin
            registers[i] = {OPERAND_LENGTH+1{1'b0}} + i; 
        end 
    end
    else if(regWrite) registers[rd] <= writeData;
end

always@(*) begin
    if(rst) begin
        readData1 = {OPERAND_LENGTH+1{1'b0}};
        readData2 = {OPERAND_LENGTH+1{1'b0}};
        
    end else begin
        readData1 = registers[rs1];
        readData2 = registers[rs2];
    end
end
endmodule