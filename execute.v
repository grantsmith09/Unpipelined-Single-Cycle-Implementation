module execute(instr, A, B, next_pc, signExtend1, signExtend2, signExtend3, zeroExtend1, zeroExtend2, SignExtend, ALUSrc, invA, invB, Cin, ALURes, pc, JAL);

   input [15:0] instr;
   input [15:0] A, B, next_pc;
   input [15:0] signExtend1, signExtend2, signExtend3;
   input [15:0] zeroExtend1, zeroExtend2;
   input SignExtend;
   input [1:0] ALUSrc;
   input invA, invB, Cin;

   output [15:0] ALURes;
   output [15:0] pc;
   output JAL;

   wire [15:0] select5extension, select8extension;
   wire [15:0] Binput;
   wire Zero, Neg, Pos;
   wire branchsel;
   wire JMP, JR;
   wire [15:0] branchIncrement;
   wire [15:0] PCinc;
   wire [15:0] pc_temp1, pc_temp2, pc_temp3;

   assign select5extension = (SignExtend) ? signExtend1 : zeroExtend1;
   assign select8extension = (SignExtend) ? signExtend2 : zeroExtend2;

   mux4_1_16 mux0(.in1(B), .in2(select5extension), .in3(select8extension), .in4(16'h0000), .sel(ALUSrc), .Out(Binput));

   alu alu1(.A(A), .B(Binput), .opcode(instr[15:11]), .twoLSB(instr[1:0]), .invA(invA), .invB(invB), .Cin(Cin), .ALUOut(ALURes), .Zero(Zero), .Pos(Pos), .Neg(Neg));

   branch b1(.Zero(Zero), .Pos(Pos), .Neg(Neg), .opcode(instr[15:11]), .branchsel(branchsel));
   
   jump j1(.opcode(instr[15:11]), .JMP(JMP), .JR(JR), .JAL(JAL));

   assign branchIncrement = (branchsel) ? signExtend2 : 16'h0000;
   assign PCinc = (JMP) ? signExtend3 : branchIncrement;
   cla_16 cla1(.A(next_pc), .B(PCinc), .Cin(1'b0), .sum(pc_temp1), .Cout(), .Pout(), .Gout());
   cla_16 cla2(.A(A), .B(signExtend2), .Cin(1'b0), .sum(pc_temp2), .Cout(), .Pout(), .Gout());

   assign pc = JR ? pc_temp2 : pc_temp1;

endmodule





   
