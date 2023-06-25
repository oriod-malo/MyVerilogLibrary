# My Verilog Library
## (UPDATE: 25 June 2023: MIPS32 CPU is completed and it's a repository of its own)

My Library of Verilog Modules and Functions

Most of these modules are practice / implementations based on the book "**Embedded SoPC Design with Nios II Processor and Verilog Examples**"

They are made to simulate on a DE10 Lite FPGA using Quartus

UART Transmitter 

## List of modules NOT based on the book 
* ~~ MIPS 32 CPU (mips32.v) - my next big project. A MIPS32 CPU with a significant amount of Instruction Set commands implemented still WIP. Will be uploaded as a separate repository when done~~ .
* UPDATE: MIPS32 CPU has been completed and added as a repository of its own: https://github.com/oriod-malo/Custom-MIPS32-CPU
* UART Transmitter (uart_transmitter.v) - a small challenge I put myself to after finishing the FSM Chapter of the book. Implementing an UART with FSM only by looking at its conceptual functionality

## List of modules based from the book
* Debouncer with FSMD
* Edge Detector
* Debouncer
* 1-bit comparator
* 4-bit comparator
* FIFO (& FIFO Controller)
* modM Counter
* RAM, Dual Port
* RAM, Single Port
* ROM
* Rotating Square on DE-10 lite
* Square Wave Generator
* BCD Counter

## Below some simulation images (UART Transmitter & Edge Detector Verification).

### Preliminary Testbench on MIPS32
![mips32-preliminary_test](https://github.com/oriod-malo/MyVerilogLibrary/assets/123891760/21620b7d-9deb-4d5f-9890-e6585dd00248)
### Verification of UART Transmitter
![uart_transmitter_Verification](https://github.com/oriod-malo/MyVerilogLibrary/assets/123891760/74cea112-0592-498a-b50e-bffdc1ede536)
### Verification of Edge Detector
![c6_e6_3_1_edgeDetector Verification](https://github.com/oriod-malo/MyVerilogLibrary/assets/123891760/dc8d85f9-9ae3-4f9e-85ab-8287a7b0eef6)
