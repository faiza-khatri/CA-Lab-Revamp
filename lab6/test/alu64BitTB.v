`timescale 1ns / 1ps

module alu64BitTB();
reg clk, rst;
reg [31:0] a, b;
reg [3:0] funct;
reg [1:0] ALUOp;


wire zero, lessThan;
wire [31:0] result;
wire [3:0] operation;

top uut (
    .clk(clk),
    .rst(rst),
    .a(a),
    .b(b),
    .ALUControl(operation),
    .result(result),
    .funct(funct),
    .ALUOp(ALUOp),
    .zero(zero),
    .lessThan(lessThan)
);

always #5 clk = ~clk;  // 100MHz clock

initial begin
    clk = 0;
    rst = 1;
    a = 0;
    b = 0;
    funct = 4'b0000;
    ALUOp = 2'b00;
    
    #10 rst = 0;

    a = 32'd15;
    b = 32'd10;
    ALUOp = 2'b10;  // rtype
    funct = 4'b0000; // add
    #20;
    $display("ADD: %d + %d = %d, zero=%b", a, b, uut.result, zero);

    a = 32'd20;
    b = 32'd5;
    funct = 4'b1000; // sub
    #20;
    $display("SUB: %d - %d = %d, zero=%b", a, b, uut.result, zero);

    a = 32'hF0F0;
    b = 32'h0FF0;
    funct = 4'b0111; // and
    #20;
    $display("AND: %h & %h = %h", a, b, uut.result);

    a = 32'hF0F0;
    b = 32'h0FF0;
    funct = 4'b0110; // or
    #20;
    $display("OR: %h | %h = %h", a, b, uut.result);

    a = 32'h0001;
    b = 32'd4;
    funct = 4'b0001; // slli
    #20;
    $display("SLLI: %h << %d = %h", a, b, uut.result);

    a = 32'd50;
    b = 32'd50;
    ALUOp = 2'b01;   // branch
    funct = 4'b0000;
    #20;
    $display("BEQ: %d - %d, zero=%b (should branch)", a, b, zero);

    a = 32'd25;
    b = 32'd50;
    ALUOp = 2'b01;   // branch
    #20;
    $display("BEQ: %d - %d, zero=%b (should NOT branch)", a, b, zero);

    #50;
    $finish;
end

endmodule
