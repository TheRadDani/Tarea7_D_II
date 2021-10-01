all: t1 t2 t3 t4 t5 t6 t7

t1:
	yosys -p "read_verilog bus.v" -p "hierarchy -check -top bus" -p " proc; opt; fsm; opt; memory; opt" -p "techmap; opt" -p "dfflibmap -liberty cmos_cells.lib" -p "abc -liberty cmos_cells.lib" -p "clean" -p "write_verilog bus_synth.v"
	
t2:
	sed -i 's/bus/bus_synth/' bus_synth.v
t3:
	yosys -p "read_verilog fsm.v" -p "hierarchy -check -top fsm" -p " proc; opt; fsm; opt; memory; opt" -p "techmap; opt" -p "dfflibmap -liberty cmos_cells.lib" -p "abc -liberty cmos_cells.lib" -p "clean" -p "write_verilog fsm_synth.v"
t4:
	 sed -i 's/fsm/fsm_synth/' fsm_synth.v
t5:
	iverilog -o Bin BancoPruebas.v cmos_cells.v
t6:
	vvp Bin
t7:
	gtkwave diagrama.vcd
clean:
	rm -r *.out *.o *.vcd Bin