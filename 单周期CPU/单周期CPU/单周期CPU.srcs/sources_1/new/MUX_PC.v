module Mux_PC(
    input wire Br,
    input wire Br_E_L,
    input wire[31:0] data_in,
    output reg [31:0] ans 
);
    always@(*)
        begin
    //        if(Br || (Br_E_L&&Zero))
            if(Br || Br_E_L)
                ans <= data_in;
            else
                ans=32'b00000000000000000000000000000001;
        end
endmodule