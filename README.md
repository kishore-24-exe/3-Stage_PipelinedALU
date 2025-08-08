Project Overview
  This project implements a 3-stage pipelined 8-bit ALU in Verilog HDL, closely mirroring the way real-world CPUs improve performance through instruction-level parallelism.

🔧 Pipeline Stages
1️⃣ Instruction Fetch (IF) – Load the instruction from memory
2️⃣ Instruction Decode (ID) – Extract operands and operation type
3️⃣ Execution (EX) – Perform the ALU operation using a custom-built ALU core

📌 Example Execution
Instruction (16-bit): 0x110A

Opcode (4-bit) = 1 (ADD)

Input A (8-bit) = 0x10

Input B (4-bit) = 0x0A

Result = 16 + 10 = 26

📈 Future Enhancements
Planned improvements to make the design more CPU-like:

Additional pipeline stages

Instruction Decode/Control Unit

Memory Access stage with 32-bit instructions

Register File integration

Hazard detection and forwarding

🛠 Tech Stack
HDL: Verilog
Simulation Tools: ModelSim / Xilinx Vivado 

