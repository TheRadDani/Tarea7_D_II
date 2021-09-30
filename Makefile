all: t

t:
	iverilog -o Bin BancoPruebas.v cmos_cells.v
	vvp Bin 
	gtkwave diagrama.vcd
clean:
	*.out *.o *.vcd Bin