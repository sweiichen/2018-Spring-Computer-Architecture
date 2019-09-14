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
	Branch_o,
    Branchtype_o,
	//Jump_o,
	MemRead_o,
	MemWrite_o,
	MemtoReg_o   
	);
     
//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
output [3-1:0] Branchtype_o;
//output  Jump_o;
output         MemRead_o;
output         MemWrite_o;
output         MemtoReg_o;   
 
//Internal Signals
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg    [2-1:0] RegDst_o;
reg            Branch_o;
reg    [1:0] Branchtype_o;
//reg     Jump_o;
reg         MemRead_o;
reg         MemWrite_o;
reg [2-1:0] MemtoReg_o; 
reg         bne,bgt,bge;

//Parameter
reg R_format, addi, slti, beq, lw, sw, jump, jal, jr;

always@(*) begin
    R_format <= (~instr_op_i[5]) & (~instr_op_i[4]) & (~instr_op_i[3]) & (~instr_op_i[2]) & (~instr_op_i[1]) & (~instr_op_i[0]);
    addi <= (~instr_op_i[5]) & (~instr_op_i[4]) & (instr_op_i[3]) & (~instr_op_i[2]) & (~instr_op_i[1]) & (~instr_op_i[0]);
    slti <= (~instr_op_i[5]) & (~instr_op_i[4]) & (instr_op_i[3]) & (~instr_op_i[2]) & (instr_op_i[1]) & (~instr_op_i[0]);
    beq <= (~instr_op_i[5]) & (~instr_op_i[4]) & (~instr_op_i[3]) & (instr_op_i[2]) & (~instr_op_i[1]) & (~instr_op_i[0]);
    bne <= (~instr_op_i[5]) & (~instr_op_i[4]) & (~instr_op_i[3]) & (instr_op_i[2]) & (~instr_op_i[1]) & (instr_op_i[0]);
    bge <= (~instr_op_i[5]) & (~instr_op_i[4]) & (~instr_op_i[3]) & (~instr_op_i[2]) & (~instr_op_i[1]) & (instr_op_i[0]);
    bgt <=(~instr_op_i[5]) & (~instr_op_i[4]) & (~instr_op_i[3]) & (instr_op_i[2]) & (instr_op_i[1]) & (instr_op_i[0]);
    lw <= (instr_op_i[5]) & (~instr_op_i[4]) & (~instr_op_i[3]) & (~instr_op_i[2]) & (instr_op_i[1]) & (instr_op_i[0]);
    sw <= (instr_op_i[5]) & (~instr_op_i[4]) & (instr_op_i[3]) & (~instr_op_i[2]) & (instr_op_i[1]) & (instr_op_i[0]);
    //jump <= (~instr_op_i[5]) & (~instr_op_i[4]) & (~instr_op_i[3]) & (~instr_op_i[2]) & (instr_op_i[1]) & (~instr_op_i[0]);
    //jal <= (~instr_op_i[5]) & (~instr_op_i[4]) & (~instr_op_i[3]) & (~instr_op_i[2]) & (instr_op_i[1]) & (instr_op_i[0]);
    //jr <= (~instr_op_i[5]) & (~instr_op_i[4]) & (~instr_op_i[3]) & (~instr_op_i[2]) & (~instr_op_i[1]) & (~instr_op_i[0]);
    
    //RegDst_o[1] <= jal;
    RegDst_o <= R_format;
    ALUSrc_o <= lw|sw|addi|slti;
    //MemtoReg_o[1] <= jal;
    MemtoReg_o <= R_format|addi|slti;
    RegWrite_o <= R_format|lw|addi|slti;
    MemRead_o <= lw;
    MemWrite_o <= sw;
    Branch_o <= beq|bne|bgt|bge;
    Branchtype_o[1] <=bne|bge;
    Branchtype_o[0] <=bgt|bne;
    ALU_op_o[2] <= addi|slti;
    ALU_op_o[1] <= R_format;
    ALU_op_o[0] <= bne|bgt|bge|beq|slti;
    //Jump_o[1] <= jr;
    //Jump_o <= jump|jal; 
    
end 


//Main function

endmodule





                    
                    