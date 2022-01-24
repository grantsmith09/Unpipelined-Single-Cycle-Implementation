/* $Author: karu $ */
/* $LastChangedDate: 2009-03-04 23:09:45 -0600 (Wed, 04 Mar 2009) $ */
/* $Rev: 45 $ */
module proc (/*AUTOARG*/
   // Outputs
   err, 
   // Inputs
   clk, rst
   );

   input clk;
   input rst;

   output err;

   // None of the above lines can be modified

   // OR all the err ouputs for every sub-module and assign it as this
   // err output
   
   // As desribed in the homeworks, use the err signal to trap corner
   // cases that you think are illegal in your statemachines

   wire [15:0] instr;
   wire [15:0] pc, next_pc;
   wire halt;

   wire [15:0] signExtend1, signExtend2, signExtend3;
   wire [15:0] zeroExtend1, zeroExtend2;
   wire SignExtend;
   wire [15:0] A, B;
   wire [1:0] ALUSrc;
   wire invA, invB, Cin;

   wire [15:0] ALURes;
   wire  JAL;

   wire [15:0] readdata, writedata;
   wire MemWrite;
   wire MemToReg;
   
   
   // Instruction Fetch Unit
   fetch fetch0(.pc(pc), .clk(clk), .rst(rst), .halt(halt), .instr(instr), .next_pc(next_pc));

   // Instruction Decode Unit
   decode decode0(.instr(instr), .clk(clk), .rst(rst), .writedata(writedata), .signExtend1(signExtend1), .signExtend2(signExtend2), .signExtend3(signExtend3), .zeroExtend1(zeroExtend1), .zeroExtend2(zeroExtend2), .SignExtend(SignExtend), .A(A), .B(B), .ALUSrc(ALUSrc), .MemWrite(MemWrite), .MemToReg(MemToReg), .invA(invA), .invB(invB), .Cin(Cin), .halt(halt), .err(decode_err));
   // Execute Unit
   execute execute0(.instr(instr), .A(A), .B(B), .next_pc(next_pc), .signExtend1(signExtend1), .signExtend2(signExtend2), .signExtend3(signExtend3), .zeroExtend1(zeroExtend1), .zeroExtend2(zeroExtend2), .SignExtend(SignExtend), .ALUSrc(ALUSrc), .invA(invA), .invB(invB), .Cin(Cin), .ALURes(ALURes), .pc(pc), .JAL(JAL));
   // Memory Unit
    memory memory0(.writedata(B), .ALURes(ALURes), .MemRead(MemToReg), .MemWrite(MemWrite), .halt(halt), .clk(clk), .rst(rst), .readdata(readdata));
   // Writeback Unit
   WB WB0(.ALURes(ALURes), .readdata(readdata), .next_pc(next_pc), .JAL(JAL), .MemToReg(MemToReg), .writedata(writedata));
   
endmodule // proc
// DUMMY LINE FOR REV CONTROL :0:
