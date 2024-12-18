// Module Name:   LUT
// Class  Name:   CSE141L
// Design Name:   SESO
// Create Date:   2023.08.23
// possible lookup table for PC target
// leverage a 4-bit pointer to a wider number [-511,511]

module LUT(
  input[3:0] addr,
  output logic[9:0] Target 
  );

always_comb 
  case(addr)
    4'b0000: Target = 10'b0100010100;     // table[0] = 276
    4'b0001: Target = 10'b1011101010;     // table[1] = -278
    4'b0010: Target = 10'b0000101010;     // table[2] = +42
    4'b0011: Target = 10'b0001100101;     // table[3] = +101
    4'b0100: Target = 10'b0000000101;     // table[4] = +5
    4'b0101: Target = 10'b0001011011;     // table[5] = +91
    4'b0110: Target = 10'b1010111101;     // table[6] = -323
    4'b0111: Target = 10'b0000000001;     // table[7] = +1
    4'b1000: Target = 10'b0000000000;     // table[8] = 0
    4'b1001: Target = 10'b0000000000;     // table[9] = 0
    4'b1010: Target = 10'b0000000000;     // table[10] = 0
    4'b1011: Target = 10'b0000001001;     // table[11] = 9
    4'b1100: Target = 10'b1111101010;     // table[12] = -22
    4'b1101: Target = 10'b0000000100;     // table[13] = 4
    4'b1110: Target = 10'b0000111010;     // table[14] = 58
    4'b1111: Target = 10'b1110011010;     // table[15] = -102
    default: Target = 10'b0000000000;
  endcase
endmodule