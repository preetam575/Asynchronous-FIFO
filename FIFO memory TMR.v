 module fifo_memory_TMR #(parameter WIDTH_SIZE=64,ADDRESS_SIZE=10) (
 input write_enable,
 input write_clk,
 input write_full,
 input [ADDRESS_SIZE-1:0] write_address,
 input [ADDRESS_SIZE-1:0] read_address,
 input [WIDTH_SIZE-1:0] write_data,
 output [WIDTH_SIZE-1:0] read_data);
 localparam WIDTH=WIDTH_SIZE;
 localparam ADDRESS=ADDRESS_SIZE;
 wire [WIDTH_SIZE-1:0] read_data1,read_data2,read_data3;
 fifo_memory #(.WIDTH_SIZE(WIDTH),.ADDRESS_SIZE(ADDRESS)) u1(
 .write_enable(write_enable),
 .write_clk(write_clk),
 .write_full(write_full),
 .write_address( write_address),
 .read_address(read_address),
 .write_data(write_data),
 .read_data(read_data1));
 fifo_memory #(.WIDTH_SIZE(WIDTH),.ADDRESS_SIZE(ADDRESS)) u2(
 .write_enable(write_enable),
 .write_clk(write_clk),
 .write_full(write_full),
 .write_address( write_address),
 .read_address(read_address),
 .write_data(write_data),
 .read_data(read_data2));
 fifo_memory #(.WIDTH_SIZE(WIDTH),.ADDRESS_SIZE(ADDRESS)) u3(
 .write_enable(write_enable),
 .write_clk(write_clk),
 .write_full(write_full),
 .write_address( write_address),
 .read_address(read_address),
 .write_data(write_data),
 .read_data(read_data3));
 majority_voter #(.DATA_WIDTH(WIDTH)) u1(
 input module1(read_data1),
 input module2(read_data2),
 input module3(read_data3),
 output final_data(read_data));
 Endmodule
