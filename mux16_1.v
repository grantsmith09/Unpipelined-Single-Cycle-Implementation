module mux16_1(Out, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, sel);

input [15:0] in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16; // Inputs to muxes
input [3:0] sel; // Select bits for muxes
output wire [15:0] Out; // Output to module, output of mux5 

wire [15:0] Out1, Out2, Out3, Out4; // Output to muxes

mux4_1 mux1(.Out(Out1), .in1(in1), .in2(in2), .in3(in3), .in4(in4), .sel(sel[1:0]));
mux4_1 mux2(.Out(Out2), .in1(in5), .in2(in6), .in3(in7), .in4(in8), .sel(sel[1:0]));
mux4_1 mux3(.Out(Out3), .in1(in9), .in2(in10), .in3(in11), .in4(in12), .sel(sel[1:0])); 
mux4_1 mux4(.Out(Out4), .in1(in13), .in2(in14), .in3(in15), .in4(in16), .sel(sel[1:0]));

// Outputs from the above (4) 4-to-1 muxes are the inputs to this (1) 4-to-1 mux
mux4_1 mux5(.Out(Out), .in1(Out1), .in2(Out2), .in3(Out3), .in4(Out4), .sel(sel[3:2]));

endmodule
