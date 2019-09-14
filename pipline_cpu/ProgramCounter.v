//Subject:     CO project 2 - PC
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0510008 藍挺毓 & 0510026 陳司瑋
//----------------------------------------------
//Date:        2010/8/16
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ProgramCounter(
    clk_i,
	rst_i,
	pc_in_i,
	pc_out_o,
	pc_write
	);
     
//I/O ports
input           clk_i;
input	        rst_i;
input  [32-1:0] pc_in_i;
output [32-1:0] pc_out_o;
input           pc_write;
 
//Internal Signals
reg    [32-1:0] pc_out_o;
 
//Parameter

    
//Main function
always @(posedge clk_i) begin
    if(~rst_i)
    	pc_out_o <= 0;

    else if(pc_write)begin
        
	   
	       pc_out_o <= pc_in_i;
    end
    else pc_out_o <= pc_out_o;
    
end
endmodule



                    
                    