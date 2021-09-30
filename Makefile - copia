all: t1 t2 t3 t4 t5 t6 t7 t8 t9 t10
t1:
	yosys -p "read_verilog mux_conductual.v" -p "hierarchy -check -top mux_conductual" -p " proc; opt; fsm; opt; memory; opt" -p "techmap; opt" -p "show" -p "write_verilog synth.v"
t2:
	sed -i 's/mux_conductual/synth/' synth.v
t3:
	iverilog -o Bin1 Banco_Pruebas_2.v
t4:
	vvp Bin1
t5:
	gtkwave test_2.vcd
t6:
	yosys -p "read_verilog mux_conductual.v" -p "hierarchy -check -top mux_conductual" -p " proc; opt; fsm; opt; memory; opt" -p "techmap; opt" -p "dfflibmap -liberty cmos_cells.lib" -p "abc -liberty cmos_cells.lib" -p "show" -p "clean" -p "write_verilog synth.v"
t7:
	sed -i 's/mux_conductual/synth/' synth.v
t8:
	iverilog -o Bin2 Banco_Pruebas_2.v cmos_cells.v
t9:
	vvp Bin2
t10:
	gtkwave test_2.vcd
clean:
	rm -r *.vcd .*o *.out Bin1 Bin2 synth.v