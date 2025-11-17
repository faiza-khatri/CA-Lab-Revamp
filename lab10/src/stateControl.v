`timescale 1ns / 1ps

module stateControl(
    input clk, rst,
    input [31:0] writeData,
    output reg [31:0] address = 0,
    output reg [31:0] readData,
    output reg readEnable = 0, writeEnable = 0,
    output reg writeOut
    );
    
    parameter READ_IN = 2'd0;
    parameter WRITE_MEM = 2'd1;
    parameter READ_MEM = 2'd2;
    parameter WRITE_OUT = 2'd3;   
    reg [1:0] state, nextState;
    
    initial state <= READ_IN;
    
    always @(posedge clk) begin
        if(rst) state <= READ_IN;
        else begin
            state <= nextState;
            readData <= writeData;
        end
    end
    // read from switch -> write to data mem -> read from data mem -> write to led
    always @(*) begin
        readEnable <= 0;
        writeEnable <= 0;
        writeOut <= 0;
        // for this purpose, address offset is always 0 - can be changed
        case(state)
            READ_IN: begin
                address <= 32'h80000000; // switch
                readEnable <= 1;
                nextState <= WRITE_MEM;
            end
            WRITE_MEM: begin
                address <= 32'h00000000; // data mem
                writeEnable <= 1;
                nextState <= READ_MEM;
            end
            READ_MEM: begin
                address <= 32'h00000000; // data mem
                readEnable <= 1;
                nextState <= WRITE_OUT;
            end
            WRITE_OUT: begin
                address <= 32'h40000000; // led
                writeEnable <= 1;
                nextState <= READ_IN;
                writeOut <= 1;
            end
        endcase 
    end
endmodule
