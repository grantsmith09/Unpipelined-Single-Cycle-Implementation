module right_rotate(Out, In, Cnt);

    input[15:0] In;
    input[3:0] Cnt;

    output[15:0] Out;

    wire [15:0] rot1, rot2, rot4, rot8;
    wire [15:0] out_rotate_1, out_rotate_2, out_rotate_4;

    // Rotate 1 bit 
    assign rot1 = ({In[0], In[15:1]});
    mux2_1_16 mux1(.Out(out_rotate_1), .in1(In), .in2(rot1), .sel(Cnt[0]));

    // Rotate 2 bits
    assign rot2 = ({out_rotate_1[1:0], out_rotate_1[15:2]});
    mux2_1_16 mux2(.Out(out_rotate_2), .in1(out_rotate_1), .in2(rot2), .sel(Cnt[1]));

    // Rotate 4 bits
    assign rot4 = ({out_rotate_2[3:0], out_rotate_2[15:4]});
    mux2_1_16 mux3(.Out(out_rotate_4), .in1(out_rotate_2), .in2(rot4), .sel(Cnt[2]));

    // Rotate 8 bits
    assign rot8 = ({out_rotate_4[7:0], out_rotate_4[15:8]});
    mux2_1_16 mux4(.Out(Out), .in1(out_rotate_4), .in2(rot8), .sel(Cnt[3]));

endmodule
