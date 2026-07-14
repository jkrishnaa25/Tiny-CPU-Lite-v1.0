//ALU
//ALU
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

//register file
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
 

//program counter
module program_counter(input clk,rst,pc_enable,output reg [3:0] pc);
  
  always @(posedge clk or posedge rst)
    begin
      if (rst)
        begin
          pc <= 4'b0000; 
        end
      else 
        begin
          if(pc_enable)
            begin             
              pc <= pc + 1;
            end
        end
    end
endmodule

//instruction memory
module inst_mem(input [3:0] in_add,output reg [15:0] out);
  
  reg [15:0] mem [0:15];
  
  always @(*) begin
    out = mem[in_add];
  end
endmodule

//instruction register
module inst_reg(input clk,rst,ir_enable,
                input [15:0]inst,
                output reg [15:0]ir_data);
  
  always @(posedge clk or posedge rst) begin
    if(rst)
      ir_data <= 16'h0000;
    else begin
      if(ir_enable) begin
        ir_data <= inst; 
      end
    end
  end
endmodule

//decoder
module decoder(input [15:0] instruction, 
               output reg mov,
               output reg [2:0] opcode,
               output reg [1:0] rs,
               output reg [1:0] rd,
               output reg [7:0] value);
  
  always @(*) begin
    mov = instruction[15];
    opcode = instruction [14:12] ;
    rd =  instruction[11:10];
    rs = instruction [9:8];
    value =  instruction [7:0] ;
  end
endmodule

//FSM
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

//Tiny cpu
module tiny_cpu(clk,rst);
  
  input clk;
  input rst;
  
  wire [3:0]pc;
  wire [15:0]out;
  wire [15:0]ir_data;
  wire [2:0]opcode;
  wire [1:0]rs;
  wire [1:0]rd;
  wire [7:0]value;
  wire [7:0]alu_out;
  wire [7:0]read_data1;
  wire [7:0]read_data2;
  wire mov;
  wire [7:0] mux;
  wire pc_enable;
  wire ir_enable;
  wire write_enable;
  wire [3:0] status_reg;
  
  fsm mod1(clk,rst,pc_enable,ir_enable,write_enable);
  
  program_counter mod2(clk,rst,pc_enable,pc);
  
  inst_mem mod3(pc,out);
  
  inst_reg mod4(clk,rst,ir_enable,out,ir_data);
  
  decoder mod5(ir_data,mov,opcode,rs,rd,value);  
  
  assign mux = mov ? value : alu_out;

  register_file mod6(.clk(clk), 
                     .rst(rst), 
                     .write_enable(write_enable), 
                     .write_add(rd),
                     .write_data(mux), 
                     .read_add1(rd), 
                     .read_add2(rs), 
                     .read_data1(read_data1), 
                     .read_data2(read_data2));
  
  alu mod7(.a(read_data1), 
           .b(read_data2), 
           .opcode(opcode), 
           .result(alu_out),
           .status_reg(status_reg));
    
endmodule

  
  
  
  
