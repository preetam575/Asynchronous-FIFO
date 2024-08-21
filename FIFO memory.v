 module fifo_memory #(parameter WIDTH_SIZE= 64, ADDRESS_SIZE=5)(
 input write_enable,
 input write_clk,
 input write_full,
 input [ADDRESS_SIZE-1:0] write_address,
 input [ADDRESS_SIZE-1:0] read_address,
 input [WIDTH_SIZE-1:0] write_data,
 output [WIDTH_SIZE-1:0] read_data);
 localparam DEPTH= 1<<ADDRESS_SIZE;
 reg [WIDTH_SIZE-1:0] memory [DEPTH-1:0];
 always@(posedge write_clk) begin
 if(write_enable && !write_full) begin
 memory[write_address]<= write_data;
 end
 end
 assign read_data= memory[read_address];
 endmodule
