`include "define.v"
module control (
    input [5:0] op,
    input [5:0] func,
	 input [4:0] b_func,
    output [5:0] ALUop,
    output [2:0] EXTop,
    output is_j ,
    output is_b ,
    output is_jr , 
    output regwe ,
    output [3:0] memlb,
    output [3:0] mem_byteen, 
    output [1:0] A3op,
    output [1:0] regwdop,
    output [3:0] branchop, 
    output  ALUrt_or_immop,
    output rs_or_immop,
    output start,
    output hilowe,
    output hilo_A3,
    output stall_busy,
    output [1:0] re_hi_loop,  
    output [1:0] D_rs_Tuse,
    output [1:0] D_rt_Tuse,
    output [1:0] D_Tnew   
);
    wire beq ;
    wire jal ;
    wire addu ;
    wire subu ;
    wire ori ;
    wire lw ;
    wire sw ;
    wire lui ;
    wire jr ;
    wire j ;
    wire lb ;
    wire lbu ;
    wire lh ;
    wire lhu ;
    wire sb ;
    wire sh ;
    wire add ;
    wire sub ;
    wire mult ;
    wire multu ;
    wire div ;
    wire divu ;
    wire sll ;
    wire srl ;
    wire sra ;
    wire sllv ;
    wire srlv ;
    wire srav ;
    wire instr_and ;
    wire instr_or ;
    wire instr_xor ;
    wire instr_nor ;
    wire addi ;
    wire addiu ;
    wire andi ;
    wire xori ;
    wire slt ;
    wire slti ;
    wire sltiu ;
    wire sltu ;
    wire bne ;
    wire blez ;
    wire bgtz ;
    wire bltz ;
    wire bgez ;
    wire jalr ;
    wire mfhi ;
    wire mflo ;
    wire mthi ;
    wire mtlo ;





    assign beq = (op == `beq)? 1 : 0 ;
    assign jal = (op == `jal)? 1 : 0 ;
    assign addu = (op == `addu_op && func == `addu_func)? 1 : 0 ;
    assign subu = (op == `subu_op && func == `subu_func)? 1 : 0 ;
    assign ori = (op == `ori)? 1 : 0 ;
    assign lw = (op == `lw)? 1 : 0 ;
    assign sw = (op == `sw)? 1 : 0 ;
    assign lui = (op == `lui)? 1 : 0 ;
    assign jr = (op == `jr_op && func == `jr_func)? 1 : 0 ;
    assign j = (op == `j)? 1 : 0 ;
    assign lb = (op == `lb)? 1 : 0 ;
    assign lbu = (op == `lbu)? 1 : 0 ;
    assign lh = (op == `lh)? 1 : 0 ;
    assign lhu = (op == `lhu)? 1 : 0 ;

    assign sb = (op == `sb)? 1 : 0 ;
    assign sh = (op == `sh)? 1 : 0 ;
    assign add = (op == `add_op && func == `add_func)? 1 : 0 ;
    assign sub = (op == `sub_op && func == `sub_func)? 1 : 0 ;
    assign mult = (op == `mult_op && func == `mult_func)? 1 : 0 ;
    assign multu = (op == `multu_op && func == `multu_func)? 1 : 0 ;
    assign div = (op == `div_op && func == `div_func)? 1 : 0 ;
    assign divu = (op == `divu_op && func == `divu_func)? 1 : 0 ;
    assign sll = (op == `sll_op && func == `sll_func)? 1 : 0 ;
    assign srl = (op == `srl_op && func == `srl_func)? 1 : 0 ;
    assign sra = (op == `sra_op && func == `sra_func)? 1 : 0 ;
    assign sllv = (op == `sllv_op && func == `sllv_func)? 1 : 0 ;
    assign srlv = (op == `srlv_op && func == `srlv_func)? 1 : 0 ;
    assign srav = (op == `srav_op && func == `srav_func)? 1 : 0 ;
    assign instr_and = (op == `and_op && func == `and_func)? 1 : 0 ;
    assign instr_or = (op == `or_op && func == `or_func)? 1 : 0 ;
    assign instr_xor = (op == `xor_op && func == `xor_func)? 1 : 0 ;
    assign instr_nor = (op == `nor_op && func == `nor_func)? 1 : 0 ;
    assign addi = (op == `addi)? 1 : 0 ;
    assign addiu = (op == `addiu)? 1 : 0 ;
    assign andi = (op == `andi)? 1 : 0 ;
    assign xori = (op == `xori)? 1 : 0 ;
    assign slt = (op == `slt_op && func == `slt_func)? 1 : 0 ;
    assign slti = (op == `slti)? 1 : 0 ;
    assign sltiu = (op == `sltiu)? 1 : 0 ;
    assign sltu = (op == `sltu_op && func == `sltu_func)? 1 : 0 ;
    assign bne = (op == `bne)? 1 : 0 ;
    assign blez = (op == `blez && b_func == `blez_func)? 1 : 0 ;
    assign bgtz = (op == `bgtz && b_func == `bgtz_func)? 1 : 0 ;
    assign bltz = (op == `bltz && b_func == `bltz_func)? 1 : 0 ;
    assign bgez = (op == `bgez && b_func == `bgez_func)? 1 : 0 ;
    assign jalr = (op == `jalr_op && func == `jalr_func)? 1 : 0 ;
    assign mfhi = (op == `mfhi_op && func == `mfhi_func)? 1 : 0 ;
    assign mflo = (op == `mflo_op && func == `mflo_func)? 1 : 0 ;
    assign mthi = (op == `mthi_op && func == `mthi_func)? 1 : 0 ;
    assign mtlo = (op == `mtlo_op && func == `mtlo_func)? 1 : 0 ; 






    assign ALUop = (addu||lw||sw||sb||sh||add||addi||addiu||lb||lbu||lh||lhu)? `ALUadd :
                    (subu||beq||sub)? `ALUsub :
                    (lui)? `ALUadd0 :
                    (ori||instr_or)? `ALUor : 
                    (sll)? `ALUsll : 
                    (srl)? `ALUsrl :
                    (sra)? `ALUsra :
                    (sllv)? `ALUsllv :
                    (srlv)? `ALUsrlv : 
                    (srav)? `ALUsrav :
                    (instr_and||andi)? `ALUand : 
                    (instr_xor||xori)? `ALUxor :
                    (instr_nor)? `ALUnor :
                    (slt||slti)? `ALUslt :
                    (sltiu||sltu)? `ALUsltu :  
                    (mult)? `ALUmul :
                    (multu)? `ALUmulu :
                    (div)? `ALUdiv :
                    (divu)? `ALUdivu : 0 ;
    assign EXTop = (ori||andi||xori)? `EXTzero :
                    (lw||sw||sb||sh||addi||addiu||slti||sltiu||lb||lbu||lh||lhu)? `EXTsign :
                    (lui)? `EXTlui : 
                    (sll||srl||sra)? `EXTsll : 0 ;
    assign is_j = (jal||j)? 1 : 0 ;
    assign is_b = (beq||bne||blez||bltz||bgtz||bgez)? 1 : 0 ;
    assign is_jr = (jr||jalr)? 1 : 0 ;
    assign regwe = jal||addu||subu||ori||lw||lui||add||sub||sll||srl||sra||sllv||srlv||srav||instr_and||instr_or||instr_nor||instr_xor||addi||addiu||andi||xori||slt||slti||sltiu||sltu||jalr||lb||lbu||lh||lhu||mfhi||mflo ;
    assign mem_byteen = {sw, sw, sh||sw, sw||sh||sb} ;
    assign memlb = (lw)? `memlb_lw :
                   (lb)? `memlb_lb :
                   (lbu)? `memlb_lbu :
                   (lh)? `memlb_lh :
                   (lhu)? `memlb_lhu : 0 ;
    assign A3op = (jal)? 2'b10 :
                  (addu||subu||add||sub||sll||srl||sra||sllv||srlv||srav||instr_and||instr_or||instr_nor||instr_xor||slt||sltu||jalr||mfhi||mflo)? 2'b01 :
                  2'b00 ;
    assign regwdop = (jal||jalr)? 2'b10 :
                     (addu||subu||ori||lui||add||sub||sll||srl||sra||sllv||srlv||srav||instr_and||instr_or||instr_nor||instr_xor||addi||addiu||andi||xori||slt||slti||sltiu||sltu||mfhi||mflo)? 2'b00 :
                     2'b01 ;
    assign branchop = (beq)? `bra_beq : 
                      (bne)? `bra_bne :
                      (bltz)? `bra_bltz :
                      (blez)? `bra_blez :
                      (bgtz)? `bra_bgtz :
                      (bgez)? `bra_bgez : 0 ;
    assign rs_or_immop = (sll||srl||sra)? 1'b1 : 1'b0 ;
    assign ALUrt_or_immop = (beq||addu||subu||add||sub||sll||srl||sra||sllv||srlv||srav||instr_and||instr_or||instr_nor||instr_xor||slt||sltu)? 1'b0 : 1'b1 ;
    assign D_rs_Tuse = (beq||jr||jalr||bne||blez||bltz||bgtz||bgez)? 0 : 
                       (addu||subu||ori||sw||lw||sb||sh||add||sub||sllv||srlv||srav||instr_and||instr_or||instr_nor||instr_xor||addi||addiu||andi||xori||slt||slti||sltiu||sltu||lb||lbu||lh||lhu||multu||mult||div||divu||mthi||mtlo)? 1 : 3 ;
    assign D_rt_Tuse = (beq||bne)? 0 :
                        (addu||subu||add||sub||sll||srl||sra||sllv||srlv||srav||instr_and||instr_or||instr_nor||instr_xor||slt||sltu||multu||mult||div||divu)? 1 :
                        (sw||sb||sh)? 2 : 3 ;
    assign D_Tnew = (addu||subu||ori||lui||add||sub||sll||srl||sra||sllv||srlv||srav||instr_and||instr_or||instr_nor||instr_xor||addi||addiu||andi||xori||slt||slti||sltiu||sltu||mfhi||mflo)? 1 :
                    (jal||jalr)? 0 :
                    (lw||lb||lh||lbu||lhu)? 2 : 0 ;



    assign start = (mult||multu||div||divu)? 1'b1 : 1'b0 ;
    assign hilowe = (mthi||mtlo)? 1'b1 : 1'b0 ;
    assign hilo_A3 = (mthi)? 1'b0 :
                     (mtlo)? 1'b1 : 0 ;
    assign stall_busy = mthi||mtlo||mfhi||mflo||multu||mult||divu||div ;
    assign re_hi_loop = (mfhi)? 2'b1 :
                            (mflo)? 2'b10 : 0 ;
endmodule 
// wire beq ;
//     wire jal ;
//     wire addu ;
//     wire subu ;
//     wire ori ;
//     wire lw ;
//     wire sw ;
//     wire lui ;
//     wire jr ;
