 module top_module (
 input write_clk,
 input read_clk,
 input reset,
 input write_enable,
 input read_enable,
 input [63:0] write_data,
 output[63:0] read_data,
 output write_full,
 output read_empty);
 wire [9:0] write_address,read_address;
 wire [10:0] write_to_synch,synch_to_read,read_to_synch,synch_to_read;
 fifo_memory_TMR #(.WIDTH_SIZE(64),.ADDRESS_SIZE(10)) u1(
 .write_enable(write_enable),
 .write_clk(write_clk),
 .reset(reset),
 .write_full(write_full),
 .write_data(write_data),
 .read_data(read_data),
 .write_address(write_address),
 .read_address(read_address));
 write_handler_TMR #(.ADDRESS_SIZE(10)) u2(
 .write_clk(write_clk),
 .reset(reset),
 .write_enable(write_enable),
 .write_full(write_full),
 .write_address(write_address),
 .write_pointer(write_to_synch),
 .synch_rgpointer(synch_to_write));
 read_handler_TMR #(.ADDRESS_SIZE(10)) u3(
 .read_clk(read_clk),
 .reset(reset),
 .read_enable(read_enable),
 .read_empty(read_empty),
 .read_address(read_address),
 .read_pointer(read_to_synch),
 .synch_wgpointer(synch_to_read));
 synchroniser #(.POINTER_WIDTH(11)) u4(
 .clk(write_clk),
 .reset(reset),
 .data_in(read_to_synch),
 .data_out(synch_to_write));
 synchroniser #(.POINTER_WIDTH(11)) u5(
 .clk(read_clk),
 .reset(reset),
.data_in(write_to_synch),
 .data_out(synch_to_read));
 endmodule
