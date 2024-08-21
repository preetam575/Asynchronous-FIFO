 module read_handler #(parameter ADRESSS_SIZE=5)(
 input read_clock,
 input reset,
 input read_enable,
 input [ADRESSS_SIZE:0] synch_wgpointer,
 output [ADRESSS_SIZE-1:0]read_address,
 output reg [ADRESSS_SIZE:0] read_pointer,
 output reg read_empty);
 localparam ADDSIZE=ADDRESS_SIZE;
 reg [ADRESSS_SIZE:0]binary;
 wire [ADRESSS_SIZE:0]binary_next,gray_next,synch_wpointer;
 wire Write_full_value;
 gray_to_binary #(.DATA_WIDTH(ADDSIZE)) u1(.gray(synch_wgpointer),.binary(synch_wpointer));
 always@(posedge read_clock or negedge reset) begin
if(!reset)begin
 binary<=0;
 read_pointer<=0;
 end
 else begin
 binary<= binary_next;
 read_pointer<=gray_next;
 end
 end
 assign read_address= binary[ADRESSS_SIZE-1:0];
 assign binary_next= ( read_enable && !read_empty) ? (binary + 1) : binary;
 assign gray_next= (binary_next>>1) ^ binary_next;
 assign read_empty_value= (binary_next==synch_wpointer)? 1: 0;
 always@(posedge write_clock or negedge reset) begin
 if(!reset)begin
 read_empty<=0;
 end
 else begin
 read_empty<=read_empty_value;
 end
 end
 endmodule
