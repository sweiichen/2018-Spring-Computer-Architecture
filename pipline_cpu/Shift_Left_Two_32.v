//Subject:      CO project 2 - Shift_Left_Two_32
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer: 0510008 藍挺毓 & 0510026 陳司瑋
//--------------------------------------------------------------------------------

module Shift_Left_Two_32(
    data_i,
    data_o
    );

//I/O ports                    
input [32-1:0] data_i;
output [32-1:0] data_o;

//shift left 2

assign data_o= {data_i[29:0], 2'b00}; 
     
endmodule