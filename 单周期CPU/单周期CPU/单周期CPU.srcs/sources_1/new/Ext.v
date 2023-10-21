module Ext(
    input [31:0] DataIn,
    input [1:0]ExtOp,
    output reg[31:0] DataOut
    );
    always@(*)
        begin
            case(ExtOp)
                2'b00:DataOut = {{20{DataIn[21]}},DataIn[21:10]};//��ADDI.W, LD.W, ST.Wָ���е�12λ���������з���λ��չ 
                2'b01:DataOut = {{14{DataIn[25]}},2'b0,{DataIn[25:10]}};//��BEQ,BLTָ���е����������з���λ��չ���������ֵ�ƴ��
                2'b10:DataOut = {{12{DataIn[24]}},DataIn[24:5]};// ��LUI12I.Wָ���е�20λ��������12λ��0
                2'b11:DataOut = {{4{DataIn[25]}},2'b0,DataIn[9:0],DataIn[25:10]};//��Bָ���е����������з���λ��չ���������ֵ�ƴ��
                default: DataOut = 32'b0;
            endcase
    end
endmodule