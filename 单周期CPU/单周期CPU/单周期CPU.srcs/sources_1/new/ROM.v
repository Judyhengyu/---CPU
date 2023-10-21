module ROM(
    input wire[31:0] addr,
    output reg[31:0] data_out
    );
    reg [31:0] rom[127:0];
    initial
        begin
//            $readmemb("C:/Users/Judy/Desktop/CPU/design/program.txt",rom);
//            $readmemb("../../../../program1.txt",rom);
            $readmemb("../../../../program2.txt",rom);
            data_out=0;
        end
    always@(*)
        begin
            data_out <= rom[addr];
        end
endmodule