//ALU.v
`include "define.v"
module ALU (ck, res, L,R, OP, O);
    input ck, res;
    input [15:0] L,R;
    input [3:0] OP;
    output[15:0] O;

    reg [15:0] O;

    always @(posedge ck or posedge res) begin
        if( res )begin
            O <= 16'hzzzz;
        end
        else begin
            case (OP)
                `OP_ADD: O <= L + R;
                `OP_SUB: O <= L - R;
                `OP_AND: O <= L & R;
                `OP_OR: O <= L | R;
                `OP_XOR: O <= L ^ R;   
                `OP_LOADI: O <= R;
                default: O <= 16'hzzzz;
            endcase
        end
    end
endmodule