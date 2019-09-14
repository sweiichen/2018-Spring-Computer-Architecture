//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0510008 藍挺毓 & 0510026 陳司瑋
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Decoder(
    instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
 
//Internal Signals
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg            RegDst_o;
reg            Branch_o;

//Parameter
reg R_format, addi, slti, beq;
always@(*) begin
    R_format <= (~instr_op_i[5]) & (~instr_op_i[4]) & (~instr_op_i[3]) & (~instr_op_i[2]) & (~instr_op_i[1]) & (~instr_op_i[0]);
    addi <= (~instr_op_i[5]) & (~instr_op_i[4]) & (instr_op_i[3]) & (~instr_op_i[2]) & (~instr_op_i[1]) & (~instr_op_i[0]);
    slti <= (~instr_op_i[5]) & (~instr_op_i[4]) & (instr_op_i[3]) & (~instr_op_i[2]) & (instr_op_i[1]) & (~instr_op_i[0]);
    beq <= (~instr_op_i[5]) & (~instr_op_i[4]) & (~instr_op_i[3]) & (instr_op_i[2]) & (~instr_op_i[1]) & (~instr_op_i[0]);
    
    RegWrite_o <= R_format | addi | slti;
    ALUSrc_o <= addi | slti;
    RegDst_o <= R_format;
    Branch_o <= beq;
    ALU_op_o[0] <= beq | slti;
    ALU_op_o[1] <= R_format;
    ALU_op_o[2] <= addi | slti;
end 


//Main function

endmodule





                    
                    