module Control(
    input wire [5:0] op,
    input wire [3:0] fun1,
    input wire [6:0] fun2,
    input wire Zero,
    output wire srcReg,RegWr,ALUBSrc,MemWrEn,MemToReg,Br,Br_E_L,
    output wire [1:0] ExtOp,
    output wire [2:0] ALUCtrl
    );
    reg [11:0] controls;
    assign {srcReg,RegWr,ExtOp,ALUBSrc,ALUCtrl,MemWrEn,MemToReg,Br,Br_E_L} = controls;
    always@(*)
    begin
        case(op)
            6'b000000:begin
                case(fun1)
                    4'b0000:begin
                        case(fun2)
                            7'b0100000: controls <= 12'b010000000000;//add.w 加法
                            7'b0100010: controls <= 12'b010000010000;//sub.w 减法
                            7'b0101001: controls <= 12'b010000100000;//and   与
                            7'b0101010: controls <= 12'b010000110000;//or    或
                            7'b0101000: controls <= 12'b010001000000;//nor   或非
                            7'b0100100: controls <= 12'b010001010000;//sltu 无符号数比较
                            7'b0100101: controls <= 12'b010001100000;//slt  有符号数比较
                        endcase
                    end
                    4'b1010: controls <= 12'b110010000000;//addi.w 立即数加法
                endcase
            end
            6'b001010:begin
                case(fun1)
                    4'b0010: controls <= 12'b110010000100;//ld.w
                    4'b0110: controls <= 12'b100010001000;//st.w
                endcase
            end
            6'b000101:begin
                case(fun1[3])
                    1'b0: controls <= 12'b111011110000;//lu.w 置数
                endcase
            end
            6'b010100: controls <= 12'b00_11_0_000_0010;//b 无条件跳转指令
            6'b010110:begin
                case(Zero)//判断Zero如果相等 Zero为1
                    1'b1: controls <= 12'b10_01_00010001;//beq 判断相等条件跳转指令
                    1'b0: controls <= 12'b10_01_00010000;
                endcase
            end 
            6'b011000: begin
                case(Zero)//判断是否小于 如果小于Zero为0
                    1'b0: controls <= 12'b10_01_01010001;//blt 判断小于条件跳转指令
                    1'b1: controls <= 12'b10_01_01010000;
                endcase
            end
        endcase
    end
endmodule
