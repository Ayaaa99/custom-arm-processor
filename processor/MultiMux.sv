// Module Name:   MultiMux
// Class  Name:   CSE141L
// Design Name:   SESO
// Create Date:   2023.08.23

module MultiMux(
  input	PCmux_en,			// control by Control
	ALUmux_en,
	DataMemmux_en,
  input [7:0] PCmux_inA,		// mux 1
              ALUmux_inA,
	      DataMemmux_inA,
  input [7:0] PCmux_inB,		// mux 0
              ALUmux_inB,
	      DataMemmux_inB,
  output logic [7:0] PCmux,
  output logic [7:0] ALUmux,
  output logic [7:0] DataMemmux
  );
	 
always_comb begin

	PCmux = (PCmux_en) ? PCmux_inA : PCmux_inB;
	ALUmux = (ALUmux_en) ? ALUmux_inA : ALUmux_inB;
	DataMemmux = (DataMemmux_en) ? DataMemmux_inA : DataMemmux_inB;
end
endmodule