`define IM SR[15:10]
`define EXL SR[1]
`define IE SR[0]
`define BD Cause[31]
`define hwint_pend Cause[15:10]
`define ExcCode Cause[6:2]

module CP0 (
    input [4:0] A1,//read
    input [4:0] A2,//write
    input [31:0] in,
    input [31:0] pc,
    input [6:2] Exccode,
    input [5:0] HWInt,
    input we,
    input EXLClr,
    input clk,
    input reset,
    input bd,
	 output is_write,
    output req,
    output [31:0] epc,
    output [31:0] out
);
	 reg reg_is_write ;
    reg [31:0] SR ;
    reg [31:0] EPC ;
    reg [31:0] Cause ;
    reg [31:0] PRld ;
    wire [31:0] temppc ;
    wire Intreq ;
    wire Excreq ;
    assign Intreq = (|(HWInt & `IM)) & (!`EXL) & `IE ;
    assign Excreq = (|Exccode) & (!`EXL) ;
    assign req = Excreq | Intreq ;
    assign temppc = (bd == 1)? {pc[31:2]-1,2'b0} : {pc[31:2], 2'b0} ;
    always @(posedge clk) begin
        if (reset == 1) begin
            SR <= 0 ;
            EPC <= 0 ;
            Cause <= 0 ;
            PRld <= 0 ;
				reg_is_write <= 0 ;
        end
        else begin
            if (we == 1) begin
                if (A2 == 12) SR <= in ;
                if (A2 == 13) Cause <= in ;
                if (A2 == 14) EPC <= in ;
            end
            if (EXLClr == 1) `EXL <= 0 ;
            if (req) begin
                `ExcCode <= Intreq? 5'b0 : Exccode ;
                `EXL <= 1'b1 ;
                 EPC <= temppc ;
                `BD <= bd ;
            end
            `hwint_pend <= HWInt ;
        end
		  if (Intreq == 1 && HWInt[2]) reg_is_write <= 1 ;
		  else reg_is_write <= 0 ;
    end 
    assign out = (A1 == 12)? SR :
                 (A1 == 13)? Cause :
                 (A1 == 14)? EPC : 0 ;
    assign epc = EPC ;
	 assign is_write = reg_is_write ;
endmodule 


