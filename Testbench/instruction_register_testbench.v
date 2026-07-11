// Code your testbench here
// or browse Examples
module testbench;
  reg clk,rst,ir_enable;
  reg [15:0] inst;
  wire [15:0] ir_data;
  
  integer pass, fail,i;
  
  inst_reg dut(.clk(clk), .rst(rst), .ir_enable(ir_enable), .inst(inst), .ir_data(ir_data));
  
  initial begin
    clk = 0;
    pass = 0;
    fail = 0;
  end
  
  always #5 clk = ~clk;
  
  reg [15:0]exp_data;
  
  task load;
    input [15:0]in;
    begin
      inst=in;
      ir_enable = 1;
      @(posedge clk) begin
        if(ir_enable)
          begin
            exp_data = in;
            #1;
          end
      end
      if(exp_data == ir_data) begin
        pass = pass + 1;
        $display("Pass : Time=%0t Output = %b Expected Output = %b",$time,ir_data,exp_data);
      end
      else begin
        fail = fail + 1;
        $display("Fail : Time=%0t Output = %b Expected Output = %b",$time,ir_data,exp_data);
      end   
      #10;
      ir_enable=0;
    end
  endtask
  task hold;
    begin
      @(posedge clk)
      #1;
      if(exp_data == ir_data) begin
        pass = pass + 1;
        $display("Pass : Time=%0t Output = %b Expected Output = %b",$time,ir_data,exp_data);
      end
      else begin
        fail = fail + 1;
        $display("Fail : Time=%0t Output = %b Expected Output = %b",$time,ir_data,exp_data);
      end   
      #10;
    end
  endtask
  task reset;
    begin
      rst = 1;
      exp_data = 16'h0000;
      #1;
      if(exp_data == ir_data) begin
        pass = pass + 1;
        $display("Pass : Time=%0t Output = %b Expected Output = %b",$time,ir_data,exp_data);
      end
      else begin
        fail = fail + 1;
        $display("Fail : Time=%0t Output = %b Expected Output = %b",$time,ir_data,exp_data);
      end   
      #10;
      rst = 0;
    end
  endtask
  initial begin
    reset();
    for(i=0;i<65536;i=i+100)
      load(i);
    hold();
    
    if(fail==0) begin
      $display("Design Pass");
      $display("Pass count = %d  Fail count = %d",pass,fail);
    end
    else begin
      $display("Design Fail");
      $display("Pass count = %d  Fail count = %d",pass,fail); 
    end
    
    #10; $finish;
  end
  
endmodule
