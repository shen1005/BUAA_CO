module mux3_1 (
    input [4:0]in00,
    input [4:0]in01,
    input [4:0]in10,
    input [1:0] select,
    output [4:0] out 
);
    assign out = (select == 0)? in00 :
                (select == 1)? in01 :
                (select == 2'b10)? in10 : 0 ;
endmodule 