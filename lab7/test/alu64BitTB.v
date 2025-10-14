`timescale 1ns / 1ps

module alu64BitTB();

reg [63:0] a, b;
reg [3:0] ALUOp;
wire [63:0] result;
wire zero, carryOut;

alu64Bit alu64BitInst (
    .a(a),
    .b(b),
    .ALUOp(ALUOp),
    .result(result),
    .zero(zero),
    .carryOut(carryOut)
);

initial begin
    a = 64'd10; b = 64'd55; ALUOp = 4'b0010; //add
    #10;
    $display("ADD: %d + %d = %d", a, b, result);

    ALUOp = 4'b0110; //sub
    #10;
    $display("SUB: %d - %d = %d", a, b, result);

    ALUOp = 4'b0000; //and
    #10;
    $display("AND: %h & %h = %h", a, b, result);

    ALUOp = 4'b0001; //or
    #10;
    $display("OR: %h | %h = %h", a, b, result);

    ALUOp = 4'b1100; // nor
    #10;
    $display("NOR: %h NOR %h = %h", a, b, result);

    $finish;
end
endmodule

