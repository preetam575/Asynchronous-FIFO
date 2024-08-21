 module read_handler_TMR #(POINTER_WIDTH=5) (
 input read_clock,
 input reset,
 input read_enable,
 input [ADRESSS_SIZE:0] synch_wgpointer,
 output [ADRESSS_SIZE-1:0]read_address,
 output [ADRESSS_SIZE:0] read_pointer,
 output read_empty);
 wire [ADRESSS_SIZE:0] read_pointer1,read_pointer2,read_pointer3;
 wire [ADRESSS_SIZE-1:0] read_address1,read_address2,read_address3;
 wire read_empty,read_empty2,read_empty3;
 localparam POINT_WIDTH=POINTER_WIDTH
 read_handler #(.POINTER_WIDTH(POINT_WIDTH)) u1(
 .read_clock(read_clock),
 .reset(reset),
 .read_enable(read_enable),
 .synch_wgpointer(synch_wgpointer),
 .read_address(read_address1),
 .read_pointer( read_pointer1),
 .read_empty(read_empty1));
 read_handler #(.POINTER_WIDTH(POINT_WIDTH)) u2(
 .read_clock(read_clock),
 .reset(reset),
 .read_enable(read_enable),
 .synch_wgpointer(synch_wgpointer),
 .read_address(read_address2),
 .read_pointer( read_pointer2),
 .read_empty(read_empty2));
 read_handler #(.POINTER_WIDTH(POINT_WIDTH)) u3(
 .read_clock(read_clock),
 .reset(reset),
 .read_enable(read_enable),
 .synch_wgpointer(synch_wgpointer),
 .read_address(read_address3),
 .read_pointer( read_pointer3),
 .read_empty(read_empty3));
 majority_voter #(.DATA_WIDTH(POINT_WIDTH+1)) u1(
 .module1(read_address1),
 .module2(read_address2),
 .module3(read_address3),
 .final_data(write_address));
 majority_voter #(.DATA_WIDTH(POINT_WIDTH+1)) u2(
 .module1(read_pointer1),
 .module2(read_pointer2),
 .module3(read_pointer3),
 .final_data(write_pointer));
majority_voter #(.DATA_WIDTH(POINT_WIDTH+1)) u3(
 .module1(read_empty1),
 .module2(read_empty2),
 .module3(read_empty3),
 .final_data(read_empty));
 endmodule
