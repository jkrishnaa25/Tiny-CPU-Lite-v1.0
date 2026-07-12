//ALU
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
    		NOP = 3'b111;
  
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
      NOP : 
        begin
          result = 8'd0;
        end
      default:
    	result = 8'd0;
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
               output reg [7:0] immediate);
  
  always @(*) begin
    mov = instruction[15];
    opcode = instruction [14:12] ;
    rd =  instruction[11:10];
    rs = instruction [9:8];
    immediate =  instruction [7:0] ;
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
  wire [15:0]im;
  wire [15:0]ir;
  wire [2:0]opcode;
  wire [1:0]rs;
  wire [1:0]rd;
  wire [7:0]value;
  wire [7:0]alu_out;
  wire [7:0]data1;
  wire [7:0]data2;
  wire mov;
  wire [7:0] mux;
  wire pc_enable;
  wire ir_enable;
  wire write_enable;
  
  fsm mod1(clk,rst,pc_enable,ir_enable,write_enable);
  
  program_counter mod2(clk,rst,pc_enable,pc);
  
  inst_mem mod3(pc,im);
  
  inst_reg mod4(clk,rst,ir_enable,im,ir);
  
  decoder mod5(ir,mov,opcode,rs,rd,value);  
  
  assign mux = mov ? value : alu_out;

  register_file mod6(.clk(clk), 
                     .rst(rst), 
                     .write_enable(write_enable), 
                     .write_add(rd),
                     .write_data(mux), 
                     .read_add1(rd), 
                     .read_add2(rs), 
                     .read_data1(data1), 
                     .read_data2(data2));
  
  alu mod7(.a(data1), 
           .b(data2), 
           .opcode(opcode), 
           .result(alu_out));
    
endmodule

  
  
  
  
