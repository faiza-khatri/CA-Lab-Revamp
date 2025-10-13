`timescale 1ns / 1ps

module addressDecoder(
    input  wire [31:0] address,
    output wire selDataMem,
    output wire selLed,
    output wire selSwitch
);
    wire [1:0] hi = address[31:30];

    assign selDataMem = (hi == 2'h0); // 0x0xxx_xxxx
    assign selLed = (hi == 2'h1); // 0x2xxx_xxxx
    assign selSwitch = (hi == 2'h2); // 0x3xxx_xxxx
endmodule

