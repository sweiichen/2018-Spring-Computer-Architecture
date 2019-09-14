`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 0510008 藍挺毓 & 0510026 陳司瑋
// 
// Create Date: 06/05/2018 06:45:36 PM
// Design Name: 
// Module Name: forwarding_unit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module forwarding_unit(
    ex_mem_RegWrite,
    ex_mem_RegRd,
    id_ex_RegRs,
    id_ex_RegRt,
    mem_wb_RegWrite,
    mem_wb_RegRd,
    ForwardA,
    ForwardB
    );
    
input ex_mem_RegWrite;
input [5-1:0]ex_mem_RegRd;
input [5-1:0]id_ex_RegRs;
input [5-1:0]id_ex_RegRt;
input mem_wb_RegWrite;
input [5-1:0]mem_wb_RegRd;
output [2-1:0]ForwardA;
output [2-1:0]ForwardB;

reg [2-1:0]ForwardA;
reg [2-1:0]ForwardB;

always@(*)begin
 if( (ex_mem_RegWrite && (ex_mem_RegRd!=0)) && (ex_mem_RegRd == id_ex_RegRs) ) ForwardA=2'b01;
 else if ( mem_wb_RegWrite && (mem_wb_RegRd!=0) && (mem_wb_RegRd==id_ex_RegRs)) ForwardA=2'b10;
 else ForwardA=2'b00;
 
 if(ex_mem_RegWrite && (ex_mem_RegRd!=0) && (ex_mem_RegRd==id_ex_RegRt)) ForwardB = 2'b01;
 else if ( mem_wb_RegWrite && (mem_wb_RegRd!=0) && (mem_wb_RegRd==id_ex_RegRt) ) ForwardB=2'b10;
 else ForwardB = 2'b00; 
 
end
    
    
endmodule
