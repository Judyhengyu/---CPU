module Registers(
    input[31:0] busW,//初始为0,接受mux3_ans
    input clk,
    input RegWr,
    input[4:0] Ra,//是Instr[9:5]
    input[4:0] Rb,//是MUX选择后输入进来的
    input[4:0] Rw,//是Instr[4:0]
    output[31:0] busA,//32位数据输出信号
    output[31:0] busB//32位数据输出信号,要输出给下一个MUX
    );
    reg[31:0] registers[31:0];
    integer i;
    initial begin
        for(i = 0;i < 32;i = i + 1)
            registers[i] <= 0;
    end
    assign busA = (Ra == 0) ? 32'h0 : registers[Ra];
    assign busB = (Rb == 0) ? 32'h0 : registers[Rb];
    always @(posedge clk) begin
        if (RegWr && (Rw != 0))
            registers[Rw] <= busW;
    end
endmodule