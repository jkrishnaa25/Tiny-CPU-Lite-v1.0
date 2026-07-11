module alu(a,b,opcode,result);

  input [7:0]a;
  input [7:0]b; 
  input [2:0]opcode;
  output reg [7:0]result;
  
  parameter ADD = 3'b000,
    		SUB = 3'b001,
    		AND = 3'b010,
    		 OR = 3'b011,
    		XOR = 3'b100,
    		CMP = 3'b101,
    		NOT = 3'b110,
    		NOR = 3'b111;
  
  always @(*) begin
    case(opcode)
      ADD : 
        begin
          result = a + b;
        end
      SUB : 
        begin
		  result = a - b;
        end
      AND : 
        begin
          result = a & b;
        end
      OR : 
        begin
          result = a | b;
        end
      XOR : 
        begin
          result = a ^ b;
        end
      CMP : 
        begin
          result = a - b;
        end
      NOT : 
        begin
          result = ~a;
        end
      NOR : 
        begin
          result = ~(a | b);
        end
      default:
    	result = 8'd0;
    endcase
  end
endmodule
