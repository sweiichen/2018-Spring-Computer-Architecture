`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 0510008 藍挺毓 & 0510026 陳司瑋
// 
// Create Date: 06/05/2018 06:53:30 PM
// Design Name: 
// Module Name: hazard_detection
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


module hazard_detection(
    id_ex_regRt,
    id_ex_memread,
    if_id_regRs,
    if_id_regRt,
    PC_source,
    PCwrite,
    if_idWrite,
    if_flush,
    id_flush,
    ex_flush
    

    );
    input [4:0]id_ex_regRt;
    input [4:0]if_id_regRs;
    input [4:0]if_id_regRt;
    input id_ex_memread;
    input PC_source;
    output reg PCwrite;
    output reg  if_idWrite;
    output reg if_flush;
    output reg id_flush;
    output reg ex_flush;
    
     
always@(*)begin
    if(id_ex_memread && ((if_id_regRs == id_ex_regRt)|(if_id_regRt == id_ex_regRt)))begin
        PCwrite = 1'b0;
        if_idWrite = 1'b0;
        if_flush = 1'b1;
        id_flush = 1'b0;
        ex_flush = 1'b0;
    end
    else if(PC_source)begin
        PCwrite = 1'b1;
        if_idWrite = 1'b1;
        if_flush = 1'b1;
        id_flush = 1'b1;
        ex_flush = 1'b1;
    end
    else begin
        PCwrite = 1'b1;
        if_idWrite = 1'b1;
        if_flush = 1'b0;
        id_flush = 1'b0;
        ex_flush = 1'b0;
    end
  

end    
    
endmodule
