module deal_instr (
    input [31:0] instr,
    output [5:0] op,
    output [5:0] func,
    output [4:0] rsad,
    output [4:0] rtad,
    output [4:0] rdad,
    output [15:0] imm16 ,
    output [25:0] imm26
);
    assign op = instr[31:26] ;
    assign rsad = instr[25:21] ;
    assign rtad = instr[20:16] ;
    assign rdad = instr[15:11] ;
    assign func = instr[5:0] ;
    assign imm16 =  instr[15:0] ;
    assign imm26 = instr[25:0] ;
endmodule 