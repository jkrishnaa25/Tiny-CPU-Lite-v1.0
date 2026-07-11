// Code your testbench here
// or browse Examples
module testbench;
  
  reg [7:0]a;
  reg [7:0]b;
  reg [2:0]opcode;
  wire [7:0]result;
  
  alu dut(.a(a), .b(b), .opcode(opcode), .result(result));
  
  parameter ADD = 3'b000,
    		SUB = 3'b001,
    		AND = 3'b010,
    		 OR = 3'b011,
    		XOR = 3'b100,
    		CMP = 3'b101,
    		NOT = 3'b110,
    		NOR = 3'b111;
  
  reg [7:0] exp_output;
  integer pass,fail;
  integer i,j,k;
  
  initial begin
    pass = 0;
    fail = 0;
  end
  
  task test;
    
    input [2:0] op;
    input [7:0] x,y;
    
    begin
      a=x;
      b=y;
      opcode=op;
      
      begin  
    	case(op)
    	  ADD : 
        	begin
        	  exp_output = x + y;
        	end
      	  SUB : 
        	begin
			  exp_output = x - y;
        	end
      	  AND : 
        	begin
        	  exp_output = x & y;
        	end
      	  OR : 
        	begin
        	  exp_output = x | y;
        	end
      	  XOR : 
        	begin
        	  exp_output = x ^ y;
        	end
          CMP : 
        	begin
          	  exp_output = x - y;
        	end
      	  NOT : 
        	begin
          	  exp_output = ~x;
        	end
          NOR : 
        	begin
              exp_output = ~(x | y);
            end
      	  default:
    		exp_output = 8'd0;
    	endcase
      end
    end
    #1;
    
    if(exp_output==result) begin
      pass = pass + 1;
      $display("PASS: Time=%0t Case=%b Input A=%b Input B=%b Output = %b",$time,op,a,b,result);
    end
    else begin
      fail = fail + 1;
      $display("Fail: Time=%0t Case=%b Input A=%b Input B=%b Output = %b Expected O/P=%b",$time,a,b,op,result,exp_output);
    end 
    #10;
  endtask
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, testbench);
    
    //testcases
    for (k=0;k<8;k=k+1) begin
    	$display("testcase %d",k);
      for (i=0;i<256;i=i+12) begin
        for (j=0;j<256;j=j+10) begin
          test(k,i,j);
      	  end
    	end
    end
     
    if(fail==0)
      $display("Design PASS");
    else
      $display("Design FAIL");
    
    #10; $finish;
    
  end
endmodule