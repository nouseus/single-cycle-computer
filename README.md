# 🚀 Single Cycle CPU in VHDL
<p align="center">
<img src="https://github.com/nouseus/single-cycle-computer/blob/main/docs/diagram.jpg"></p>

## 🖥️ Overview
This project implements a **single-cycle CPU** using VHDL. The design consists of:
- **Datapath**: Registers, ALU (function unit), multiplexers, and other components.
- **Control Unit**: Instruction decoding and control signal generation.
- **Memory**: Instruction and data storage.

A single-cycle CPU in VHDL includes key components such as the Program Counter (PC), Instruction Memory, Instruction Register (IR), Control Unit, Data Memory, Register File, Arithmetic Logic Unit (ALU), and multiplexers, all synchronized by a clock signal.
During execution, the CPU fetches an instruction using the PC, decodes it with the IR and Control Unit, executes the required operations via the ALU and other components, and writes back the results to the Register File or Data Memory.
The Control Unit generates control signals based on the decoded instruction to manage data flow and execution sequence, aiming to perform all operations required by an instruction within a single clock cycle.

## 📁 Directory Structure
```plaintext
📂 single-cycle-cpu
├── src/          # VHDL source files
├── quartus/      # Quartus project files
├── sim/          # ModelSim simulation results
└── docs/         # Documentation and design notes
```

## 🛠️ Tools Used
- **Quartus II:** For design synthesis and FPGA implementation.
- **ModelSim:** For simulating and verifying the VHDL design.

## 🚧 Getting Started
1. Clone this repository:
````
git clone https://github.com/your-username/single-cycle-computer.git
cd single-cycle-computer
````
2. Open the Quartus II project file located in the quartus/ directory.
3. Use ModelSim and compile the project into a library and simulate it.
4. Or if you know what you are doing, download the files and create your own project on Quartus II and simulate it in ModelSim.

## ⚡ How to Simulate
1. Launch ModelSim.
2. Add the VHDL files from the src/ directory.
3. Edit the code snippets marked in _reg.vhd_ and _control_unit.vhd_ files.
4. Run simulations and observe the output.

## 🔗 References
- [ModelSim User Manual](https://ww1.microchip.com/downloads/aemdocuments/documents/fpga/ProductDocuments/UserGuides/modelsim_user_v11p7.pdf)
- [Quartus II Handbook](https://www.intel.com/content/dam/www/programmable/us/en/pdfs/literature/hb/qts/archives/quartusii_handbook_archive-13.1.pdf)
- M. Morris Mano - Logic and Computer Design Fundamentals (4th edition)
