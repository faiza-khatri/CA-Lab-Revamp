`timescale 1ns / 1ps

module procTB;

    // DUT input signals
    reg clk;
    reg btnC;
    reg [15:0] switches;

    // DUT output signals
    wire [6:0] seg;
    wire [3:0] an;

    // Instantiate the Device Under Test (DUT)
    topProc dut (
        .clk(clk),
        .btnC(btnC),
        .switches(switches),
        .seg(seg),
        .an(an)
    );

    // --------------------------------------
    // Clock generation: 100 MHz (10 ns period)
    // --------------------------------------
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 5 ns high, 5 ns low
    end

    // --------------------------------------
    // Apply reset pulse (through pushbutton)
    // --------------------------------------
    initial begin
        btnC = 1;         // active (your debouncer outputs rst = 1)
        #50;
        btnC = 0;         // release reset
    end

    // --------------------------------------
    // Switch Stimulus
    // --------------------------------------
    initial begin
        // Start with all switches LOW
        switches = 16'h0000;

        // Wait for processor to start running
        #100;

        // Set a value on switches (example: 13 = 0x000D)
        switches[3:0] = 4'b1101;   // binary input = 13

        // Set MSB switch as "start operation"
        // e.g., switch[15] = 1 means "finish input and start counter"
        switches[15] = 1;

        #500;

        // Change value during simulation (optional)
        switches[3:0] = 4'b0111;   // binary 7
        #300;

        // Turn off start switch
        switches[15] = 0;

        #5000;
        $finish;
    end

    // --------------------------------------
    // Waveform dump for GTKWave / Vivado
    // --------------------------------------
    initial begin
        $dumpfile("topProc.vcd");
        $dumpvars(0, procTB);
    end

endmodule
