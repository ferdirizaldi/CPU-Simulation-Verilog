`timescale 1ps/1ps
`include "define.v"

`define REG_R1 3'h1
`define REG_R2 3'h2
`define REG_R3 3'h3

module CPU1_tp;

reg ck,res;
reg[15:0] INST;

parameter STEP = 1000000;

CPU1 CPU1(ck, res, INST);

always begin
    ck = 0; #(STEP/2);
    ck = 1; #(STEP/2);
end

initial begin
    $dumpfile("CPU1.vcd");
    $dumpvars(0, CPU1_tp);

        res=1;
    // load 5 to the register h1
    #(STEP*5) res =0 ;INST = {`OP_LOADI, `REG_R1, 9'h5};
    // load 3 to the register h1
    #(STEP*5) INST = {`OP_LOADI, `REG_R2, 9'h3};
    // add r1 and r2 and write it back to r3
    #(STEP*5) INST = {`OP_ADD, `REG_R3, `REG_R1, `REG_R2, 3'h0};
    // add r1 and r2 and write it back to r3
    #(STEP*5) INST = {`OP_SUB, `REG_R3, `REG_R3, `REG_R1, 3'h0};
    #(STEP*5) $finish;
end 

initial $monitor ($time, "ck=%b, res=%b,INST=%h",ck,res,INST);


endmodule


