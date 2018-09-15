`timescale 1ns / 1ps

module vgaController(clk, hsync, vsync,vga_red,vga_green,vga_blue);

output hsync, vsync,vga_red,vga_green,vga_blue;
input clk;

reg[9:0] vcount=0;
reg[9:0] hcount=0;

reg venable;

wire clkout;

parameter hmax=800;
parameter vmax= 521;

freqdev M1(clk,clkout);

always@(posedge clkout)
begin
	if(hcount<hmax-1)
	begin
		hcount<=hcount+1'b1;
		venable<=1'b0;
	end
	else begin
		hcount<=0;
		venable<=1'b1;
	end

end

assign hsync=(hcount<96)?0:1;

always@(posedge clkout)
begin

if(venable==1)
begin
	if(vcount<vmax-1)
	begin
		vcount<=vcount+1'b1;
	end
	else begin
		vcount<=0;
	end

end

end

assign vsync=(vcount<2)?0:1;

assign vga_red=1;
assign vga_green=1;
assign vga_blue=1;

endmodule

module freqdev(clk1, clkout);
input clk1;
output reg clkout=1'b0;


always@(posedge clk1)
begin
clkout=~clkout;
end

endmodule 