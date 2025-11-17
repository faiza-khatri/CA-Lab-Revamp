`timescale 1ns / 1ps

module clockDivider(
    input clk100MHz,
    input rst,
    output reg clkSlow
);
    reg [19:0] counter; // 20 bits enough for 1,000,00

    always @(posedge clk100MHz) begin
        if (rst) begin
            counter <= 0;
            clkSlow <= 0;
        end else begin
            if (counter == 999_99) begin  // toggle every 1,000,000 cycles
                clkSlow <= ~clkSlow;
                counter <= 0;
            end else begin
                counter <= counter + 1;
            end
        end
    end
endmodule
