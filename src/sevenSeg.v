`timescale 1ns / 1ps

module sevenSeg(
    input clk, rst,              
    input [15:0] count,            
    output reg [6:0] seg,           // 7-segment segments (a-g)
    output reg [3:0] an             // 4-digit anode control
);

    reg [1:0] digitSelect = 0;     // which digit to display (0-3)
    reg [3:0] currentDigit;        
    reg [19:0] refreshCounter = 0; 

    wire [3:0] nibble0 = count[3:0];
    wire [3:0] nibble1 = count[7:4];
    wire [3:0] nibble2 = count[11:8];
    wire [3:0] nibble3 = count[15:12];


    always @(posedge clk) begin
        refreshCounter <= refreshCounter + 1; // resets at max automatically
        digitSelect <= refreshCounter[19:18]; // changes at ~1kHz
    end

    // digit selection
    always @(*) begin
        case (digitSelect)
            2'b00: begin
                an = 4'b1110;
                currentDigit = rst ? 0 : nibble0;
            end
            2'b01: begin
                an = 4'b1101;
                currentDigit = rst ? 0 : nibble1;
            end
            2'b10: begin
                an = 4'b1011;
                currentDigit = rst ? 0 : nibble2;
            end
            2'b11: begin
                an = 4'b0111;
                currentDigit = rst ? 0 : nibble3;
            end
        endcase
    end

    always @(*) begin
        case (currentDigit)
            4'h0: seg = 7'b1000000;
            4'h1: seg = 7'b1111001;
            4'h2: seg = 7'b0100100;
            4'h3: seg = 7'b0110000;
            4'h4: seg = 7'b0011001;
            4'h5: seg = 7'b0010010;
            4'h6: seg = 7'b0000010;
            4'h7: seg = 7'b1111000;
            4'h8: seg = 7'b0000000;
            4'h9: seg = 7'b0010000;
            4'hA: seg = 7'b0001000;
            4'hB: seg = 7'b0000011;
            4'hC: seg = 7'b1000110;
            4'hD: seg = 7'b0100001;
            4'hE: seg = 7'b0000110;
            4'hF: seg = 7'b0001110;
            default: seg = 7'b1111111;
        endcase
    end

endmodule

