//Regfile.v Ferdi Rangkuti B233378
 
module regfile (ck, res, O, LSEL, LOUT, RSEL, ROUT, OSEL, OIN, L, R);

input ck, res;
input LOUT, ROUT, OIN;
input [2:0] LSEL,RSEL,OSEL;
input [15:0] O;

output[15:0] L, R;

reg [15:0] r0,r1,r2,r3,r4,r5,r6,r7;
reg [15:0] L, R;

always @(posedge ck or posedge res) begin
    if (res) begin
        r0 <= 16'h0;
        r1 <= 16'h0;
        r2 <= 16'h0;
        r3 <= 16'h0;
        r4 <= 16'h0;
        r5 <= 16'h0;
        r6 <= 16'h0;
        r7 <= 16'h0;
        L <= 16'hzzzz;
        R <= 16'hzzzz;
    end else begin
        if(LOUT) begin
            case(LSEL)
                3'd0: L <= r0;
                3'd1: L <= r1;
                3'd2: L <= r2;
                3'd3: L <= r3;
                3'd4: L <= r4;
                3'd5: L <= r5;
                3'd6: L <= r6;
                3'd7: L <= r7;
            endcase
        end else begin
            L <= 16'hzzzz;
        end

        if(ROUT) begin
            case(RSEL)
                3'd0: R <= r0;
                3'd1: R <= r1;
                3'd2: R <= r2;
                3'd3: R <= r3;
                3'd4: R <= r4;
                3'd5: R <= r5;
                3'd6: R <= r6;
                3'd7: R <= r7;
            endcase
        end else begin
            R <= 16'hzzzz;
        end

        if(OIN) begin
            case(OSEL)
                3'd0: r0 <= O;
                3'd1: r1 <= O;
                3'd2: r2 <= O;
                3'd3: r3 <= O;
                3'd4: r4 <= O;
                3'd5: r5 <= O;
                3'd6: r6 <= O;
                3'd7: r7 <= O;
            endcase
        end
    end
end

endmodule