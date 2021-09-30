all: t1 t2 t3 t4 t5

t1:
	yosys -p "read_verilog bus.v" -p "hierarchy -check -top bus" -p " proc; opt; fsm; opt; memory; opt" -p "techmap; opt" -p "dfflibmap -liberty cmos_cells.lib" -p "abc -liberty cmos_cells.lib" -p "clean" -p "write_verilog bus_synth.v"
	
t2:
	sed -i 's/bus/bus_synth/' bus_synth.v
t3:
	iverilog -o Bin BancoPruebas.v cmos_cells.v
t4:
	vvp Bin 
t5:
	gtkwave diagrama.vcd
clean:
	rm -r *.out *.o *.vcd Bin