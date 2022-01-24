# Unpipelined-Single-Cycle-Implementation
The WISC-SP13 architecture that you will design for the final project shares many
resemblances with the MIPS R2000 described in the textbook. The major differences are a
smaller instruction set and 16-bit words for the WISC-SP13. Similarities include a load/store
architecture and three fixed-length instruction formats.

Registers
There are eight user registers, R0-R7. Unlike the MIPS R2000, R0 is not always zero. Register
R7 is used as the link register for JAL or JALR instructions. The program counter is separate
from the user register file. A special register named EPC is used to save the current PC upon an
exception or interrupt invocation.

Memory System
The WISC-SP13 is a Harvard architecture, meaning instructions and data are located in
different physical memories. It is byte-addressable, word aligned* (where a word is 16 bits long),
and big-endian. The final version of the WISC-SP13 will include a multi-cycle memory and
level-1 cache. However, initial versions of the machine will contain a single cycle memory.
(More details will be provided as reach the corresponding stage)

Pipeline
The final version of the WISC-SP13 contains a five stage pipeline identical to the MIPS R2000.
The stages are:
● Instruction Fetch (IF)
● Instruction Decode/Register Fetch (ID)
● Execute/Address Calculation (EX)
● Memory Access (MEM)
● Write Back (WB)

Optimizations
Your goal in optimizations is to reduce the CPI of the processor or the total cycles taken to
execute a program. While the primary concern of the WISC-SP13 is correct functionality, the
architecture must still have a reasonable clock period. Therefore, you may not have more than
one of the following in series during any stage:
● register file
● memory or cache
● 16-bit full adder
● barrel shifter
You may implement any type of optimization to reduce the CPI. The required optimizations are:
● There are two register forwarding paths in the WISC-SP13; one within the ID stage and
between the beginning of MEM and the beginning of EX.
● All branches should be predicted not-taken. This means that the pipeline should
continue to execute sequentially until the branch resolves, and then squash instructions
after the branch if the branch was actually taken.
