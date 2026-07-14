module testbench;

  reg clk,rst;
  tiny_cpu dut(.clk(clk),.rst(rst));

  initial clk = 0;
  always #5 clk = ~clk;

  // Load Program
  task load_instruction;
    input [3:0] address;
    input [15:0] instruction;
    begin
      dut.mod3.mem[address] = instruction;
    end
  endtask

  // Monitor CPU
  task monitor_cpu;
    begin
      @(posedge clk);
      #1;
      $display("TIME = %0t",$time);
    //FSM 
      $display("FSM");
      $display("Present State = %b",dut.mod1.prt_state);
      $display("Next State    = %b",dut.mod1.nxt_state);

    //Control Signals
      $display("\nControl Signals");
      $display("PC Enable     = %b",dut.mod1.pc_enable);
      $display("IR Enable     = %b",dut.mod1.ir_enable);
      $display("Write Enable  = %b",dut.mod1.write_enable);

    //Program Counter
      $display("\nProgram Counter");
      $display("PC = %d",dut.mod2.pc);

    // Instruction 
      $display("\nInstruction");
      $display("Instruction Memory = %h",dut.mod3.out);
      $display("Instruction Memory = %b",dut.mod3.out);

      $display("Instruction Register = %h",dut.mod4.ir_data);
      $display("Instruction Register = %b",dut.mod4.ir_data);

    //Decoder 
      $display("\nDecoder");
      $display("MOV       = %b",dut.mod5.mov);
      $display("Opcode    = %b",dut.mod5.opcode);
      $display("RD         = %b",dut.mod5.rd);
      $display("RS         = %b",dut.mod5.rs);
      $display("Immediate  = %h",dut.mod5.value);

    //Register File
      $display("\nRegister File");
      $display("Read Data1 = %h",dut.mod6.read_data1);
      $display("Read Data2 = %h",dut.mod6.read_data2);
      $display("R0 = %h",dut.mod6.reg_file[0]);
      $display("R1 = %h",dut.mod6.reg_file[1]);
      $display("R2 = %h",dut.mod6.reg_file[2]);
      $display("R3 = %h",dut.mod6.reg_file[3]);

    //ALU 
      $display("\nALU");
      $display("Operand A = %h",dut.mod7.a);
      $display("Operand B = %h",dut.mod7.b);
      $display("Opcode    = %b",dut.mod7.opcode);
      $display("Result    = %h",dut.mod7.result);
      $display("Status Register = %b", dut.status_reg);
    end
  endtask
  
  initial
    begin
      $dumpfile("dump.vcd"); 
      $dumpvars;
      load_instruction(0,16'h84EC);   // MOV R1,#EC
      load_instruction(1,16'h88AA);   // MOV R2,#AA
      load_instruction(2,16'h0600);   // ADD R1,R2
      load_instruction(3,16'h1600);   // SUB R1,R2
      load_instruction(4,16'h2600);   // AND R1,R2
      load_instruction(5,16'h3600);   // OR  R1,R2
      load_instruction(6,16'h4600);   // XOR R1,R2
      load_instruction(7,16'h5600);   // CMP R1,R2
      load_instruction(8,16'h6400);   // NOT R1
      load_instruction(9,16'h6800);   // NOT R2
      load_instruction(10,16'h6C00);  // NOT R3
      load_instruction(11,16'h7000);  // NOP
      rst = 1;
      #2;
      rst = 0;
      repeat(16)
        monitor_cpu();
      #20;
      $finish;
    end
endmodule
