// Code your testbench here
// or browse Examples
module testbench;
  reg [15:0] instruction;
  wire [3:0] opcode;
  wire [1:0] rs;
  wire[1:0] rd;
  wire [7:0] immediate;
  
  integer i,pass,fail;
  
  initial begin
    pass = 0;
    fail = 0;
  end
  
  decoder dut(.instruction(instruction), .opcode(opcode), .rs(rs), .rd(rd), .immediate(immediate));
  
  reg [3:0]exp_opcode;
  reg [1:0]exp_rs,exp_rd;
  reg [7:0] exp_imm;
  
  task test;
    input [15:0]in;
    begin
      instruction = in;
      #1;
      begin
        exp_opcode = in [15:12];
        exp_rd = in [11:10];
        exp_rs = in [9:8];
        exp_imm = in [7:0];
      end
      if(exp_opcode == opcode) begin
        pass = pass + 1;
        $display("Pass : Time=%0t Output = %b Expected Output = %b",$time,opcode,exp_opcode);
      end
      else begin
        fail = fail + 1;
        $display("Fail : Time=%0t Output = %b Expected Output = %b",$time,opcode,exp_opcode);
      end 
      
      if(exp_rs == rs) begin
        pass = pass + 1;
        $display("Pass : Time=%0t Output = %b Expected Output = %b",$time,rs,exp_rs);
      end
      else begin
        fail = fail + 1;
        $display("Fail : Time=%0t Output = %b Expected Output = %b",$time,rs,exp_rs);
      end 
      
      if(exp_rd == rd) begin
        pass = pass + 1;
        $display("Pass : Time=%0t Output = %b Expected Output = %b",$time,rd,exp_rd);
      end
      else begin
        fail = fail + 1;
        $display("Fail : Time=%0t Output = %b Expected Output = %b",$time,rd,exp_rd);
      end 
      
      if(exp_imm == immediate) begin
        pass = pass + 1;
        $display("Pass : Time=%0t Output = %b Expected Output = %b",$time,immediate,exp_imm);
      end
      else begin
        fail = fail + 1;
        $display("Fail : Time=%0t Output = %b Expected Output = %b",$time,immediate,exp_imm);
      end 
      #10;
    end
  endtask
  
  initial begin
    
    for(i=1000;i<9999;i=i+100)
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
  
  