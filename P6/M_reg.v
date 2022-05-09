module M_reg (
    input [31:0] E_result,
    output [31:0] M_result,
    input E_regwe,
    output M_regwe,
    input [3:0] E_memlb,
    output [3:0] M_memlb, 
    input [3:0] E_mem_byteen,
    output [3:0] M_mem_byteen,
    input [4:0] E_A3,
    output [4:0] M_A3,
    input [1:0] E_regwdop,
    output [1:0] M_regwdop,
    input [31:0] E_rt,
    output [31:0] M_rt,
    input [31:0] E_pc,
    output [31:0] M_pc,
    input [1:0] E_rs_Tuse,
    output [1:0] M_rs_Tuse,
    input [1:0] E_rt_Tuse, 
    output [1:0] M_rt_Tuse,
    input [1:0] E_Tnew,
    output [1:0] M_Tnew,
    input [4:0] E_rsad,
    output [4:0] M_rsad,
    input [4:0] E_rtad,
    output [4:0] M_rtad,
    input [31:0] E_regwd,
    output [31:0] M_regwd,
    input clk,
	 input reset
);
    reg [31:0] reg_M_result ;
    reg reg_M_regwe ;
    reg [3:0] reg_M_memlb ;
    reg [3:0] reg_M_mem_byteen ;
    reg [4:0] reg_M_A3 ;
    reg [1:0] reg_M_regwdop ;
    reg [31:0] reg_M_rt ;
    reg [31:0] reg_M_pc ;
    reg [1:0] reg_M_rs_Tuse ;
    reg [1:0] reg_M_rt_Tuse ;
    reg [1:0] reg_M_Tnew ;
    reg [4:0] reg_M_rsad ;
    reg [4:0] reg_M_rtad ;
    reg [31:0] reg_M_regwd ;
    always @(posedge clk) begin
		if (reset == 1) begin
        reg_M_memlb <= 0 ;
		  reg_M_result <= 0 ;
        reg_M_regwe <= 0 ;
        reg_M_mem_byteen <= 0 ;
        reg_M_A3 <= 0 ;
        reg_M_regwdop <= 0 ;
        reg_M_rt <= 0 ;
        reg_M_pc <= 0 ;
        reg_M_rs_Tuse <= 3 ;
        reg_M_rt_Tuse <= 3 ;
        reg_M_Tnew <= 0 ;
        reg_M_rsad <= 0 ;
        reg_M_rtad <= 0 ;
        reg_M_regwd <= 0 ;
		end
		else begin
        reg_M_memlb <= E_memlb ;
        reg_M_result <= E_result ;
        reg_M_regwe <= E_regwe ;
        reg_M_mem_byteen <= E_mem_byteen ;
        reg_M_A3 <= E_A3 ;
        reg_M_regwdop <= E_regwdop ;
        reg_M_rt <= E_rt ;
        reg_M_pc <= E_pc ;
        reg_M_rs_Tuse <= E_rs_Tuse ;
        reg_M_rt_Tuse <= E_rt_Tuse ;
        if (E_Tnew == 0) reg_M_Tnew <= 0 ;
        else reg_M_Tnew <= E_Tnew ;
        reg_M_rsad <= E_rsad ;
        reg_M_rtad <= E_rtad ;
        reg_M_regwd <= E_regwd ;
		  end
    end
    assign M_memlb = reg_M_memlb ;
    assign M_result = reg_M_result ;
    assign M_regwe = reg_M_regwe ;
    assign M_mem_byteen = reg_M_mem_byteen ;
    assign M_A3 = reg_M_A3 ;
    assign M_regwdop = reg_M_regwdop ;
    assign M_rt = reg_M_rt ;
    assign M_pc = reg_M_pc ;
    assign M_rs_Tuse = reg_M_rs_Tuse ;
    assign M_rt_Tuse = reg_M_rt_Tuse ;
    assign M_Tnew = reg_M_Tnew ;
    assign M_rsad = reg_M_rsad ;
    assign M_rtad = reg_M_rtad ;
    assign M_regwd = reg_M_regwd ;  
endmodule 
//     [3:0] E_ALUop,
//     [31:0] E_imm32,
//     E_ALUrt_or_immop,
//     [31:0] E_rs,
//     [31:0] E_pc, 