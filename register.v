module register(writedata, write, readdata, clk, rst);

   input [15:0] writedata;
   input write, clk, rst;

   output [15:0] readdata;

   wire [15:0] writeEnable; // Input to ff either

   assign writeEnable = (write) ? writedata : readdata;
    

   dff ff0[15:0](.q(readdata), .d(writeEnable), .clk(clk), .rst(rst));


endmodule
