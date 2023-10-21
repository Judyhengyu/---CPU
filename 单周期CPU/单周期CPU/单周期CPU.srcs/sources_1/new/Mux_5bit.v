module Mux_5bit(
    input wire [4:0] a,
    input wire [4:0] b,
    input wire srcReg,
    output wire[4:0] result
    );
    assign result=(srcReg==0)?a:b;
endmodule