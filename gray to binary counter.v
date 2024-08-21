module gray_to_binary #(parameter DATA_WIDTH=6)(
input [DATA_WIDTH-1:0] gray,
 output [DATA_WIDTH-1:0] binary);
 assign binary[DATA_WIDTH-1]= gray[DATA_WIDTH-1];
 integer i;
 always@(gray) begin
 for(i=DATA_WIDTH-2;i>=0;i=i-1) begin
 binary[i]=binary[i+1]^gray[i];
 end
 end
 endmodule
