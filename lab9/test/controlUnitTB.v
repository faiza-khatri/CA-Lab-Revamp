`timescale 1ns / 1ps

module controlUnitTB();

reg [6:0] opcode;

wire [1:0] ALUOp;
wire branch;
wire memRead;
wire memtoReg;
wire memWrite;
wire ALUSrc;
wire regWrite;

controlUnit uut (
    .opcode(opcode),
    .ALUOp(ALUOp),
    .branch(branch),
    .memRead(memRead),
    .memtoReg(memtoReg),
    .memWrite(memWrite),
    .ALUSrc(ALUSrc),
    .regWrite(regWrite)
);

initial begin
    // display header
    $display("time\topcode\t\tALUOp\tbranch\tmemRead\tmemtoReg\tmemWrite\tALUSrc\tregWrite");
    $monitor("%0dns\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b", 
        $time, opcode, ALUOp, branch, memRead, memtoReg, memWrite, ALUSrc, regWrite);
    
    // test r-type
    opcode = 7'b0110011; #10;
    
    // test i-type load
    opcode = 7'b0000011; #10;
    
    // test i-type addi
    opcode = 7'b0010011; #10;
    
    // test s-type store
    opcode = 7'b0100011; #10;
    
    // test branch
    opcode = 7'b1100011; #10;
    
    // test default
    opcode = 7'b1111111; #10;
    
    $finish;
end

endmodule
