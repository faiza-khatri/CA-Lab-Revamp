`timescale 1ns / 1ps

module writeDeMux(
    input writeEnable,

    input selDataMem,
    input selLed,
    
    output reg dataMemWriteEnable,
    output reg ledWriteEnable
    );
    
    always @(*) begin
        if (selDataMem) begin
            dataMemWriteEnable <= writeEnable;
            ledWriteEnable <= 0;
        end

        else if (selLed) begin
            dataMemWriteEnable <= 0;
            ledWriteEnable <= writeEnable;
        end
        else begin
            dataMemWriteEnable <= 0;
            ledWriteEnable <= 0;
        end
    end
    
endmodule
