module adven (
    input [1:0] D_rs_Tuse,
    input [1:0] D_rt_Tuse,
    input [4:0] D_rsad,
    input [4:0] D_rtad,
    input [1:0] E_rs_Tuse,
    input [1:0] E_rt_Tuse,
    input [1:0] E_Tnew,
    input [4:0] E_rsad,
    input [4:0] E_rtad,
    input [4:0] E_A3,
    input E_regwe,
    input [1:0] M_rs_Tuse,
    input [1:0] M_rt_Tuse,
    input [1:0] M_Tnew,
    input [4:0] M_rsad,
    input [4:0] M_rtad,
    input [4:0] M_A3,
    input M_regwe,
    input [4:0] W_A3,
    input W_regwe,
    output [1:0] D_rsop,
    output [1:0] D_rtop,
    output [1:0] E_rsop,
    output [1:0] E_rtop,
    output [1:0] M_swop,
    output stall
);
    wire stallrs ;
    wire stallrt ;
    assign D_rsop = (E_regwe == 1 && E_A3 == D_rsad && E_A3 != 0 && D_rs_Tuse == 0)? 1 :
                    (M_regwe == 1 && M_A3 == D_rsad && M_A3 != 0 && D_rs_Tuse == 0)?  2 :
                    (W_regwe == 1 && W_A3 == D_rsad && W_A3 != 0)? 3 : 0 ;

    assign D_rtop = (E_regwe == 1 && E_A3 == D_rtad && E_A3 != 0 && D_rt_Tuse == 0)? 1 :
                    (M_regwe == 1 && M_A3 == D_rtad && M_A3 != 0 && D_rt_Tuse == 0)?  2 :
                    (W_regwe == 1 && W_A3 == D_rtad && W_A3 != 0)? 3 : 0 ;


    assign E_rsop = (M_regwe == 1 && M_A3 == E_rsad && M_A3 != 0 && E_rs_Tuse == 1)? 1 :
                    (W_regwe == 1 && W_A3 == E_rsad && W_A3 != 0)? 2 : 0 ;

    assign E_rtop = (M_regwe == 1 && M_A3 == E_rtad && M_A3 != 0 && E_rt_Tuse == 1)? 1 :
                    (W_regwe == 1 && W_A3 == E_rtad && W_A3 != 0)? 2 : 0 ;


    assign M_swop = (W_regwe == 1 && W_A3 == M_rtad && W_A3 != 0)? 1 : 0 ;

    assign stallrs = (D_rsad == E_A3 && E_A3 != 0 && E_regwe == 1 && D_rs_Tuse < E_Tnew)?  1 :
                     (D_rsad == E_A3 && E_A3 != 0 && E_regwe == 1 && D_rs_Tuse >= E_Tnew)? 0 :
                     (D_rsad == M_A3 && M_A3 != 0 && M_regwe == 1 && D_rs_Tuse < M_Tnew)? 1 : 0 ;
    assign stallrt = (D_rtad == E_A3 && E_A3 != 0 && E_regwe == 1 && D_rt_Tuse < E_Tnew)?  1 :
                     (D_rtad == E_A3 && E_A3 != 0 && E_regwe == 1 && D_rt_Tuse >= E_Tnew)? 0 :
                     (D_rtad == M_A3 && M_A3 != 0 && M_regwe == 1 && D_rt_Tuse < M_Tnew)? 1 : 0 ;
    assign stall = stallrs||stallrt ;
endmodule //adven