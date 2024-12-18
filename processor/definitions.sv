// File   Name:    definitions
// Class  Name:    CSE141L
// Design Name:    SESO
// Create Date:    2023.08.20
//This file defines the parameters used in the alu

package definitions;
    
// Instruction map
    const logic [3:0]kLSL  = 4'b0000;
    const logic [3:0]kLSR  = 4'b0001;
    const logic [3:0]kADD  = 4'b0010; 
    const logic [3:0]kAND  = 4'b0011;
    const logic [3:0]kORR  = 4'b0100;
    const logic [3:0]kEOR  = 4'b0101;
    const logic [3:0]kTAKE = 4'b0110;
    const logic [3:0]kMOVE = 4'b0111;
    const logic [3:0]kLDR  = 4'b1000;
    const logic [3:0]kSTR  = 4'b1001;
    const logic [3:0]kCMP  = 4'b1010;
    const logic [3:0]kB    = 4'b1011;
    const logic [3:0]kBEQ  = 4'b1100; 
    const logic [3:0]kBNE  = 4'b1101;
    const logic [3:0]kHALT = 4'b1110;

    // enum names will appear in timing diagram
    typedef enum logic[3:0] {
        LSL, LSR, ADD, AND,
        ORR, EOR, TAKE, MOVE,
        LDR, STR, CMP, B, BEQ, BNE, STOP } op_mne;
 
endpackage // definitions
