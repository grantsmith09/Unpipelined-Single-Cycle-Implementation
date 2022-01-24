module alu(A, B, opcode, twoLSB, invA, invB, Cin, ALUOut, Zero, Pos, Neg);

   input [15:0] A, B;
   input [4:0] opcode;
   input [1:0] twoLSB;
   input invA, invB, Cin;

   output reg [15:0] ALUOut;
   output Zero, Pos, Neg;

   wire [15:0] signedA, signedB, ALU_ADD, ALUOut_arithmetic, BTROut;
   wire g;

   // Invert inputs to ALU?
   assign signedA = (invA) ? ~A : A;
   assign signedB = (invB) ? ~B : B;

   // CLA for add operation
   cla_16 cla1(.A(signedA), .B(signedB), .Cin(Cin), .sum(ALU_ADD), .Cout(), .Pout(), .Gout(g));

   // Which arithmetic operation?
   mux4_1_16 mux0(.in1(ALU_ADD), .in2(ALU_ADD), .in3(signedA^signedB), .in4(signedA&signedB), .sel(twoLSB), .Out(ALUOut_arithmetic));

   // BTR (Bit Test and Rotate)
   BTR btr1(.Out(BTROut), .In(A));

   // Flag Assignment (Zero, Pos, Neg)
   assign Zero = (ALU_ADD == 16'h0000) ? 1'b1 : 1'b0;
   assign Neg = (ALU_ADD[15] & ~Zero);
   assign Pos = ~(ALU_ADD[15] | Zero);


/***************************************************
       Shift/Rotate Operations
***************************************************/
wire [15:0] shift1out;
wire [15:0] shift2out;

shifter shifter0 (.In(signedA), .Cnt(signedB[3:0]), .Op(opcode[1:0]), .Out(shift1out));
shifter shifter1 (.In(signedA), .Cnt(signedB[3:0]), .Op(twoLSB[1:0]), .Out(shift2out));

always @(*) begin 
 	ALUOut = 16'hXXXX;

	   case(opcode)

	      5'b00000: begin // Halt
              end

              5'b00001: begin // NOP
	      end
     
 	      5'b01000: begin // ADDI
		 ALUOut = ALU_ADD;
 	      end

      	      5'b01001: begin // SUBI
		 ALUOut = ALU_ADD;
              end

      	      5'b01010: begin // XORI
	 	 ALUOut = signedA ^ signedB;
              end

     	      5'b01011: begin // ANDNI
		 ALUOut = signedA & signedB;
              end

      	      5'b10100: begin // ROLI
		 ALUOut = shift1out;
              end

      	      5'b10101: begin // SLLI
		 ALUOut = shift1out;
              end

    	      5'b10110: begin // RORI
		 ALUOut = shift1out;
              end

     	      5'b10111: begin // SRLI
		 ALUOut = shift1out;
       	      end

      	      5'b10000: begin // ST
		 ALUOut = ALU_ADD;
              end

     	      5'b10001: begin // LD
		 ALUOut = ALU_ADD;
              end

      	      5'b10011: begin // STU
		 ALUOut = ALU_ADD;
	      end

     	      5'b11001: begin // BTR
		 ALUOut = BTROut;
              end

      	      5'b11011: begin // ADD, SUB, XOR, ANDN
		 ALUOut = ALUOut_arithmetic;
              end

      	      5'b11010: begin // ROL, SLL, ROR, SRL
		 ALUOut = shift2out;
       	      end

     	      5'b11100: begin // SEQ
		 ALUOut = (Zero) ? 16'h0001 : 16'h0000;
              end

     	      5'b11101: begin // SLT
		 ALUOut = ((A[15] & ~B[15])|(Neg & ~(A[15] ^ B[15]))) ? 16'h0001 : 16'h0000;
              end

     	      5'b11110: begin // SLE
		 ALUOut = (Zero|(A[15] & ~B[15])|(Neg & ~(A[15] ^ B[15]))) ? 16'h0001 : 16'h0000;
       	      end

     	      5'b11111: begin // SCO
		 ALUOut = (g) ? 16'h0001 : 16'h0000;
       	      end

     	      5'b01100: begin // BEQZ
		 ALUOut = ALU_ADD;
              end

      	      5'b01101: begin // BNEZ
		 ALUOut = ALU_ADD;
       	      end

      	      5'b01110: begin // BLTZ
		 ALUOut = ALU_ADD;
       	      end

     	      5'b01111: begin // BGEZ
		 ALUOut = ALU_ADD;
              end

      	      5'b11000: begin // LBI
		 ALUOut = B;
       	      end

     	      5'b10010: begin // SLBI
		 ALUOut = ((A << 8) | B);
              end

      	      5'b00100: begin // J
		 ALUOut = ALU_ADD;
       	      end

      	      5'b00101: begin // JR
		 ALUOut = ALU_ADD;
    	      end

     	      5'b00110: begin // JAL
		 ALUOut = ALU_ADD;
       	      end

      	      5'b00111: begin // JALR
		 ALUOut = ALU_ADD;
              end

              5'b00010: begin // siic

              end

     	      5'b00011: begin // NOP / RTI

       	      end
	      
              default: begin
              end
         endcase
       end

endmodule
