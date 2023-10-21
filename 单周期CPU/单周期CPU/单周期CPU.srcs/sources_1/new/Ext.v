module Ext(
    input [31:0] DataIn,
    input [1:0]ExtOp,
    output reg[31:0] DataOut
    );
    always@(*)
        begin
            case(ExtOp)
                2'b00:DataOut = {{20{DataIn[21]}},DataIn[21:10]};//对ADDI.W, LD.W, ST.W指令中的12位立即数进行符号位扩展 
                2'b01:DataOut = {{14{DataIn[25]}},2'b0,{DataIn[25:10]}};//对BEQ,BLT指令中的立即数进行符号位扩展及其他部分的拼接
                2'b10:DataOut = {{12{DataIn[24]}},DataIn[24:5]};// 对LUI12I.W指令中的20位立即数高12位补0
                2'b11:DataOut = {{4{DataIn[25]}},2'b0,DataIn[9:0],DataIn[25:10]};//对B指令中的立即数进行符号位扩展及其他部分的拼接
                default: DataOut = 32'b0;
            endcase
    end
endmodule