# Tiny CPU Lite v1.0

An **8-bit custom CPU** designed from scratch in **Verilog HDL** as part of my **VLSI Frontend Design Internship**.

The objective of this project is to understand processor architecture, RTL design, datapath implementation, control unit design, and digital verification by building a complete CPU from scratch.

---

# 📖 Project Overview

Tiny CPU Lite v1.0 is a simple educational processor that executes instructions using a **4-state instruction cycle**.

```text
FETCH
   ↓
DECODE
   ↓
EXECUTE
   ↓
WRITEBACK
```

Each hardware module was designed individually, verified using **self-checking testbenches with behavioral reference (Golden) models**, and finally integrated into a complete CPU.

---

# 🖥️ CPU Specifications

| Feature | Specification |
|---------|---------------|
| Data Width | 8-bit |
| Instruction Width | 16-bit |
| Program Counter | 4-bit |
| Instruction Memory | 16 × 16-bit |
| Register File | 4 × 8-bit |
| ALU | 8-bit |
| Status Register | Carry, Zero, Overflow, Negative |
| Decoder | Custom 16-bit |
| Control Unit | 4-State FSM |
| Instruction Cycle | FETCH → DECODE → EXECUTE → WRITEBACK |

---

# 🏗️ CPU Architecture

The Tiny CPU consists of the following RTL modules:

- Program Counter (PC)
- Instruction Memory
- Instruction Register (IR)
- Instruction Decoder
- Register File
- 8-bit ALU
- Status Register
- 4-State FSM Control Unit
- Top-Level CPU Integration

---

# 📑 Instruction Format

| Bits | Description |
|------|-------------|
| 15 | MOV Immediate Flag |
| 14:12 | ALU Opcode |
| 11:10 | Destination Register (RD) |
| 9:8 | Source Register (RS) |
| 7:0 | Immediate Data |

---

# ⚙️ Supported Instructions

| Instruction | Description |
|------------|-------------|
| MOV | Move Immediate |
| ADD | Addition |
| SUB | Subtraction |
| AND | Bitwise AND |
| OR | Bitwise OR |
| XOR | Bitwise XOR |
| CMP | Compare |
| NOT | Bitwise NOT |
| NOP | No Operation |

---

# 🚩 Status Register

The ALU generates a 4-bit Status Register after every arithmetic or logical operation.

| Bit | Flag | Description |
|-----|------|-------------|
| 3 | Carry | Carry/Borrow Flag |
| 2 | Zero | Result equals Zero |
| 1 | Overflow | Signed Arithmetic Overflow |
| 0 | Negative | MSB of Result |

---

# ✨ Features

- Custom 8-bit CPU Architecture
- Modular RTL Design
- 8-bit ALU
- 4 × 8-bit Register File
- Program Counter
- Instruction Memory
- Instruction Register
- Custom Instruction Decoder
- Immediate and Register-Based Operations
- Status Register Generation
- 4-State FSM Control Unit
- Complete CPU Top-Level Integration
- Modular Datapath Design

---

# 🧪 Verification

Every RTL module was verified independently before CPU integration.

### Verification Methodology

- Self-checking Testbench
- Behavioral Reference (Golden) Model
- Directed Test Cases
- Automatic RTL vs Reference Output Comparison

### Individually Verified Modules

- ✅ ALU
- ✅ Register File
- ✅ Program Counter
- ✅ Instruction Memory
- ✅ Instruction Register
- ✅ Instruction Decoder
- ✅ FSM Control Unit

Finally, all modules were integrated and verified together using a **CPU-level Testbench**.

---

# 💻 Example Program

```text
MOV R1,#EC
MOV R2,#AA

ADD R1,R2
SUB R1,R2
AND R1,R2
OR  R1,R2
XOR R1,R2
CMP R1,R2

NOT R1
NOT R2
NOT R3

NOP
```

---

# 📂 Repository Structure

```text
Tiny-CPU-Lite-v1.0
│
├── rtl/
│   ├── alu.v
│   ├── decoder.v
│   ├── instruction_memory.v
│   ├── instruction_register.v
│   ├── program_counter.v
│   ├── register_file.v
│   ├── fsm.v
│   └── tiny_cpu.v
│
├── tb/
│   ├── alu_tb.v
│   ├── decoder_tb.v
│   ├── instruction_memory_tb.v
│   ├── instruction_register_tb.v
│   ├── program_counter_tb.v
│   ├── register_file_tb.v
│   ├── fsm_tb.v
│   └── tiny_cpu_tb.v
│
├── images/
│
├── waveforms/
│
└── README.md
```

---

# 🛠️ Tools Used

- Verilog HDL
- EDA Playground
- Icarus Verilog
- GTKWave

---

# 🚀 Future Improvements

- Branch Instructions
- Jump Instructions
- Data Memory
- Load/Store Instructions
- Stack Pointer
- Larger Register File
- Expanded Instruction Set Architecture (ISA)
- Pipeline Architecture
- Interrupt Support

---

# 👨‍💻 Author

**Jadeja Krishnasinh**

Electronics & Communication Engineering Student

Interested in RTL Design, ASIC Design, FPGA Design, Digital Design, Computer Architecture, and Semiconductor Design.

---

## ⭐ Project Goal

The goal of this project is to strengthen my understanding of **RTL Design**, **Processor Architecture**, **Digital Design**, and **Functional Verification** by implementing a complete custom CPU from scratch using Verilog HDL.
