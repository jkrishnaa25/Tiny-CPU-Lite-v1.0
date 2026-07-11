// Code your design here
module register_file(clk,rst,write_enable,write_add,write_data,read_add1,read_add2,read_data1,read_data2);
  
  input clk,rst,write_enable;
  input [1:0] write_add,read_add1,read_add2;
  input [7:0] write_data;
  output reg [7:0] read_data1,read_data2;
  
  reg [7:0] reg_file [0:3];
  integer i;
  
  always @(posedge clk or posedge rst)
    begin
      if(rst==1) begin
        for(i=0;i<4;i=i+1) begin
          reg_file[i] <= 8'b00000000;
        end
      end
      else begin
        if(write_enable) begin
            reg_file[write_add] <= write_data;
        end    
      end
    end
  always @(*) begin
    read_data1 = reg_file[read_add1];
	read_data2 = reg_file[read_add2];
  end
endmodule
 
