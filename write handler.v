 module write_handler #(parameter ADRESSS_SIZE=5)(
 input write_clock,
 input reset,
 input write_enable,
 input [ADRESSS_SIZE:0] synch_rgpointer,
 output [ADRESSS_SIZE-1:0]write_address,
 output reg [ADRESSS_SIZE:0] write_pointer,
 output reg write_full);
localparam ADDSIZE=ADDRESS_SIZE;
 reg [ADRESSS_SIZE:0]binary;
 wire [ADRESSS_SIZE:0]binary_next,gray_next,synch_rpointer;
 wire Write_full_value;
 gray_to_binary #(.DATA_WIDTH(ADDSIZE)) u1(.gray(synch_rgpointer),.binary(synch_rpointer));
 always@(posedge write_clock or negedge reset) begin
 if(!reset)begin
 binary<=0;
 write_pointer<=0;
 end
 else begin
 binary<= binary_next;
 write_pointer<=gray_next;
 end
 end
 assign write_address= binary[ADRESSS_SIZE-1:0];
 assign binary_next= ( write_enable && !write_full) ? (binary + 1) : binary;
 assign gray_next= (binary_next>>1) ^ binary_next;
 assign Write_full_value= (binary_next=={~synch_rpointer[ADDRESS_SIZE],synch_rpointer[ADDRESS_SIZE-1:0]))? 1:
 0;
 always@(posedge write_clock or negedge reset) begin
 if(!reset)begin
 write_full<=0;
 end
 else begin
 write_full<=Write_full_value;
 end
 end
 endmodule
