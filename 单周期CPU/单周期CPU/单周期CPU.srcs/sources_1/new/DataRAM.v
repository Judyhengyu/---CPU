module DataRAM(
    input[31:0] addr,
    input[31:0] data_in,
    input clk,
    input MemWrEn,
    output reg[31:0] data_out
    );
    reg[31:0] mem[0:1023];
    always@(posedge clk)
    begin
        if(MemWrEn)
            mem[addr] <= data_in;
    end
    always@(*)
    begin
        if(!MemWrEn)
            data_out <= mem[addr];
    end
endmodule