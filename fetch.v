module fetch(pc, clk, rst, halt, instr, next_pc);

  input [15:0] pc;
  input clk, rst;
  input halt;

  output [15:0] next_pc;
  output [15:0] instr;

  wire [15:0] pc_temp; // intermediate value of pc before it is added by 2


  // PC Register
  register pc_register(.writedata(pc), .write(~halt), .readdata(pc_temp), .clk(clk), .rst(rst));

  // INSTRUCTION MEMORY
  memory2c instrMem(.data_out(instr), .data_in(16'h0000), .addr(pc_temp), .enable(1'b1), .wr(1'b0), .createdump(halt), .clk(clk), .rst(rst));

  //add 2 to pc the get the next_pc
  cla_16 nextPC(.A(pc_temp), .B(16'h0002), .Cin(1'b0), .sum(next_pc), .Cout(), .Pout(), .Gout());

endmodule

