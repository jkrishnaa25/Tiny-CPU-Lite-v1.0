// Code your design here
module decoder(input [15:0] instruction,
               output reg [3:0] opcode,
               output reg [1:0] rs,
               output reg [1:0] rd,
               output reg [7:0] immediate);
  always @(*) begin
    opcode = instruction [15:12] ;
    rd =  instruction[11:10];
    rs = instruction [9:8];
    immediate =  instruction [7:0] ;
  end
endmodule
