module ALU(
    input[31:0] a,
    input[31:0] b,
    input[2:0]AluCtrl,//一共有8个运算方法，需要3位来控制
    output wire Zero,//结果是否为0？是为1，否为0
    output reg[31:0] AluResult
);
    always@(*)
    begin
        case(AluCtrl)
            3'b000: AluResult = a + b;
            3'b001: AluResult = a - b;
            3'b010: AluResult = a & b;
            3'b011: AluResult = a | b;
            3'b100: AluResult = ~( a | b );
//            3'b101:
//            begin
//                AluResult = (a<b)?32'h00000001:32'h00000000;
//            end
//            3'b110:
//            begin
//                if( a<b && a[31] == b[31]) AluResult = 32'h00000001;
//                else if(a[31] == 1 && b[31] == 0)AluResult = 32'h00000001;
//                else AluResult = 32'h00000000;
//            end  
            3'b101: AluResult = ($signed(a) < $signed(b)) ? 32'h1 : 32'h0; // 带符号数比较
            3'b110: AluResult = (a < b) ? 32'h1 : 32'h0; // 无符号数比较
            3'b111: AluResult = b;
            default:
            begin
                AluResult = 32'h00000000;
            end
        endcase
    end
    assign Zero = (AluResult == 0)?1:0;
endmodule