//`timescale 1ns / 1ps

//module immGen#(
//    parameter OPERAND_LENGTH = 63
//    )(
//input [31:0] instruction,
//output reg [OPERAND_LENGTH:0] imm
//);

//wire [1:0] opcode;
//assign opcode[0] = instruction[5];
//assign opcode[1] = instruction[6];

//reg [11:0] immLd;
//reg [11:0] immSd;
//reg [11:0] immRd;
//reg [11:0] immU;

//always@(instruction) begin
//    case(opcode)
//        2'b11: begin
//            immRd = {instruction[31], instruction[7], instruction[30:25], instruction[11:8]};
//			imm = {{OPERAND_LENGTH-11{instruction[31]}}, immRd};
//		end
//        2'b01: begin
//            immSd = {instruction[31:25], instruction[11:7]};
//			imm = {{OPERAND_LENGTH-11{instruction[31]}}, immSd};
//		end  
//		2'b00: begin
//            immLd = {instruction[31:20]};
//			imm = {{OPERAND_LENGTH-12{instruction[31]}}, immLd};
//		end
		
            
//		default: imm = {OPERAND_LENGTH+1{1'b0}};

//    endcase
//end
    
//endmodule

`timescale 1ns / 1ps

module immGen #(
    parameter OPERAND_LENGTH = 63
)(
    input  [31:0] instruction,
    output reg [OPERAND_LENGTH:0] imm
);
reg [11:0] immS;
reg [12:0] immB;
wire [6:0] opcode = instruction[6:0];

always @(*) begin
    case (opcode)
        // I-type: addi, lw, etc.
        7'b0000011, // lw
        7'b0010011: // addi
            imm = {{(OPERAND_LENGTH-11){instruction[31]}}, instruction[31:20]};
        // S-type: sw
        7'b0100011: begin
            // imm = {imm[11:5], imm[4:0]}
            immS = {instruction[31:25], instruction[11:7]};
            imm = {{(OPERAND_LENGTH-11){instruction[31]}}, immS};
        end

        // B-type: beq
        7'b1100011: begin
            immB = {
                instruction[31],       // imm[12]
                instruction[7],        // imm[11]
                instruction[30:25],    // imm[10:5]
                instruction[11:8],     // imm[4:1]
                1'b0                   // imm[0]
            };
            imm = {{(OPERAND_LENGTH-12){immB[12]}}, immB};
        end

        // U-type: LUI, AUIPC
        7'b0110111, // LUI
        7'b0010111: // AUIPC
            imm = {instruction[31:12], 12'b0};

        default:
            imm = 0;
    endcase
end

endmodule
