 module synchroniser #(parameter POINTER_WIDTH=4)(
 input clk,
 input reset,
 input [POINTER_WIDTH-1:0]data_in,
 output reg [POINTER_WIDTH-1:0]data_out);
 reg [POINTER_WIDTH-1:0] int_data;
 always @(posedge clk or negedge reset) begin
 if(!reset) begin
 int_data<= 0;
 data_out<=0;
 end
 else begin
 int_data<=data_in;
 data_out<=int_data;
 end
 end
 endmodule
