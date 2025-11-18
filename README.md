# 🧠 RISC-V 3-Stage Pipelined Processor  
### RTL Design & Simulation using Verilog-HDL

---

## 📘 Overview
This project involves designing and simulating a simple **3-stage pipelined RISC-V processor** supporting the **RV32I instruction set**.  
The processor is implemented entirely in **Verilog-HDL** and demonstrates core computer architecture concepts including pipelining, data hazards, stalls, and instruction flow.

The project helps understand:
- RTL-level processor design  
- Pipeline flow  
- Hazard generation and handling  
- Mapping theoretical architecture to hardware  

---

## 🎯 Objectives

- Design a **32-bit RISC-V processor** with a **3-stage pipeline**  
- Implement instruction execution for **RV32I**  
- Handle **data hazards** using forwarding and stalling  
- Test and verify using a Verilog **testbench**  

---

## 🔄 Processor Pipeline (3 Stages)

### 1️⃣ Instruction Fetch (IF)
- Fetches instruction from Instruction Memory  
- Updates Program Counter (PC)

### 2️⃣ Execute (EX)
- Decodes instruction  
- Performs ALU operations  
- Handles branching  
- Reads register operands  
- Performs load/store operations from Data Memory  

### 3️⃣ Write Back (WB)
- Writes the ALU or memory result back to the Register File  

---

## ⭐ Key Features

### ✔ Data Forwarding  
Prevents unnecessary stalls by forwarding intermediate results.

### ✔ Stall Handling  
Introduces stalls when forwarding is not possible.

### ✔ Branch Handling  
Branch conditions are resolved in EX stage.

### ✔ Modular Architecture  
Each unit is designed as a separate Verilog module.

---

## 📂 Project Structure

```
RISC_V_3_Stage_Pipeline/
│
├── Control_Unit/
│   ├── control_unit.v
│   └── decoder.v
│
├── Datapath/
│   ├── ALU.v
│   ├── register_file.v
│   ├── imm_gen.v
│   ├── pc.v
│   ├── pipeline_registers.v
│   └── muxes.v
│
├── Instruction_Memory/
│   ├── instruction_memory.v
│   └── program.hex
│
├── Data_Memory/
│   └── data_memory.v
│
├── Testbench/
│   ├── riscv_tb.v
│   └── wave.do
│
└── Top_Module/
    └── riscv_pipeline_top.v
```

---

