 module write_handler_TMR #(ADDRESS_SIZE=5) (
 input write_clock,
 input reset,
 input write_enable,
 input [ADRESSS_SIZE:0] synch_rgpointer,
 output [ADRESSS_SIZE-1:0]write_address,
 output [ADRESSS_SIZE:0] write_pointer,
 output write_full);
 wire [ADRESSS_SIZE:0] write_pointer1,write_pointer2,write_pointer3;
 wire [ADRESSS_SIZE-1:0] write_address1,write_address2,write_address3;
 wire write_full1,write_full2,write_full3;
 localparam POINT_WIDTH=ADDRESS-SIZE
 write_handler #(.ADDRESS_SIZE(POINT_WIDTH)) u1(
 .write_clock(write_clock),
 .reset(reset),
 .write_enable(write_enable),
 .synch_rgpointer(synch_rgpointer),
 .write_address(write_address1),
 .write_pointer( write_pointer1),
 .write_full(write_full1));
 write_handler #(.ADDRESS_SIZE(POINT_WIDTH)) u2(
 .write_clock(write_clock),
 .reset(reset),
 .write_enable(write_enable),
 .synch_rgpointer(synch_rgpointer),
 .write_address(write_address2),
 .write_pointer( write_pointer2),
 .write_full(write_full2));
 write_handler #(.ADDRESS_SIZE(POINT_WIDTH)) u3(
 .write_clock(write_clock),
 .reset(reset),
 .write_enable(write_enable),
 .synch_rgpointer(synch_rgpointer),
 .write_address(write_address3),
 .write_pointer( write_pointer3),
 .write_full(write_full3));
 majority_voter #(.DATA_WIDTH(POINT_WIDTH+1)) u1(
.module1(write_address1),
 .module2(write_address2),
 .module3(write_address3),
 .final_data(write_address));
 majority_voter #(.DATA_WIDTH(POINT_WIDTH+1)) u2(
 .module1(write_pointer1),
 .module2(write_pointer2),
 .module3(write_pointer3),
 .final_data(write_pointer));
 majority_voter #(.DATA_WIDTH(POINT_WIDTH+1)) u3(
 .module1(write_full1),
 .module2(write_full2),
 .module3(write_full3),
 .final_data(write_full));
 endmodule
