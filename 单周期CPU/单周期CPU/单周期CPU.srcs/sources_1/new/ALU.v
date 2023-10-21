module ALU(
    input[31:0] a,
    input[31:0] b,
    input[2:0]AluCtrl,//һ����8�����㷽������Ҫ3λ������
    output wire Zero,//����Ƿ�Ϊ0����Ϊ1����Ϊ0
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
            3'b101: AluResult = ($signed(a) < $signed(b)) ? 32'h1 : 32'h0; // ���������Ƚ�
            3'b110: AluResult = (a < b) ? 32'h1 : 32'h0; // �޷������Ƚ�
            3'b111: AluResult = b;
            default:
            begin
                AluResult = 32'h00000000;
            end
        endcase
    end
    assign Zero = (AluResult == 0)?1:0;
endmodule