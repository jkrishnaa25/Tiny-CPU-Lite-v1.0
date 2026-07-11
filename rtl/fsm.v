// Code your design here
module fsm(clk,rst,pc_enable,ir_enable,write_enable);
  
  input clk,rst;
  output reg pc_enable,ir_enable,write_enable;
  
  
  reg[1:0] prt_state,nxt_state;
  
  parameter FETCH      = 2'b00,
  			DECODE     = 2'b01, 
  			EXECUTE    = 2'b10, 
  			WRITEBACK  = 2'b11;
  
  always @(posedge clk or posedge rst) begin
    if(rst)
      prt_state <= FETCH;
    else
      prt_state <= nxt_state;
  end
  always @(*) begin
    case(prt_state)
      FETCH : 
        begin
          pc_enable = 1;
          ir_enable = 1;
          write_enable = 0;
        end 
      DECODE :
        begin
          pc_enable = 0;
          ir_enable = 0;
          write_enable = 0;
        end
      EXECUTE :
        begin
          pc_enable = 0;
          ir_enable = 0;
          write_enable = 0;
        end
      WRITEBACK :
        begin
          pc_enable = 0;
          ir_enable = 0;
          write_enable = 1;
        end
      default :
        begin
          pc_enable = 0;
          ir_enable = 0;
          write_enable = 0;
        end
    endcase
  end
  always @(*) begin
    case(prt_state)
      FETCH : 
        begin
          nxt_state = DECODE;
        end 
      DECODE :
        begin
          nxt_state = EXECUTE;
        end
      EXECUTE :
        begin
          nxt_state = WRITEBACK;
        end
      WRITEBACK :
        begin
          nxt_state = FETCH;
        end
      default :
        begin
          nxt_state = FETCH;
        end
    endcase
  end
endmodule