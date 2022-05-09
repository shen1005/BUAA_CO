module mips (
    input clk,
    input reset
);

    wire [1:0] D_rsop ;
    wire [1:0] D_rtop ;
    wire [1:0] E_rsop ;
    wire [1:0] E_rtop ;
    wire [1:0] M_swop ;
    wire stall ;



    wire En ;
    wire clr ;
	 assign clr = stall	 ;
	 assign En = ( stall == 0 ) ;
    wire [31:0] pc ;
    wire [31:0] next_pc ;
    wire [31:0] instr ;
    wire [31:0] pc8 ;
    wire [31:0] D_rs ;
    wire [31:0] D_rsb ;
    wire is_branch ;
    wire [15:0] imm16 ;
    wire [25:0] imm26 ;
    wire is_j ;
    wire is_b ;
    wire is_jr ;
    IFU uut_IFU(.clk(clk), .reset(reset), .next_pc(next_pc), .pc(pc), .instr(instr), .En(En)) ;
    NPC uut_npc(.pc(pc), .imm16(imm16), .imm26(imm26), .is_b(is_b), .is_j(is_j), .is_jr(is_jr), .is_branch(is_branch), .rs(D_rs), .pc8(pc8), .next_pc(next_pc)) ;
    /*
    input is_branch,
    */




	 //wire of D_reg
	 wire [31:0] D_pc ;
    wire [31:0] D_instr ;
    D_reg uut_D(.pc(pc), .D_pc(D_pc), .instr(instr), .D_instr(D_instr), .En(En), .clk(clk), .reset(reset)) ;
    //below --- wire of deal and control
    wire [5:0] op ;
    wire [5:0] func ;
    wire [4:0] D_rsad ;
    wire [4:0] D_rtad ;
    wire [4:0] D_rdad ;
    deal_instr uut_deal(.instr(D_instr), .op(op), .func(func), .rsad(D_rsad), .rtad(D_rtad), .rdad(D_rdad), .imm16(imm16), .imm26(imm26)) ;
    // wire of only control
    wire [3:0] D_ALUop ;
    wire [2:0] EXTop ;
    wire D_regwe ;
    wire D_memse ;
    wire [1:0] A3op ;
    wire [1:0] D_regwdop ;
    wire D_ALUrt_or_immop ;
    wire [1:0] D_rs_Tuse ;
    wire [1:0] D_rt_Tuse ;
    wire [1:0] D_Tnew ;
    control uut_control(.op(op), .func(func), .ALUop(D_ALUop), .EXTop(EXTop), .is_j(is_j), .is_b(is_b), .is_jr(is_jr), .regwe(D_regwe), .memse(D_memse), .A3op(A3op), .regwdop(D_regwdop), .ALUrt_or_immop(D_ALUrt_or_immop), .D_rs_Tuse(D_rs_Tuse), .D_rt_Tuse(D_rt_Tuse), .D_Tnew(D_Tnew)) ;
    //wire of grf
    wire [31:0] D_rt ;
    wire [31:0] D_rtb ;
    wire [31:0] D_rd ;
    wire [4:0] D_A3 ;
	 wire W_regwe ;
	 wire [4:0] W_A3 ;
	 wire [31:0] W_regwd ;
    GRF uut_grf(.clk(clk), .reset(reset), .regwe(W_regwe), .A1(D_rsad), .A2(D_rtad), .A3(W_A3), .regwd(W_regwd), .B1(D_rsb), .B2(D_rtb)) ;
    /*
    input regwe,
    input [4:0]A3,
    input [31:0]regwd,
    */
    wire [31:0] D_imm32 ;
    ext uut_ext(.EXTop(EXTop), .imm16(imm16), .imm32(D_imm32)) ;
    assign D_A3 = (A3op == 2)? 5'b11111 :
                  (A3op == 1)? D_rdad : D_rtad ;
    assign is_branch = (D_rs == D_rt)? 1 : 0 ;
    assign D_rs = (D_rsop == 1)? E_pc+8 :
                  (D_rsop == 2)? M_regwd :
                  (D_rsop == 3)? W_regwd : D_rsb ;
    assign D_rt = (D_rtop == 1)? E_pc+8 :
                  (D_rtop == 2)? M_regwd :
                  (D_rtop == 3)? W_regwd : D_rtb ;    


    //E part!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    wire [3:0] E_ALUop ;
    wire [31:0] E_imm32 ;
    wire E_regwe ;
    wire E_memse ;
    wire [4:0] E_A3 ;
    wire [1:0] E_regwdop ;
    wire E_ALUrt_or_immop ;
    wire [31:0] E_rs ;
    wire [31:0] E_rsb ;
    wire [31:0] E_rt ;
    wire [31:0] E_rtb ;
    wire [31:0] E_pc ;
    wire [1:0] E_rs_Tuse ;
    wire [1:0] E_rt_Tuse ;
    wire [1:0] E_Tnew ;
    wire [4:0] E_rsad ;
    wire [4:0] E_rtad ;
    wire [31:0] E_regwd ;
    E_reg uut_E(.reset(reset), .D_ALUop(D_ALUop), .E_ALUop(E_ALUop), .D_imm32(D_imm32), .E_imm32(E_imm32), .D_regwe(D_regwe), .E_regwe(E_regwe), .D_memse(D_memse), .E_memse(E_memse), .D_A3(D_A3), .E_A3(E_A3), .D_regwdop(D_regwdop), .E_regwdop(E_regwdop), .D_ALUrt_or_immop(D_ALUrt_or_immop), .E_ALUrt_or_immop(E_ALUrt_or_immop), .D_rt(D_rt), .E_rt(E_rtb), .D_rs(D_rs), .E_rs(E_rsb), .D_pc(D_pc), .E_pc(E_pc), .clk(clk), .clr(clr), .D_rs_Tuse(D_rs_Tuse), .E_rs_Tuse(E_rs_Tuse), .D_rt_Tuse(D_rt_Tuse), .E_rt_Tuse(E_rt_Tuse), .D_Tnew(D_Tnew), .E_Tnew(E_Tnew), .D_rsad(D_rsad), .E_rsad(E_rsad), .D_rtad(D_rtad), .E_rtad(E_rtad)) ;
    //wire of alu
    wire [31:0] rt_or_imm ;
    wire [31:0] E_result ;
	 assign rt_or_imm = (E_ALUrt_or_immop == 0)? E_rt : E_imm32 ;
     assign E_regwd = (E_regwdop == 2)? E_pc+8 : E_result ;
     assign E_rs = (E_rsop == 1)? M_regwd :
                    (E_rsop == 2)? W_regwd : E_rsb ;
     assign E_rt = (E_rtop == 1)? M_regwd :
                    (E_rtop == 2)? W_regwd : E_rtb ;
    ALU uut_alu(.rs(E_rs), .rt_or_imm(rt_or_imm), .result(E_result), .ALUop(E_ALUop)) ;
    





    //M part!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    wire [31:0] M_result ;
    wire M_regwe ;
    wire M_memse ;
    wire [4:0] M_A3 ;
    wire [1:0] M_regwdop ;
    wire [31:0] M_rt ;
    wire [31:0] M_rtb ;
    wire [31:0] M_pc ;
    wire [1:0] M_rs_Tuse ;
    wire [1:0] M_rt_Tuse ;
    wire [1:0] M_Tnew ;
    wire [4:0] M_rsad ;
    wire [4:0] M_rtad ;
    wire [31:0] M_regwd ;
	 wire [31:0] MW_regwd ;
    M_reg uut_M(.reset(reset), .E_regwd(E_regwd), .M_regwd(M_regwd), .E_result(E_result), .M_result(M_result), .E_regwe(E_regwe), .M_regwe(M_regwe), .E_memse(E_memse), .M_memse(M_memse), .E_A3(E_A3), .M_A3(M_A3), .E_regwdop(E_regwdop), .M_regwdop(M_regwdop), .E_rt(E_rt), .M_rt(M_rtb), .E_pc(E_pc), .M_pc(M_pc), .clk(clk), .E_rs_Tuse(E_rs_Tuse), .M_rs_Tuse(M_rs_Tuse), .E_rt_Tuse(E_rt_Tuse), .M_rt_Tuse(M_rt_Tuse), .E_Tnew(E_Tnew), .M_Tnew(M_Tnew), .E_rsad(E_rsad), .M_rsad(M_rsad), .E_rtad(E_rtad), .M_rtad(M_rtad)) ;
    wire [31:0] DM_data ;
    DM uut_DM(.address(M_result[13:2]), .data(M_rt), .clk(clk), .memse(M_memse), .DM_data(DM_data), .reset(reset)) ;
    assign MW_regwd =(M_regwdop == 1)? DM_data : M_regwd ;
    assign M_rt = (M_swop == 1)? W_regwd : M_rtb ;
    




    //W part!!!!!!!!!!!!!!!!!!
    wire [31:0] W_pc ;
    wire [1:0] W_rs_Tuse ;
    wire [1:0] W_rt_Tuse ;
    wire [1:0] W_Tnew ;
    wire [4:0] W_rtad ;
    W_reg uut_W(.reset(reset), .M_pc(M_pc), .W_pc(W_pc), .M_regwe(M_regwe), .W_regwe(W_regwe), .M_A3(M_A3), .W_A3(W_A3), .M_regwd(MW_regwd), .W_regwd(W_regwd), .clk(clk), .M_Tnew(M_Tnew), .W_Tnew(W_Tnew), .M_rtad(M_rtad), .W_rtad(W_rtad)) ;


    adven uut_ad(.D_rs_Tuse(D_rs_Tuse), .D_rt_Tuse(D_rt_Tuse), .D_rsad(D_rsad), .D_rtad(D_rtad), .E_rs_Tuse(E_rs_Tuse), .E_rt_Tuse(E_rt_Tuse), .E_Tnew(E_Tnew), .E_rsad(E_rsad), .E_rtad(E_rtad), .E_A3(E_A3), .E_regwe(E_regwe), .M_rs_Tuse(M_rs_Tuse), .M_rt_Tuse(M_rt_Tuse), .M_Tnew(M_Tnew), .M_rsad(M_rsad), .M_rtad(M_rtad), .M_A3(M_A3), .M_regwe(M_regwe), .W_A3(W_A3), .W_regwe(W_regwe), .D_rsop(D_rsop), .D_rtop(D_rtop), .E_rsop(E_rsop), .E_rtop(E_rtop), .M_swop(M_swop), .stall(stall)) ;


    always @(posedge clk) begin
        if (W_regwe == 1 && reset != 1) begin
            $display("%d@%h: $%d <= %h", $time, W_pc , W_A3, W_regwd) ;
        end
        if (M_memse == 1 && reset != 1) begin
            $display("%d@%h: *%h <= %h", $time, M_pc, M_result, M_rt) ;
        end
    end

endmodule 
    