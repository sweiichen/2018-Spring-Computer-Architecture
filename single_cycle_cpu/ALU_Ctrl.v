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

module ALU_Ctrl(
          funct_i,
          ALUOp_i,
          ALUCtrl_o
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
 //reg     [4-1:0] ALUC_o;    
//Internal Signals
reg        [4-1:0] ALUCtrl_o;
/*wire        temp1, temp2;
wire        nf2,nop1;*/
//Parameter
/*
 or f3orf0(temp1,funct_i[3],funct_i[0]);
 and op1andtemp1(ALUC_o[0],temp1,ALUOp_i[1]);
 not notf2(nf2,funct_i[2]);
 not notop1(nop1,ALUOp_i[1]);
 or         (ALUC_o[1],nop1,nf2);
 and        (temp2,funct_i[1],ALUOp_i[1]);
 or          (ALUC_o[2],ALUOp_i[0],temp2);
 
 always@(*) begin 
 ALUCtrl_o =ALUC_o;
 end
//Select exact operation
*/
//reg operation3,operation2, operation1,operation0;
always@(*) begin
     ALUCtrl_o[3]= 0;
     ALUCtrl_o[2] = ALUOp_i[0] || (funct_i[1] && ALUOp_i[1]);
     ALUCtrl_o[1] = ALUOp_i[2] || ALUOp_i[0] || (ALUOp_i[1] && ~funct_i[2]);
     ALUCtrl_o[0] = (ALUOp_i[2]&& ALUOp_i[0]) || ((funct_i[0] || funct_i[3]) && ALUOp_i[1] );
end

endmodule     





                    
                    