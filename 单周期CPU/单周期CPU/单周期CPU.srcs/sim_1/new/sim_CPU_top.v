module sim_CPU_top;
    reg clk;
    reg rst;
    wire [31:0] Instr;
    wire [1:0] ExtOp;
    wire [2:0] ALUCtrl;
    wire srcReg, RegWr, ALUBSrc, MemWrEn, MemToReg,Br,Br_E_L;
    wire [4:0] mux1_ans;
    wire [31:0] busA;
    wire [31:0] busB;
    wire [31:0] imm;
    wire [31:0] mux2_ans;
    wire Zero;
    wire [31:0] AluResult;
    wire [31:0] data_out;
    wire [31:0] mux3_ans;
    CPU_top uut(.Instr(Instr), .clk(clk),.rst(rst), .srcReg(srcReg), .RegWr(RegWr),
          .ExtOp(ExtOp), .ALUBSrc(ALUBSrc), .ALUCtrl(ALUCtrl), .MemWrEn(MemWrEn),
          .MemToReg(MemToReg),.Br(Br),.Br_E_L(Br_E_L),.mux1_ans(mux1_ans), .busA(busA), .busB(busB),
          .imm(imm), .mux2_ans(mux2_ans),.Zero(Zero),.AluResult(AluResult),
          .data_out(data_out), .mux3_ans(mux3_ans));
//    initial begin
//        clk = 1;
//        rst = 1;
//        Instr = 32'b000101_000000000000000000011_00001;
//        #200;
//        Instr = 32'b000101_000000000000000000100_00010;
//        #200;
//        Instr = 32'b000000_0000_0100000_00010_00001_00011;
//        #200;
//        Instr = 32'b000000_0000_0100100_00010_00001_00100;
//        #200;
        //slt.w
//        clk = 1;
//        Instr = 32'b000101_010000000000000010001_00001;
//        #200;
//        Instr = 32'b000101_000000000000000000001_00010;
//        #200;
//        Instr = 32'b000000_0000_0100000_00001_00010_00011;
//        #200;
//        Instr = 32'b000000_0000_0100101_00010_00001_00100;
//        #200;
        //ld.wºÍst.w
//        clk = 1;
//        Instr = 32'b000101_000000000000000000011_00001;
//        #200;
//        Instr = 32'b000101_000000000000000000100_00010;
//        #200;
//        Instr = 32'b001010_0110_000000000010_00001_00010;
//        #200;
//        Instr = 32'b001010_0010_000000000010_00001_00010;
//        #200;  
//    end
    initial begin
        clk = 0;
        rst = 0;
    end
    always #70 rst = 1;
    always #50 clk = ~clk;
endmodule
