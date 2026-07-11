module testbench;
  
  reg clk,rst;
  wire pc_enable,ir_enable,write_enable;
  
  fsm dut(.clk(clk), 
          .rst(rst), 
          .pc_enable(pc_enable), 
          .ir_enable(ir_enable), 
          .write_enable(write_enable));
  
  reg exp_pc,exp_ir,exp_write;
  
  integer pass = 0;
  integer fail = 0;
  
  initial clk = 0;
  always #5 clk = ~clk;
  
  parameter FETCH      = 2'b00,
  			DECODE     = 2'b01, 
  			EXECUTE    = 2'b10, 
  			WRITEBACK  = 2'b11;
  
  reg [1:0] prt_state,nxt_state;
  
  task check;
    begin
      
      case(prt_state)
        FETCH : 
          begin
            exp_pc = 1;
            exp_ir = 1;
            exp_write = 0;
            if((exp_pc == pc_enable)&&(exp_ir==ir_enable)&&(exp_write==write_enable))
              begin
                pass = pass + 1;
                $display("Pass : Time=%0t pc enable=%b ir enable=%b write enable=%b Present state=%b",$time,pc_enable,ir_enable,write_enable,nxt_state);
              end
            else
              begin
                fail = fail +1;
                $display("Fail : Time=%0t pc enable=%b ir enable=%b write enable=%b Present state=%b",$time,pc_enable,ir_enable,write_enable,nxt_state);
                $display("Expected: pc enable=%b ir enable=%b write enable=%b Present state=%b",$time,exp_pc,exp_ir,exp_write,nxt_state);
              end
            nxt_state = 2'b01;
            $display("Time=%0t TB prt_state=%b nxt_state=%b", $time, prt_state, nxt_state);
          end 
        DECODE :
          begin
            exp_pc = 0;
            exp_ir = 0;
            exp_write = 0;
            if((exp_pc == pc_enable)&&(exp_ir==ir_enable)&&(exp_write==write_enable))
              begin
                pass = pass + 1;
                $display("Pass : Time=%0t pc enable=%b ir enable=%b write enable=%b Present state=%b",$time,pc_enable,ir_enable,write_enable,nxt_state);
              end
            else
              begin 
                fail = fail +1;
                $display("Fail : Time=%0t pc enable=%b ir enable=%b write enable=%b Present state=%b",$time,pc_enable,ir_enable,write_enable,nxt_state);
                $display("Expected: pc enable=%b ir enable=%b write enable=%b Present state=%b",$time,exp_pc,exp_ir,exp_write,nxt_state);
              end
            nxt_state = 2'b10;
            $display("Time=%0t TB prt_state=%b nxt_state=%b", $time, prt_state, nxt_state);
          end
        EXECUTE : 
          begin
            exp_pc = 0;
            exp_ir = 0;
            exp_write = 0;
            if((exp_pc == pc_enable)&&(exp_ir==ir_enable)&&(exp_write==write_enable))
              begin
                pass = pass + 1;
                $display("Pass : Time=%0t pc enable=%b ir enable=%b write enable=%b Present state=%b",$time,pc_enable,ir_enable,write_enable,nxt_state);
              end
            else
              begin
                fail = fail +1;
                $display("Fail : Time=%0t pc enable=%b ir enable=%b write enable=%b Present state=%b",$time,pc_enable,ir_enable,write_enable,nxt_state);
                $display("Expected: pc enable=%b ir enable=%b write enable=%b Present state=%b",$time,exp_pc,exp_ir,exp_write,nxt_state);
              end
            nxt_state = 2'b11;
            $display("Time=%0t TB prt_state=%b nxt_state=%b", $time, prt_state, nxt_state);
          end
        WRITEBACK :
          begin
            exp_pc = 0;
            exp_ir = 0;
            exp_write = 1;
            if((exp_pc == pc_enable)&&(exp_ir==ir_enable)&&(exp_write==write_enable))
              begin
                pass = pass + 1;
                $display("Pass : Time=%0t pc enable=%b ir enable=%b write enable=%b Present state=%b",$time,pc_enable,ir_enable,write_enable,nxt_state);
              end
            else
              begin
                fail = fail +1;
                $display("Fail : Time=%0t pc enable=%b ir enable=%b write enable=%b Present state=%b",$time,pc_enable,ir_enable,write_enable,nxt_state);
                $display("Expected: pc enable=%b ir enable=%b write enable=%b Present state=%b",$time,exp_pc,exp_ir,exp_write,nxt_state);
              end
            nxt_state = 2'b00;
            $display("Time=%0t TB prt_state=%b nxt_state=%b", $time, prt_state, nxt_state);
          end
        default :
          begin
            exp_pc = 0;
            exp_ir = 0;
            exp_write = 0;
            if((exp_pc == pc_enable)&&(exp_ir==ir_enable)&&(exp_write==write_enable))
              begin
                pass = pass + 1;
                $display("Pass : Time=%0t pc enable=%b ir enable=%b write enable=%b Present state=%b",$time,pc_enable,ir_enable,write_enable,nxt_state);
              end
            else
              begin
                fail = fail +1;
                $display("Fail : Time=%0t pc enable=%b ir enable=%b write enable=%b Present state=%b",$time,pc_enable,ir_enable,write_enable,nxt_state);
                $display("Expected: pc enable=%b ir enable=%b write enable=%b Present state=%b",$time,exp_pc,exp_ir,exp_write,nxt_state);
              end
            nxt_state = 2'b00;
            $display("Time=%0t TB prt_state=%b nxt_state=%b", $time, prt_state, nxt_state);
          
          end
      endcase
      prt_state = nxt_state;

    end
  endtask
  
  task reset;
    begin
      rst = 1;
      #1;
      prt_state = FETCH;
      nxt_state = FETCH;
      check();
      rst = 0;
    end
  endtask
  
  
  
  
  
  initial begin
    reset();
    repeat(15)
      begin
        @(posedge clk)
        #1;
        check();
      end
    
    
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
  
  
  
  
  