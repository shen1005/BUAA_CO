module E_reg (
    input [3:0] D_ALUop,
    output [3:0] E_ALUop,
    input [31:0]  D_imm32,
    output [31:0] E_imm32,
    input D_regwe,
    output E_regwe,
    input D_memse,
    output E_memse,
    input [4:0] D_A3,
    output [4:0]  E_A3,
    input [1:0] D_regwdop,
    output [1:0] E_regwdop,
    input D_ALUrt_or_immop,
    output E_ALUrt_or_immop,
    input [31:0] D_rt,
    output [31:0] E_rt,
    input [31:0] D_rs,
    output [31:0] E_rs,
    input [31:0] D_pc,
    output [31:0] E_pc,
    input [1:0] D_rs_Tuse,
    output [1:0] E_rs_Tuse,
    input [1:0] D_rt_Tuse, 
    output [1:0] E_rt_Tuse,
    input [1:0] D_Tnew,
    output [1:0] E_Tnew,
    input [4:0] D_rsad,
    output [4:0] E_rsad,
    input [4:0] D_rtad,
    output [4:0] E_rtad,
    input clk,
    input clr,
	 input reset
);
    reg [3:0] reg_E_ALUop ;
    reg reg_E_ALUrt_or_immop ;
    reg [4:0] reg_E_A3 ;
    reg [31:0] reg_E_imm32 ;
    reg reg_E_regwe ;
    reg reg_E_memse ;
    reg [1:0] reg_E_regwdop ;
    reg [31:0] reg_E_rt ;
    reg [31:0] reg_E_rs ;
    reg [31:0] reg_E_pc ;
    reg [1:0] reg_E_rs_Tuse ;
    reg [1:0] reg_E_rt_Tuse ;
    reg [1:0] reg_E_Tnew ;
    reg [4:0] reg_E_rsad ;
    reg [4:0] reg_E_rtad ;
    always @(posedge clk) begin
		  if (reset == 1) begin
				reg_E_ALUop <= 0 ;
            reg_E_ALUrt_or_immop <= 0 ;
            reg_E_A3 <= 0 ;
            reg_E_imm32 <= 0 ;
            reg_E_regwe <= 0 ;
            reg_E_memse <= 0 ;
            reg_E_regwdop <= 0 ;
            reg_E_rt <= 0 ;
            reg_E_rs <= 0 ;
            reg_E_rs_Tuse <= 3 ;
            reg_E_rt_Tuse <= 3 ;
            reg_E_Tnew <= 0 ;
            reg_E_rsad <= 0 ;
            reg_E_rtad <= 0 ;
            reg_E_pc <= 0 ;
		  end
        else if (clr == 1) begin
            reg_E_ALUop <= 0 ;
            reg_E_ALUrt_or_immop <= 0 ;
            reg_E_A3 <= 0 ;
            reg_E_imm32 <= 0 ;
            reg_E_regwe <= 0 ;
            reg_E_memse <= 0 ;
            reg_E_regwdop <= 0 ;
            reg_E_rt <= 0 ;
            reg_E_rs <= 0 ;
            reg_E_rs_Tuse <= 3 ;
            reg_E_rt_Tuse <= 3 ;
            reg_E_Tnew <= 0 ;
            reg_E_rsad <= 0 ;
            reg_E_rtad <= 0 ;
            reg_E_pc <= 0 ;
        end
        else begin
            reg_E_ALUop <= D_ALUop ;
            reg_E_ALUrt_or_immop <= D_ALUrt_or_immop ;
            reg_E_A3 <= D_A3 ;
            reg_E_imm32 <= D_imm32 ;
            reg_E_regwe <= D_regwe ;
            reg_E_memse <= D_memse ;
            reg_E_regwdop <= D_regwdop ;
            reg_E_rt <= D_rt ;
            reg_E_rs <= D_rs ;
            reg_E_pc <= D_pc ;
            reg_E_rs_Tuse <= D_rs_Tuse ;
            reg_E_rt_Tuse <= D_rt_Tuse ;
            if (D_Tnew == 0) reg_E_Tnew <= 0 ;
            else reg_E_Tnew <= D_Tnew ;
             reg_E_rsad <= D_rsad ;
            reg_E_rtad <= D_rtad ;
        end
    end
    assign E_ALUop = reg_E_ALUop ;
    assign E_ALUrt_or_immop = reg_E_ALUrt_or_immop ;
    assign E_A3 = reg_E_A3 ;
    assign E_imm32 = reg_E_imm32 ;
    assign E_regwe = reg_E_regwe ;
    assign E_memse = reg_E_memse ;
    assign E_regwdop = reg_E_regwdop ;
    assign E_rt = reg_E_rt ;
    assign E_rs = reg_E_rs ;
    assign E_pc = reg_E_pc ;
    assign E_rs_Tuse = reg_E_rs_Tuse ;
    assign E_rt_Tuse = reg_E_rt_Tuse ;
    assign E_Tnew = reg_E_Tnew ;
    assign E_rsad = reg_E_rsad ;
    assign E_rtad = reg_E_rtad ;
endmodule 

