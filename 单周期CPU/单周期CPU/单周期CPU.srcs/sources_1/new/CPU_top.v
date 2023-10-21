module CPU_top(
    input clk,input rst,
    output wire [31:0] Instr,                       //ROM�����Instr
    output wire [31:0] mux_pc_ans,                  //Mux_PC�����muxPcAns
    output wire [31:0]PCout,                        //PC�����PCout
    output wire [31:0]adder_ans,                    //ADD�����adder_ans
    output wire srcReg,                             //Control��mux1�����ź�srcReg
    output wire RegWr,                              //Control��muxRegisters�����ź�RegWr
    output wire [1:0] ExtOp,                        //Control��mux1�����ź�ExtOp
    output wire ALUBSrc,                            //Control��mux1�����ź�ALUBSrc
    output wire [2:0] ALUCtrl,                      //Control��mux1�����ź�ALUCtrl
    output wire MemWrEn,                            //Control��mux1�����ź�MemWrEn
    output wire MemToReg,                           //Control��mux1�����ź�MemToReg   
    output wire Br,                                 //Control����������ת�ź�Br
    output wire Br_E_L,                             //Control��������ת�ź�Br_E_L
    output wire [4:0]mux1_ans,                      //mux1�����(5λ)
    output wire [31:0] busA,output wire [31:0] busB,//Registers�����
    output wire [31:0] imm,                         //Ext�����
    output wire [31:0] mux2_ans,                    //mux2�����(32λ)
    output wire Zero,output wire [31:0] AluResult, //ALU�����Zero,Sign��AluResult       
    output wire [31:0] data_out,                    //DataRAM�����data_out
    output wire [31:0] mux3_ans                     //mux3�����(32λ)
);
    //������
    Control control(.op(Instr[31:26]),.fun1(Instr[25:22]),.fun2(Instr[21:15]),.Zero(Zero),.srcReg(srcReg),.RegWr(RegWr),.ExtOp(ExtOp),.ALUBSrc(ALUBSrc),.ALUCtrl(ALUCtrl),.MemWrEn(MemWrEn),.MemToReg(MemToReg),.Br(Br),.Br_E_L(Br_E_L));
    PC pc(.clk(clk),.rst(rst),.PCin(adder_ans),.PCout(PCout));//PC
    ROM rom(.addr(PCout),.data_out(Instr));//ָ��洢��
    ADD add(.a(mux_pc_ans),.b(PCout),.ans(adder_ans));//�ӷ���
    Mux_PC mux_pc(.Br(Br),.Br_E_L(Br_E_L),.data_in(imm),.ans(mux_pc_ans));//�ź�ѡ����
    Mux_5bit mux1(.a(Instr[14:10]),.b(Instr[4:0]),.srcReg(srcReg),.result(mux1_ans));//2ѡ1ѡ����1
    Mux_32bit mux2(.a(busB),.b(imm),.ALUBSrc(ALUBSrc),.result(mux2_ans));//2ѡ1ѡ����2
    Mux_32bit mux3(.a(AluResult),.b(data_out),.ALUBSrc(MemToReg),.result(mux3_ans));//2ѡ1ѡ����3
    Registers registers(.busW(mux3_ans),.clk(clk),.RegWr(RegWr),.Ra(Instr[9:5]),.Rb(mux1_ans),.Rw(Instr[4:0]),.busA(busA),.busB(busB));//�Ĵ���
    Ext ext(.DataIn(Instr),.ExtOp(ExtOp),.DataOut(imm));//��������չ
    ALU alu(.a(busA),.b(mux2_ans),.AluCtrl(ALUCtrl),.Zero(Zero),.AluResult(AluResult));//������
    DataRAM dataRAM(.addr(AluResult),.data_in(busB),.clk(clk),.MemWrEn(MemWrEn),.data_out(data_out));//RAM�洢��
endmodule