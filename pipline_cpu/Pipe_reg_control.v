`timescale 1ns / 1ps
//Subject:     CO project 4 - Pipe Register
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0510008 藍挺毓 & 0510026 陳司瑋
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Pipe_reg_control(
    clk_i,
    rst_i,
    data_i,
    write,
    data_o
    );
					
parameter size = 0;

input   clk_i;		  
input   rst_i;
input   write;
input   [size-1:0] data_i;
output reg  [size-1:0] data_o;
	  
always@(posedge clk_i) begin
    if(~rst_i)
        data_o <= 0;
    else if(write)
        data_o <= data_i;
        else data_o<=data_o;
end

endmodule	