`timescale 1ns / 1ps
//Subject:     CO project 4 - Pipe CPU 1
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:     0510008 藍挺毓 & 0510026 陳司瑋
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Pipe_CPU_1(
    clk_i,
    rst_i
    );
    
/****************************************
I/O ports
****************************************/
input clk_i;
input rst_i;
wire [31:0] adder1_o,instr_mem,Mux0_o,Mux3_o,Mux1_o,Mux7_o,Mux8_o;
wire [63:0] IF_ID_o;
wire Regwrite,MemtoReg,branch,Memread,Memwrite,RegDst,ALUSrc,zero;
wire [2:0]ALUOp;
wire[31:0] read_data1_o,read_data2_o,extend;
wire[155-1:0]ID_EX_o;
wire[31:0]result1_o,result2_o;
wire[4:0]Mux2_o;
wire[106:0]EX_MEM_o;
wire [31:0]Datamem_o;
wire [70:0]MEM_WB_o;
wire [31:0]pc_out_o,pc_in_i,shift_o;
wire [3:0]ALU_ctrl;
wire [1:0]forwardA,forwardB;
wire [11:0]Mux4_o;
wire [1:0]Mux5_o;
wire [2:0]Mux6_o;
wire id_flush,ex_flush,if_flush,pc_write,if_idwrite;
wire Mux9_o;
wire [1:0]branchtype_o;





/****************************************
Internal signal
****************************************/
/**** IF stage ****/

/**** ID stage ****/

//control signal


/**** EX stage ****/

//control signal


/**** MEM stage ****/

//control signal


/**** WB stage ****/

//control signal


/****************************************
Instantiate modules
****************************************/
//Instantiate the components in IF stage

forwarding_unit FW(
    .ex_mem_RegWrite(EX_MEM_o[106]),
    .ex_mem_RegRd(EX_MEM_o[4:0]),
    .id_ex_RegRs(ID_EX_o[152:148]),
    .id_ex_RegRt(ID_EX_o[9:5]),
    .mem_wb_RegWrite(MEM_WB_o[70]),
    .mem_wb_RegRd(MEM_WB_o[4:0]),
    .ForwardA(forwardA),
    .ForwardB(forwardB)
);


MUX_2to1 #(.size(32)) Mux0(
               .data0_i(adder1_o),
               .data1_i(EX_MEM_o[101:70]),
               .select_i(EX_MEM_o[104]&EX_MEM_o[69]),
               .data_o(Mux0_o)

);

ProgramCounter PC(
  .clk_i(clk_i),
  .rst_i(rst_i),
  .pc_in_i(Mux0_o),
  .pc_out_o(pc_out_o),
  .pc_write(pc_write)

);

Instruction_Memory IM(
  .addr_i(pc_out_o),
  .instr_o(instr_mem)

);
			
Adder Add_pc(
  .src1_i(pc_out_o),
  .src2_i(32'd4),
  .sum_o(adder1_o)

);

		
Pipe_reg_control #(.size(64))IF_ID(     
  .clk_i(clk_i),
  .rst_i(rst_i),
  .data_i({adder1_o,instr_mem}),
  .write(if_idwrite),
  .data_o(IF_ID_o)//N is the total length of input/output


);


//Instantiate the components in ID stage
Reg_File RF(
    .clk_i(clk_i),
    .rst_i(rst_i),
    .RSaddr_i(IF_ID_o[25:21]),
    .RTaddr_i(IF_ID_o[20:16]),
    .RDaddr_i(MEM_WB_o[4:0]),
    .RDdata_i(Mux3_o),
    .RegWrite_i(MEM_WB_o[70]),
    .RSdata_o(read_data1_o),
    .RTdata_o(read_data2_o)

);

Decoder DecoderA(
   .instr_op_i(IF_ID_o[31:26]), 
   .RegWrite_o(Regwrite), 
   .ALU_op_o(ALUOp),   
   .ALUSrc_o(ALUSrc),   
   .RegDst_o(RegDst),   
   .Branch_o(branch),
   .Branchtype_o(branchtype_o),
   .MemRead_o(Memread),
   .MemWrite_o(Memwrite),
   .MemtoReg_o(MemtoReg)   
);

Sign_Extend Sign_Extend(
  .data_i(IF_ID_o[15:0]),
  .data_o(extend)
);	

Pipe_Reg #(.size(155) )ID_EX(     
  .clk_i(clk_i),
  .rst_i(rst_i),
  .data_i({Mux4_o[11:10],IF_ID_o[25:21],Mux4_o[9:0],IF_ID_o[63:32],read_data1_o,read_data2_o,extend,IF_ID_o[20:11]}),
  .data_o(ID_EX_o)//N is the total length of input/output


);


//Instantiate the components in EX stage	   
Shift_Left_Two_32 Shifter(
  .data_i(ID_EX_o[41:10]),
  .data_o(shift_o)

);

ALU ALU(
  .src1_i(Mux7_o),
  .src2_i(Mux1_o),
  .ctrl_i(ALU_ctrl),
  .result_o(result2_o),
  .zero_o(zero)

);
		
ALU_Control ALU_Control(
  .funct_i(ID_EX_o[15:10]),
  .ALUOp_i(ID_EX_o[141:139]),
  .ALUCtrl_o(ALU_ctrl)
);

MUX_2to1 #(.size(32)) Mux1(
  .data0_i(Mux8_o),
  .data1_i(ID_EX_o[41:10]),
  .select_i(ID_EX_o[138]),
  .data_o(Mux1_o)


);
		
MUX_2to1 #(.size(5)) Mux2(
  .data0_i(ID_EX_o[9:5]),
  .data1_i(ID_EX_o[4:0]),
  .select_i(ID_EX_o[142]),
  .data_o(Mux2_o)

);

Adder Add_pc_branch(
  .src1_i(ID_EX_o[137:106]),
  .src2_i(shift_o),
  .sum_o(result1_o)
   
);

Pipe_Reg #(.size(107)) EX_MEM(
 .clk_i(clk_i),
 .rst_i(rst_i),
 .data_i({Mux5_o,Mux6_o,result1_o,Mux9_o,result2_o,Mux8_o,Mux2_o}),
 .data_o(EX_MEM_o)//N is the total length of input/output
);


//Instantiate the components in MEM stage
Data_Memory DM(
  .clk_i(clk_i),
  .addr_i(EX_MEM_o[68:37]),
  .data_i(EX_MEM_o[36:5]),
  .MemRead_i(EX_MEM_o[103]),
  .MemWrite_i(EX_MEM_o[102]),
  .data_o(Datamem_o)

);

Pipe_Reg #(.size(71) )MEM_WB(
 .clk_i(clk_i),
 .rst_i(rst_i),
 .data_i({EX_MEM_o[106:105],Datamem_o,EX_MEM_o[68:37],EX_MEM_o[4:0]}),
 .data_o(MEM_WB_o)//N is the total length of input/output

);


//Instantiate the components in WB stage
MUX_2to1 #(.size(32)) Mux3(
  .data0_i(MEM_WB_o[68:37]),
  .data1_i(MEM_WB_o[36:5]),
  .select_i(MEM_WB_o[69]),
  .data_o(Mux3_o)

);
MUX_2to1 #(.size(12)) Mux4(
  .data0_i({branchtype_o,Regwrite,MemtoReg,branch,Memread,Memwrite,RegDst,ALUOp,ALUSrc}),
  .data1_i(10'b0),
  .select_i(id_flush),
  .data_o(Mux4_o)

);
MUX_2to1 #(.size(2)) Mux5(
  .data0_i(ID_EX_o[147:146]),
  .data1_i(2'b0),
  .select_i(ex_flush),
  .data_o(Mux5_o)

);
MUX_2to1 #(.size(3)) Mux6(
  .data0_i(ID_EX_o[145:143]),
  .data1_i(3'b0),
  .select_i(ex_flush),
  .data_o(Mux6_o)

);
MUX_3to1 #(.size(32)) Mux7(
  .data0_i(ID_EX_o[105:74]),
  .data1_i(EX_MEM_o[68:37]),
  .data2_i(Mux3_o),
  .select_i(forwardA),
  .data_o(Mux7_o)

);
MUX_3to1 #(.size(32)) Mux8(
  .data0_i(ID_EX_o[73:42]),
  .data1_i(EX_MEM_o[68:37]),
  .data2_i(Mux3_o),
  .select_i(forwardB),
  .data_o(Mux8_o)

);
MUX_4to1 #(.size(1)) Mux9(
  .data0_i(zero),
  .data1_i(!(zero||result2_o[31])),
  .data2_i(!result2_o[31]),
  .data3_i(~zero),
  .select_i(ID_EX_o[154:153]),
  .data_o(Mux9_o)

);
hazard_detection HZ(
    .id_ex_regRt(ID_EX_o[9:5]),
    .id_ex_memread(ID_EX_o[144]),
    .if_id_regRs(IF_ID_o[25:21]),
    .if_id_regRt(IF_ID_o[20:16]),
    .PC_source(EX_MEM_o[104]&EX_MEM_o[69]),
    .PCwrite(pc_write),
    .if_idWrite(if_idwrite),
    .if_flush(if_flush),
    .id_flush(id_flush),
    .ex_flush(ex_flush)
  );

/****************************************
signal assignment
****************************************/

endmodule

