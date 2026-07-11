// Code your design here
module inst_mem(input [3:0] in_add,output reg [15:0] out);
  reg [15:0] mem [0:15];
  initial begin
        mem [0] = 16'h0000;
        mem [1] = 16'h1026;
        mem [2] = 16'h2656;
        mem [3] = 16'h2A56;
        mem [4] = 16'h3ABB;
        mem [5] = 16'h6A62;
        mem [6] = 16'h5FFF;
        mem [7] = 16'h6656;
        mem [8] = 16'h7454;
        mem [9] = 16'h4DDD;
        mem [10] = 16'h154D;
        mem [11] = 16'h254D;
        mem [12] = 16'h35DD;
        mem [13] = 16'h5FF4;
        mem [14] = 16'h63FC;
        mem [15] = 16'h5BCD;
      end
  always @(*) begin
    out = mem[in_add];
  end
endmodule