module D_reg (
    input [31:0] pc,
    output [31:0] D_pc,
    input [31:0] instr,
    output [31:0] D_instr, 
    input [4:0] Exccode,
    output [4:0] D_Exccode,
    input En,
    input clk,
    input req,
	input reset
);
    reg [31:0] reg_D_pc ;
    reg [31:0] reg_D_instr ;
    reg [4:0] reg_D_Exccode ;
    always @(posedge clk) begin
		  if (reset || req) begin
				reg_D_pc <= (req)? 32'h4180 : 0 ;
				reg_D_instr <= 0 ;
                reg_D_Exccode <= 0 ;
		  end		  
        else if (En == 1) begin
            reg_D_pc <= pc ;
            reg_D_instr <= instr ;
            reg_D_Exccode <= Exccode ;
        end  
    end
    assign D_pc = reg_D_pc ;
    assign D_instr = reg_D_instr ;
    assign D_Exccode = reg_D_Exccode ;
endmodule 