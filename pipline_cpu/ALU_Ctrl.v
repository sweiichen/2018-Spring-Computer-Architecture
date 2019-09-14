//Subject:     CO project 2 - ALU Controller
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0510008 藍挺毓 & 0510026 陳司瑋
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU_Control(
          funct_i,
          ALUOp_i,
          ALUCtrl_o
          //Jump2_o
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [6-1:0] ALUCtrl_o;
//output     Jump2_o;    
 //reg     [4-1:0] ALUC_o;    
//Internal Signals
reg        [4-1:0] ALUCtrl_o;
reg     Jump2_o;
reg     add, sub, And, Or, slt, addi, slti, beq, lw,sw,jr,mult;

always@(*) begin
     add <= (~ALUOp_i[2])&(ALUOp_i[1])&(~ALUOp_i[0])&(funct_i[5])&(~funct_i[4])&(~funct_i[3])&(~funct_i[2])&(~funct_i[1])&(~funct_i[0]);
     sub <= (~ALUOp_i[2])&(ALUOp_i[1])&(~ALUOp_i[0])&(funct_i[5])&(~funct_i[4])&(~funct_i[3])&(~funct_i[2])&(funct_i[1])&(~funct_i[0]);
     And <= (~ALUOp_i[2])&(ALUOp_i[1])&(~ALUOp_i[0])&(funct_i[5])&(~funct_i[4])&(~funct_i[3])&(funct_i[2])&(~funct_i[1])&(~funct_i[0]);
     Or <= (~ALUOp_i[2])&(ALUOp_i[1])&(~ALUOp_i[0])&(funct_i[5])&(~funct_i[4])&(~funct_i[3])&(funct_i[2])&(~funct_i[1])&(funct_i[0]);
     slt <= (~ALUOp_i[2])&(ALUOp_i[1])&(~ALUOp_i[0])&(funct_i[5])&(~funct_i[4])&(funct_i[3])&(~funct_i[2])&(funct_i[1])&(~funct_i[0]);
     addi <= (ALUOp_i[2])&(~ALUOp_i[1])&(~ALUOp_i[0]);
     slti <= (ALUOp_i[2])&(~ALUOp_i[1])&(ALUOp_i[0]);
     beq <= (~ALUOp_i[2])&(~ALUOp_i[1])&(ALUOp_i[0]);
     lw <= (~ALUOp_i[2])&(~ALUOp_i[1])&(~ALUOp_i[0]);
     sw <= (~ALUOp_i[2])&(~ALUOp_i[1])&(~ALUOp_i[0]);
     mult <= (~ALUOp_i[2])&(ALUOp_i[1])&(~ALUOp_i[0])&(~funct_i[5])&(funct_i[4])&(funct_i[3])&(~funct_i[2])&(~funct_i[1])&(~funct_i[0]);
     //jr <= (~ALUOp_i[2])&(ALUOp_i[1])&(~ALUOp_i[0])&(~funct_i[5])&(~funct_i[4])&(funct_i[3])&(~funct_i[2])&(~funct_i[1])&(~funct_i[0]);
    // ALUCtrl_o[3]= 0;
     ALUCtrl_o[3]= mult;
     ALUCtrl_o[2] = sub|slt|slti|beq;
     ALUCtrl_o[1] = add|sub|slt|addi|slti|beq|lw|sw;
     ALUCtrl_o[0] = Or|slt|slti;
    // Jump2_o = jr;
     
end

endmodule     





                    
                    