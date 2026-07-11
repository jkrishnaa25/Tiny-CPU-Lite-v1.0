// Code your design here
module inst_reg(input clk,rst,ir_enable,
                input [15:0]inst,
                output reg [15:0]ir_data);
  always @(posedge clk or posedge rst) begin
    if(rst)
      ir_data <= 16'h0000;
    else begin
      if(ir_enable) begin
        ir_data <= inst; 
      end
    end
  end
endmodule