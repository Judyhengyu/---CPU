module PC(
    input wire clk,
    input wire rst,
    input wire [31:0] PCin,
    output reg [31:0] PCout
);
    always@(posedge clk)
        begin
            if(rst==0)
                begin
                    PCout <= 32'b0;
                end
            else
                begin
                    PCout <= PCin;
                end
        end
endmodule