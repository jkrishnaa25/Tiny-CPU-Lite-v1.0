//instruction memory
module inst_mem(input [3:0] in_add,output reg [15:0] out);
  
  reg [15:0] mem [0:15];
  
  always @(*) begin
    out = mem[in_add];
  end
endmodule
