
# Tiny CPU Lite v1.0

A custom 8-bit CPU designed from scratch in **Verilog HDL** as part of my VLSI Frontend Design Internship. This project focuses on RTL design, digital architecture, and functional verification using self-checking testbenches.

---

## 📌 Project Overview

Tiny CPU Lite v1.0 is a simple custom processor developed to understand the fundamentals of CPU architecture and RTL design. Each hardware block is designed, implemented, and verified individually before integrating the complete processor.

---

# 🖥️ CPU Specifications

| Specification | Details |
|---------------|---------|
| Data Width | 8-bit |
| ALU | 8-bit |
| Register File | 4 × 8-bit Registers |
| Program Counter | 4-bit |
| Instruction Width | 16-bit |
| Instruction Register | 16-bit |
| Instruction Memory | 32 Bytes |
| Instruction Decoder | Custom 16-bit Decoder |
| Control Unit | 4-State FSM |

---

## 🔄 Instruction Cycle

```text
FETCH
   ↓
DECODE
   ↓
EXECUTE
   ↓
WRITEBACK
```

---

# ✅ Features

- 8-bit Combinational ALU
- 4 × 8-bit Register File
- Dual Read Ports
- Single Write Port
- Synchronous Reset
- Custom Instruction Decoder
- 4-State Control Unit FSM
- Self-checking Testbenches
- Behavioral Reference (Golden) Model
- Directed and Randomized Verification

---

# 📂 Repository Structure

```text
Tiny-CPU-Lite
│
├── rtl/
├── tb/
├── docs/
├── images/
├── waveforms/
└── README.md
```

---

# 🚀 Current Progress

| Module | Status |
|---------|--------|
| ALU | ✅ Completed |
| Register File | ✅ Completed |
| Program Counter | ✅ In Progress |
| Instruction Memory | ✅ Planned |
| Instruction Decoder | ✅ Planned |
| Control Unit (FSM) | ⏳ Planned |
| CPU Integration | ⏳ Planned |

---

# 🧪 Verification

Each module is verified using a self-checking testbench.

Verification methodology includes:

- Behavioral Reference (Golden) Model
- Directed Test Cases
- Randomized Test Cases
- Automatic RTL vs Reference Output Comparison

**Result:** ✅ 100% Match Between RTL and Reference Model

---

# 📈 Future Work

- Implement Program Counter
- Implement Instruction Memory
- Design Custom Instruction Decoder
- Implement 4-State Control Unit FSM
- Add Status Register (Carry, Zero, Negative Flags)
- Support Control Flow Instructions
- Integrate Complete Tiny CPU
- Extend Instruction Set Architecture (ISA)

---

# 🛠️ Tools Used

- Verilog HDL
- EDA Playground
- Icarus Verilog
- GTKWave

---

# 👨‍💻 Author

**Jadeja Krishna**

Electronics & Communication Engineering Student

Interested in RTL Design, ASIC Design, Digital Design, FPGA, and Computer Architecture.

---

## ⭐ Project Goal

The objective of this project is to strengthen my understanding of RTL design, processor architecture, and digital verification while building a complete custom CPU from scratch.
