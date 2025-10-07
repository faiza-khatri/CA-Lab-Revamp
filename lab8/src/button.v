`timescale 1ns / 1ps

module button(
    input clk, rst,
    input [4:0] btns,
    input [31:0] writeData, //  not to be written
    input writeEnable, // not to be used
    input readEnable,
    input [63:0] memAddress,
    
    output reg  [31:0] readData,
    output reg irq // interrupt signal      
    );
    

// two-stage synchronizers for each button
reg [4:0] sync1, sync2;
reg [4:0] prev;

reg [4:0] stable;
reg [15:0] count [4:0]; // small counters per button
integer i;
initial begin
    for (i = 0; i < 5; i = i + 1) begin
        count[i]  <= 16'd0;
        stable[i] <= 1'b0;
    end
     prev <= 5'd0;
     irq  <= 1'b0;
end


always @(posedge clk) begin
    if (rst) begin
        for (i = 0; i < 5; i = i + 1) begin
            count[i]  <= 16'd0;
            stable[i] <= 1'b0;
        end
        prev <= 5'd0;
        irq  <= 1'b0;
        readData <= 0;
    end else begin
        for (i = 0; i < 5; i = i + 1) begin
            if (sync2[i] != stable[i]) begin
                // signal changed, increment counter
                count[i] <= count[i] + 1'b1;
                // if stable for long enough, accept change
                if (count[i] == 17'd100000) begin // for clock speed (~1 ms)
                    stable[i] <= sync2[i];
                    count[i]  <= 16'd0;
                end
            end else begin
                // no change, reset counter
                count[i] <= 16'd0;
            end
        end

        readData <= {27'd0, stable};

        // edge detection on debounced signal
        if ((stable & ~prev) != 5'd0) // if any of the 5 bits just changed
            irq <= 1'b1;
        else
            irq <= 1'b0;

        prev <= stable;
    end
end
endmodule
