// Code your testbench here
// or browse Examples
module testbench;
  
  reg clk,rst,write_enable;
  reg [1:0] write_add,read_add1,read_add2;
  reg [7:0] write_data;
  wire [7:0] read_data1,read_data2;
  
  register_file dut(.clk(clk), 
                	.rst(rst), 
                	.write_enable(write_enable), 
                	.write_add(write_add), 
                	.write_data(write_data), 
                	.read_add1(read_add1), 
                	.read_add2(read_add2), 
                	.read_data1(read_data1), 
                	.read_data2(read_data2));
   
  initial clk = 0;
  always begin
    #5 clk = ~clk;
  end
  
  integer i,pass,fail;
  
  initial begin
    pass = 0;
    fail = 0;
  end
  
  reg [7:0] exp_mem [0:3];
  reg [7:0] exp_rdata1,exp_rdata2;
  
  task write;
    input exp_wr_en;
    input [1:0] exp_wr_add;
    input [7:0] exp_wr_data;
    
    begin
      write_enable = exp_wr_en;
      write_add = exp_wr_add;
      write_data = exp_wr_data;
      
	  @(posedge clk) begin
      
    	   if(exp_wr_en) begin
    	      exp_mem[exp_wr_add] = exp_wr_data;
    	   end
      end
      #1;
      write_enable = 0;
    end
  endtask
  
  task read;
    input [1:0] exp_radd1;
    input [1:0] exp_radd2;
    
    begin
      read_add1 = exp_radd1;
      read_add2 = exp_radd2;
      
      exp_rdata1 = exp_mem[exp_radd1];
      exp_rdata2 = exp_mem[exp_radd2];
      #1;
            
      if(exp_rdata1 == read_data1) begin
        pass = pass + 1;
        $display("Pass : Time=%0t Output = %b Expected Output = %b",$time,read_data1,exp_rdata1);
      end
      else begin
        fail = fail + 1;
        $display("Fail : Time=%0t Output = %b Expected Output = %b",$time,read_data1,exp_rdata1);
      end
      
      if(exp_rdata2 == read_data2) begin
        pass = pass + 1;
        $display("Pass : Time=%0t Output = %b Expected Output = %b",$time,read_data2,exp_rdata2);
      end
      else begin
        fail = fail + 1;
        $display("Fail : Time=%0t Output = %b Expected Output = %b",$time,read_data2,exp_rdata2);
      end   
      #10;
    end
  endtask
  
  task reset;

    begin
      rst = 1;
      #1;
        for(i=0;i<4;i=i+1) begin
          exp_mem[i] = 8'b00000000;
        end
      #1;
      rst = 0;
      #1;
        read(2'b00, 2'b01);
		read(2'b10, 2'b11);
      #1;
    end
  endtask
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, testbench);
    
   
   // reset();
    
    write(1'b1,2'b00,8'b10101010);
    write(1'b1,2'b10,8'b11101010);
    read(2'b00,2'b10);
    
    reset();
    
    write(1'b1,2'b11,8'b10101010);
    write(1'b1,2'b10,8'b11101010);
    read(2'b11,2'b10);
    
    reset();
    
    write(1'b1,2'b00,8'b10101010);
    write(1'b1,2'b10,8'b11101010);
    read(2'b10,2'b00);
    
    reset();
    
    write(1'b1,2'b00,8'b10101010);
    write(1'b1,2'b10,8'b11101010);
    read(2'b11,2'b10);
    
    reset();
    
    write(1'b1,2'b00,8'b10101010);
    write(1'b1,2'b10,8'b11101010);
    read(2'b01,2'b11);
    
    reset();
    
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