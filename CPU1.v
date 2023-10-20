//CPU1.v Ferdi Rizaldi Rangkuti
`include "decoder.v"
`include "ALU.v"
`include "regfile.v"

module CPU1(ck,res, INST);
    input ck, res;
    input[15:0] INST;

    wire[3:0] op;
    wire lout,rout,oin;
    wire[2:0] lsel, rsel, osel;
    wire[15:0] rbus,lbus,obus;
    
    reg[2:0] cpu_state;

    wire dec_oin;
    wire reg_oin;

    parameter CPU_STATE_IF = 3'h0;
    parameter CPU_STATE_ID = 3'h1;
    parameter CPU_STATE_REG = 3'h2;
    parameter CPU_STATE_EX = 3'h3;
    parameter CPU_STATE_WB = 3'h4;
    
    decoder decoder(
        .ck(ck), 
        .res(res), 
        .INST(INST), 
        .OP(op), 
        .LSEL(lsel), 
        .RSEL(rsel), 
        .OSEL(osel), 
        .LOUT(lout), 
        .ROUT(rout), 
        .OIN(dec_oin), 
        .R(rbus)
    );

    regfile register(
        .ck(ck),
        .res(res),
        .O(obus),
        .LSEL(lsel),
        .LOUT(lout),
        .RSEL(rsel),
        .ROUT(rout),
        .OSEL(osel),
        .OIN(reg_oin),
        .L(lbus),
        .R(rbus)
    );

    ALU ALU(
        .ck(ck),
        .res(res),

        .L(lbus),
        .R(rbus),
        .OP(op),
        .O(obus)
    );
    assign reg_oin = (cpu_state == CPU_STATE_WB)?dec_oin:1'b0;
    
    
    always @(posedge ck or posedge res)begin
        if(res) begin
            cpu_state <= 3'h0;
        end else begin 
            if(cpu_state== CPU_STATE_IF)begin
                cpu_state <= CPU_STATE_ID;
            end if(cpu_state== CPU_STATE_ID)begin
                cpu_state <= CPU_STATE_REG;
            end if(cpu_state== CPU_STATE_REG)begin
                cpu_state <= CPU_STATE_EX;
            end if(cpu_state== CPU_STATE_EX)begin
                cpu_state <= CPU_STATE_WB;
            end if(cpu_state== CPU_STATE_WB)begin
                cpu_state <= CPU_STATE_IF;
            end
        end
    end
endmodule

