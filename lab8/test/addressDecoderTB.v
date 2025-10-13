`timescale 1ns / 1ps

module addressDecoderTB();

    reg clk, rst;
    reg [31:0] address;
    reg [63:0] memAddress;
    reg readEnable, writeEnable;
    reg [31:0] writeData;
    reg [15:0] switches;

    wire [31:0] readData;
    wire [15:0] leds;

    addressDecoderTop DUT (
        .clk(clk),
        .rst(rst),
        .address(address),
        .memAddress(memAddress),
        .readEnable(readEnable),
        .writeEnable(writeEnable),
        .writeData(writeData),
        .switches(switches),
        .readData(readData),
        .leds(leds)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        address = 0;
        memAddress = 0;
        readEnable = 0;
        writeEnable = 0;
        writeData = 0;
        switches = 16'h1234;

   
        #20;
        rst = 0;

    
        address = 32'h40000000;     // 01 led
        writeData = 32'hABCD1234;
        writeEnable = 1;
        #10;
        writeEnable = 0;
        #10;

        address = 32'h80000002;     // 10 - switch
        readEnable = 1;
        #10;
        readEnable = 0;
        #10;

        address = 32'h00000000;     // 00 - data mem
        memAddress = 64'h00000010;
        writeData = 32'hCAFEBABE;
        writeEnable = 1;
        #10;
        writeEnable = 0;

        // Read back
        readEnable = 1;
        #10;
        readEnable = 0;
        #10;

     
        #20;
        $finish;
    end

endmodule
