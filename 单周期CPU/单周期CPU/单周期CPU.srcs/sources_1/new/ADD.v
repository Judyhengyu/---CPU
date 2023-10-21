module ADD(
    input wire[31:0] a,
    input wire[31:0] b,
    output wire[31:0] ans
);
    assign ans = a+b;
endmodule