module mux4_1_3(in1, in2, in3, in4, sel, Out);
        
	input [2:0] in1, in2, in3, in4;
	input [1:0] sel;
        output [2:0] Out;

        mux4_1 mux[2:0](.in1(in1), .in2(in2), .in3(in3), .in4(in4), .sel(sel), .Out(Out));

endmodule

