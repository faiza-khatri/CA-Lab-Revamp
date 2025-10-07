`timescale 1ns / 1ps

module addressDecoder(
    input  wire [31:0] addr,
    output wire selDataMem,
    output wire selInstMem,
    output wire selLed,
    output wire selBtn
);
    wire [3:0] hi = addr[31:28];

    assign selDataMem = (hi == 4'h0); // 0x0xxx_xxxx
    assign selInstMem = (hi == 4'h1); // 0x1xxx_xxxx
    assign selLed = (hi == 4'h2); // 0x2xxx_xxxx
    assign selBtn = (hi == 4'h3); // 0x3xxx_xxxx
endmodule

