//decoder.v //Ferdi Rizaldi Rangkuti
`include "define.v"
module decoder(ck, res, INST, OP, LSEL, RSEL, OSEL, LOUT, ROUT, OIN, R);
    input ck, res;
    input[15:0] INST;
    
    output LOUT, ROUT, OIN;
    output[2:0] LSEL, RSEL, OSEL;
    output[15:0] R;
    output[3:0] OP;

    reg LOUT, ROUT, OIN;
    reg[2:0] LSEL, RSEL, OSEL;
    reg[15:0] R;
    reg[3:0] OP;

    always @(posedge ck or posedge res) begin
        if(res) begin
            R <= 16'hzzzz;
            OP <= 0;
            LSEL <= 0;
            LOUT <= 0;
            RSEL <= 0;
            ROUT <= 0;
            OSEL <= 0;
            OIN <= 0;
        end else begin
            if(INST[15:12]==`OP_ADD||INST[15:12]== `OP_SUB||INST[15:12]== `OP_AND||INST[15:12]==`OP_OR||INST[15:12]== `OP_XOR) begin
                OP <= INST[15:12];
                LSEL <= INST[8:6];
                LOUT <= 1;
                RSEL <= INST[5:3];
                ROUT <= 1;
                OSEL <= INST[11:9];
                OIN <= 1;
                R <= 16'hzzzz;
            end else if(INST[15:12]==`OP_LOADI) begin
                OP <= INST[15:12];
                OSEL <= INST[11:9];
                OIN <= 1;
                LOUT <= 0;
                ROUT <= 0;
                R <= {7'h00,INST[8:0]};
            end
        end  
    end

endmodule