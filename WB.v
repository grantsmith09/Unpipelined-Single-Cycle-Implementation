module WB(ALURes, readdata, next_pc, JAL, MemToReg, writedata);

  input [15:0] ALURes;
  input [15:0] readdata;
  input [15:0] next_pc;
  input JAL;
  input MemToReg;


  output [15:0] writedata;

  mux4_1_16 wbmux(.in1(ALURes), .in2(readdata), .in3(next_pc), .in4(16'hxxxx), .sel({JAL, MemToReg}), .Out(writedata));
endmodule
