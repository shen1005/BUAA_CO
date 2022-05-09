module W_reg (
    input [31:0] M_pc,
    output [31:0] W_pc,
    input M_regwe,
    output W_regwe,
    input [4:0] M_A3,
    output [4:0] W_A3,
    input [31:0] M_regwd,
    output [31:0] W_regwd,
    input [1:0] M_Tnew,
    output [1:0] W_Tnew,
    input [4:0] M_rtad,
    output [4:0] W_rtad,
    input M_bd,
    output W_bd,
    input clk,
	input reset
);
    reg [31:0] reg_W_pc ;
    reg reg_W_regwe ;
    reg [4:0] reg_W_A3 ;
    reg [31:0] reg_W_regwd ;
    reg [1:0] reg_W_Tnew ;
    reg [4:0] reg_W_rtad ;
    reg reg_W_bd ;
    always @(posedge clk) begin
		if(reset == 1) begin
		  reg_W_pc <= 0 ;
        reg_W_regwe <= 0 ;
        reg_W_A3 <= 0 ;
        reg_W_regwd <= 0 ;
        reg_W_Tnew <= 0 ;
        reg_W_rtad <= 0 ;
        reg_W_bd <= 0 ;
		end
		else begin
        reg_W_bd <= M_bd ;
        reg_W_pc <= M_pc ;
        reg_W_regwe <= M_regwe ;
        reg_W_A3 <= M_A3 ;
        reg_W_regwd <= M_regwd ;
        if (M_Tnew == 0) reg_W_Tnew <= 0 ;
        else reg_W_Tnew <= M_Tnew ;
        reg_W_rtad <= M_rtad ;
		 end
    end
    assign W_bd = reg_W_bd ;
    assign W_pc = reg_W_pc ;
    assign W_regwe = reg_W_regwe ;
    assign W_A3 = reg_W_A3 ;
    assign W_regwd = reg_W_regwd ;
    assign W_Tnew = reg_W_Tnew ;
    assign W_rtad = reg_W_rtad ;
endmodule //W_reg