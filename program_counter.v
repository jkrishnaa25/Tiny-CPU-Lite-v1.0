// Code your design here
module program_counter(input clk,rst,pc_enable,output reg [3:0] pc);
  always @(posedge clk or posedge rst)
    begin
      if (rst)
        begin
          pc <= 4'b0000; 
        end
      else 
        begin
          if(pc_enable)
            begin             
              pc <= pc + 1;
            end
        end
    end
endmodule