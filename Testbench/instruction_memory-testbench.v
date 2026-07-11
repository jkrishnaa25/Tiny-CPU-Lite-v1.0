module testbench;
  
  reg [3:0]in_add;
  wire [15:0] out;
  
  reg [15:0] mem [0:15];
  
  inst_mem dut(.in_add(in_add), .out(out));
  
  integer pass,fail,i;
  
  initial
    begin
      pass = 0;
      fail = 0;
    end
  
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
  
  reg [15:0]exp_out;
  
  task test;
    input [3:0] add;
    begin
      
      in_add = add;
      exp_out =  mem[add];
      #1;
      
      if(exp_out == out) begin
        pass = pass + 1;
        $display("Pass : Time=%0t Add=%b Output = %b Expected Output = %b",$time,add,out,exp_out);
      end
      else begin
        fail = fail + 1;
        $display("Fail : Time=%0t Add=%b Output = %b Expected Output = %b",$time,add,out,exp_out);
      end
      #10;
    end
    
  endtask
  
  initial begin
    
    
    for(i=0;i<16;i=i+1)
      test(i);
    
    
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