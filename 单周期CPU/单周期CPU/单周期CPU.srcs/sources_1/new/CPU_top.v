module CPU_top(
    input clk,input rst,
    output wire [31:0] Instr,                       //ROM的输出Instr
    output wire [31:0] mux_pc_ans,                  //Mux_PC的输出muxPcAns
    output wire [31:0]PCout,                        //PC的输出PCout
    output wire [31:0]adder_ans,                    //ADD的输出adder_ans
    output wire srcReg,                             //Control的mux1控制信号srcReg
    output wire RegWr,                              //Control的muxRegisters控制信号RegWr
    output wire [1:0] ExtOp,                        //Control的mux1控制信号ExtOp
    output wire ALUBSrc,                            //Control的mux1控制信号ALUBSrc
    output wire [2:0] ALUCtrl,                      //Control的mux1控制信号ALUCtrl
    output wire MemWrEn,                            //Control的mux1控制信号MemWrEn
    output wire MemToReg,                           //Control的mux1控制信号MemToReg   
    output wire Br,                                 //Control的无条件跳转信号Br
    output wire Br_E_L,                             //Control的条件跳转信号Br_E_L
    output wire [4:0]mux1_ans,                      //mux1的输出(5位)
    output wire [31:0] busA,output wire [31:0] busB,//Registers的输出
    output wire [31:0] imm,                         //Ext的输出
    output wire [31:0] mux2_ans,                    //mux2的输出(32位)
    output wire Zero,output wire [31:0] AluResult, //ALU的输出Zero,Sign和AluResult       
    output wire [31:0] data_out,                    //DataRAM的输出data_out
    output wire [31:0] mux3_ans                     //mux3的输出(32位)
);
    //控制器
    Control control(.op(Instr[31:26]),.fun1(Instr[25:22]),.fun2(Instr[21:15]),.Zero(Zero),.srcReg(srcReg),.RegWr(RegWr),.ExtOp(ExtOp),.ALUBSrc(ALUBSrc),.ALUCtrl(ALUCtrl),.MemWrEn(MemWrEn),.MemToReg(MemToReg),.Br(Br),.Br_E_L(Br_E_L));
    PC pc(.clk(clk),.rst(rst),.PCin(adder_ans),.PCout(PCout));//PC
    ROM rom(.addr(PCout),.data_out(Instr));//指令存储器
    ADD add(.a(mux_pc_ans),.b(PCout),.ans(adder_ans));//加法器
    Mux_PC mux_pc(.Br(Br),.Br_E_L(Br_E_L),.data_in(imm),.ans(mux_pc_ans));//信号选择器
    Mux_5bit mux1(.a(Instr[14:10]),.b(Instr[4:0]),.srcReg(srcReg),.result(mux1_ans));//2选1选择器1
    Mux_32bit mux2(.a(busB),.b(imm),.ALUBSrc(ALUBSrc),.result(mux2_ans));//2选1选择器2
    Mux_32bit mux3(.a(AluResult),.b(data_out),.ALUBSrc(MemToReg),.result(mux3_ans));//2选1选择器3
    Registers registers(.busW(mux3_ans),.clk(clk),.RegWr(RegWr),.Ra(Instr[9:5]),.Rb(mux1_ans),.Rw(Instr[4:0]),.busA(busA),.busB(busB));//寄存器
    Ext ext(.DataIn(Instr),.ExtOp(ExtOp),.DataOut(imm));//立即数拓展
    ALU alu(.a(busA),.b(mux2_ans),.AluCtrl(ALUCtrl),.Zero(Zero),.AluResult(AluResult));//运算器
    DataRAM dataRAM(.addr(AluResult),.data_in(busB),.clk(clk),.MemWrEn(MemWrEn),.data_out(data_out));//RAM存储器
endmodule