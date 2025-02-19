

example1:
	vcs -full64 -debug_access+all -sverilog example1.sv -R -l example1.log
	urg -dir simv.vdb
	#urg -dir simv.vdb -group show_in_design


example2:
	vcs -full64 -debug_access+all -sverilog example2.sv -R -l example2.log -cm_dir example2.vdb 
	urg -dir example2.vdb -report example2_report


example3:
	vcs -full64 -debug_access+all -sverilog example3.sv -R -l example3.log -cm_dir example3.vdb
	urg -dir example3.vdb -report example3_report


example4:
	vcs -full64 -debug_access+all -sverilog example4.sv -R -l example4.log -cm_dir example4.vdb
	urg -dir example4.vdb -report example4_report


example5:
	vcs -full64 -debug_access+all -sverilog example5.sv -R -l example5.log -cm_dir example5.vdb
	urg -dir example5.vdb -report example5_report


example6:
	vcs -full64 -debug_access+all -sverilog example6.sv -R -l example6.log -cm_dir example6.vdb
	urg -dir example6.vdb -report example6_report

i2c:
	vcs -full64 -debug_access+all -sverilog i2c_master.sv test_i2c_master.sv -R -l i2c.log -cm_dir i2c.vdb -cm line+branch+cond+fsm+tgl
	urg -dir i2c.vdb -report i2c_report

mult:
	vcs -full64 -debug_access+all -sverilog mult.sv tb_mult.sv -R -l mult.log -cm_dir mult.vdb
	urg -dir mult.vdb -report mult_report


clean:
	rm -rf simv* csrc simv.vdv urgReport *.log *.vcd *.vpd *.key
