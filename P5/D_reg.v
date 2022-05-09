module D_reg (
    input [31:0] pc,
    output [31:0] D_pc,
    input [31:0] instr,
    output [31:0] D_instr, 
    input En,
    input clk,
	input reset
);
    reg [31:0] reg_D_pc ;
    reg [31:0] reg_D_instr ;
    always @(posedge clk) begin
		  if (reset == 1 ) begin
				reg_D_pc <= 0 ;
				reg_D_instr <= 0 ;
		  end		  
        else if (En == 1) begin
            reg_D_pc <= pc ;
            reg_D_instr <= instr ;
        end  
    end
    assign D_pc = reg_D_pc ;
    assign D_instr = reg_D_instr ;
endmodule //D_reg