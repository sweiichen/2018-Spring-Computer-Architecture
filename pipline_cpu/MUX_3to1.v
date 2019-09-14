`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 0510008 藍挺毓 & 0510026 陳司瑋
// 
// Create Date: 05/11/2018 06:45:27 PM
// Design Name: 
// Module Name: MUX_3to1
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


module MUX_3to1( data0_i,
               data1_i,
               data2_i,
               select_i,
               data_o

    );
    parameter size = 0;
    input [size-1:0]data0_i;
    input [size-1:0]data1_i;
    input [size-1:0]data2_i;
    
    input  [1:0]select_i;
    output [size-1:0]data_o;
    reg    [size-1:0] data_o;
    always@(*)begin
    case(select_i)
    2'b00: data_o = data0_i;
    2'b01: data_o = data1_i;
    2'b10: data_o = data2_i;
    endcase
     end
    
endmodule