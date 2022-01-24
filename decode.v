module decode(instr, clk, rst, writedata, signExtend1, signExtend2, signExtend3, zeroExtend1, zeroExtend2, SignExtend, A, B, ALUSrc, MemWrite, MemToReg, invA, invB, Cin, halt, err);

    input [15:0] instr, writedata;
    input clk, rst;

    output [15:0] signExtend1, signExtend2, signExtend3;
    output [15:0] zeroExtend1, zeroExtend2;
    output SignExtend;
    output [15:0] A, B;
    output [1:0] ALUSrc;
    output MemWrite, MemToReg;
    output invA, invB, Cin;
    output halt;
    output err;

    wire [2:0] writeregsel;
    wire [1:0] RegDst;

     // Sign Extend based on instr[4:0]
     assign signExtend1 = {{11{instr[4]}}, instr[4:0]};

     // Sign Extend based on instr[7:0]
     assign signExtend2 = {{8{instr[7]}}, instr[7:0]};

     // Sign Extend based on instr[10:0]
     assign signExtend3 = {{5{instr[10]}}, instr[10:0]};

     // Zero Extend based on instr[4:0]
     assign zeroExtend1 = {{11{1'b0}}, instr[4:0]};

     // Zero Extend based on instr[7:0]
     assign zeroExtend2 = {{8{1'b0}}, instr[7:0]};


    // Instantiate Control
    control ct1(.instr(instr), .ALUSrc(ALUSrc), .RegDst(RegDst), .RegWrite(RegWrite), .MemWrite(MemWrite), .MemToReg(MemToReg), .invA(invA), .invB(invB), .Cin(Cin), .SignExtend(SignExtend), .halt(halt));


    mux4_1_3 mux0(.in1(instr[4:2]), .in2(instr[7:5]), .in3(instr[10:8]), .in4(3'b111), .sel(RegDst), .Out(writeregsel));
    

    // Instantiate register file
    rf regFile0(.read1data(A), .read2data(B), .err(err), .clk(clk), .rst(rst), .read1regsel(instr[10:8]), .read2regsel(instr[7:5]), .writeregsel(writeregsel), .writedata(writedata), .write(RegWrite));


endmodule 
