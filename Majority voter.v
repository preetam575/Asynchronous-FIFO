module majority_voter #(parameter DATA_WIDTH=64)(
  input [DATA_WIDTH-1:0] module1,
  input [DATA_WIDTH-1:0] module2,
  input [DATA_WIDTH-1:0] module3,
  output [DATA_WIDTH-1:0] final_data);
  
  assign final_data=(module1==module2)?module1:module3;
  
endmodule
