module Mux_32bit(
    input wire [31:0] a,
    input wire [31:0] b,
    input wire ALUBSrc,
    output wire[31:0] result
    );
    assign result=(ALUBSrc==0)?a:b;
endmodule