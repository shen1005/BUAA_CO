`include "define.v"
module control (
    input [5:0] op,
    input [5:0] func,
    output [3:0] ALUop,
    output [2:0] EXTop,
    output is_j ,
    output is_b ,
    output is_jr , 
    output regwe ,
    output memse, 
    output [1:0] A3op,
    output [1:0] regwdop,
    output  ALUrt_or_immop,
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
    assign ALUop = (addu||lw||sw)? `ALUadd :
                    (subu||beq)? `ALUsub :
                    (lui)? `ALUadd0 :
                    (ori)? `ALUor : 0 ;
    assign EXTop = (ori)? `EXTzero :
                    (lw||sw)? `EXTsign :
                    (lui)? `EXTlui : 0 ;
    assign is_j = (jal||j)? 1 : 0 ;
    assign is_b = (beq)? 1 : 0 ;
    assign is_jr = (jr)? 1 : 0 ;
    assign regwe = jal||addu||subu||ori||lw||lui ;
    assign memse = sw ;
    assign A3op = (jal)? 2'b10 :
                  (addu||subu)? 2'b01 :
                  2'b00 ;
    assign regwdop = (jal)? 2'b10 :
                     (addu||subu||ori||lui)? 2'b00 :
                     2'b01 ;
    assign ALUrt_or_immop = (beq||addu||subu)? 1'b0 : 1'b1 ;
    assign D_rs_Tuse = (beq||jr)? 0 : 
                       (addu||subu||ori||sw)? 1 : 3 ;
    assign D_rt_Tuse = (beq)? 0 :
                        (addu||subu)? 1 :
                        (sw)? 2 : 3 ;
    assign D_Tnew = (addu||subu||ori)? 1 :
                    (jal)? 0 :
                    (lw)? 2 : 0 ;
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
