// Module Name:    ALU
// Class  Name:    CSE141L
// Design Name:    SESO
// Create Date:    2023.08.20
// Additional Comments:
// combinational (unclocked) ALU

import definitions::*;                  // includes package "Definitions"

module ALU(
  input CLK, 
        reset,
  input [8:0] Instruction,	        // machine code
  input [3:0] OP,
  input [7:0] INPUT_ACC,      	        // data inputs
  input [7:0] INPUT_REG,
  output logic [7:0] OUT,
  output logic to_jump
  );

  logic tojump_next;

  always_ff @(posedge CLK) begin
    if(reset)
      to_jump <= 0;
    else
      to_jump <= tojump_next;
  end  

  op_mne op_mnemonic;		        // type enum: used for convenient waveform viewing

	 
  always_comb begin
    OUT = 8'b0000_0000;
    tojump_next = 1'b0;

    if (Instruction[8] == 'b0)          // put in control part for immediate
        OUT = Instruction[7:0];
     
    else
      case(OP)
        //lsl
        kLSL:
            OUT = INPUT_REG << INPUT_ACC;
        //lsr
        kLSR:
            OUT = INPUT_REG >> INPUT_ACC;
        //add
        kADD:
            OUT = INPUT_ACC + INPUT_REG;
        //and
        kAND:
            OUT = INPUT_ACC & INPUT_REG;
        //orr
        kORR: 
            OUT = INPUT_ACC | INPUT_REG;
        //eor
        kEOR:
            OUT = INPUT_ACC ^ INPUT_REG;
        //take
        kTAKE:
            OUT = INPUT_REG;
        //move
        kMOVE:
            OUT = INPUT_ACC;
        //ldr
        kLDR:
            OUT = INPUT_REG;
        //str
        kSTR:
            OUT = INPUT_REG;
        //cmp
        kCMP: begin
            if (INPUT_ACC - INPUT_REG == 8'b0000_0000) begin
                OUT = 8'b0000_0001;    // Set condition code flags for equal
                tojump_next = 1'b1;
	    end
            else begin
                OUT = 8'b0000_0000;    // Set condition code flags for not equal
                tojump_next = 1'b0;
	    end
        end
        default: OUT = 1'b0;
      endcase
    op_mnemonic = op_mne'(OP);         // displays operation name in 
  end
endmodule