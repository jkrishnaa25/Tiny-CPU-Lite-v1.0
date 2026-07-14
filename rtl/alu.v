module alu(a,b,opcode,result,status_reg);

  input [7:0]a;
  input [7:0]b; 
  input [2:0]opcode;
  output reg [7:0]result;
  output reg [3:0] status_reg;
  reg [8:0]temp;
  
  parameter ADD = 3'b000,
    		SUB = 3'b001,
    		AND = 3'b010,
    		 OR = 3'b011,
    		XOR = 3'b100,
    		CMP = 3'b101,
    		NOT = 3'b110,
    		NOP = 3'b111;
  
  always @(*) begin
    case(opcode)
      ADD : 
        begin
          temp = a + b;
          result = temp[7:0];
          status_reg[3] = temp[8]; 								 //carry
          status_reg[2] = (result == 8'd0); 					 //zero
          status_reg[1] = (~(a[7] ^ b[7])) & (a[7] ^ result[7]); //overflow
          status_reg[0] = result[7];                             //negative
        end
      SUB : 
        begin
		  temp = a - b;
          result = temp[7:0];
          status_reg[3] = temp[8];
          status_reg[2] = (result == 8'd0);
          status_reg[1] = ((a[7] ^ b[7])) & (a[7] ^ result[7]);
          status_reg[0] = result[7];
        end
      AND : 
        begin
          temp = a & b;
          result = temp[7:0];
          status_reg[3] = 0;
          status_reg[2] = (result == 8'd0);
          status_reg[1] = 0;
          status_reg[0] = result[7];

        end
      OR : 
        begin
          temp = a | b;
          result = temp[7:0];
          status_reg[3] = 0;
          status_reg[2] = (result == 8'd0);
          status_reg[1] = 0;
          status_reg[0] = result[7];

        end
      XOR : 
        begin
          temp = a ^ b;
          result = temp[7:0];
          status_reg[3] = 0;
          status_reg[2] = (result == 8'd0);
          status_reg[1] = 0;
          status_reg[0] = result[7];

        end
      CMP : 
        begin
          temp = a - b;
          result = temp[7:0];
          status_reg[3] = temp[8];
          status_reg[2] = (result == 8'd0);
          status_reg[1] = ((a[7] ^ b[7])) & (a[7] ^ result[7]);
          status_reg[0] = result[7];

        end
      NOT : 
        begin
          temp = ~a;
          result = temp[7:0];
          status_reg[3] = 0;
          status_reg[2] = (result == 8'd0);
          status_reg[1] = 0;
          status_reg[0] = result[7];
        end
      NOP : 
        begin
          temp = 8'd0;
          result = temp[7:0];
          status_reg[3] = 0;
          status_reg[2] = (result == 8'd0);
          status_reg[1] = 0;
          status_reg[0] = result[7];
        end
      default: begin
        temp = 8'd0;
        result = temp[7:0];
        status_reg[3] = 0;
        status_reg[2] = (result == 8'd0);
        status_reg[1] = 0;
        status_reg[0] = result[7];
      end

    endcase
  end
endmodule
