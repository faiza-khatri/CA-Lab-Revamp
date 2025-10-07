`timescale 1ns / 1ps

module writeDeMux(
    input writeEnable,

    input selDataMem,
    input selInstMem,
    input selLed,
    
    output reg dataMemWriteEnable,
    output reg instMemWriteEnable,
    output reg ledWriteEnable
    );
    
    always @(*) begin
        if (selDataMem) begin
            dataMemWriteEnable <= writeEnable;
            instMemWriteEnable <= 0;
            ledWriteEnable <= 0;
        end
        else if (selInstMem) begin
            dataMemWriteEnable <= 0;
            instMemWriteEnable <= writeEnable;
            ledWriteEnable <= 0;
        end
        if (selLed) begin
            dataMemWriteEnable <= 0;
            instMemWriteEnable <= 0;
            ledWriteEnable <= writeEnable;
        end

    end
    
endmodule
