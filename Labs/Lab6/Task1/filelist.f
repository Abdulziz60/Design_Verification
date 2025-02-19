// contains the list of all the files
../Task1/alu.sv
../Task1/randtrans.sv
../Task1/alu_test.sv
../Task1/top.sv

# basic flags that we were using the previous labs as well 
-sverilog -timescale=1ns/10ps 


# Enable Coverage
-cm line+tgl+cond+branch+fsm+assert
